import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/gradient_progress_bar.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RestCountdownWidget extends StatefulWidget {
  final int initialTimeInSeconds;
  final String title;
  final Function() onTimerComplete;
  const RestCountdownWidget(
      {super.key,
      required this.initialTimeInSeconds,
      required this.title,
      required this.onTimerComplete});

  @override
  RestCountdownWidgetState createState() => RestCountdownWidgetState();
}

class RestCountdownWidgetState extends State<RestCountdownWidget> {
  late int _remainingTime;
  late int _elapsedTime;

  Timer? _timer;
  bool _isRunning = false;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialTimeInSeconds;
    _elapsedTime = 0; // Mulai dari 0
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      log("START LISTENING INIT SPEECH", name: "VOICE RECORGNIZER");
      _startListening();
    }
  }

  void _stopListening() {
    _speech.stop();
    _speech.initialize().then((available) {
      if (available) {
        log("START LISTENING DARI STOP LISTENING", name: "VOICE RECORGNIZER");
        _startListening();
      } else {
        // Handle jika inisialisasi gagal
      }
    });
  }

  void _startListening() async {
    log("TITLE : ${widget.title}", name: "VOICE RECORGNIZER");
    if (!widget.title.contains("Set")) {
      return;
    }
    if (!_isListening) {
      _isListening = true;
      log("IM LISTENING", name: "VOICE RECORGNIZER");
      await _speech.listen(onResult: (result) {
        String recognized = result.recognizedWords.toLowerCase();
        log(recognized, name: "VOICE RECORGNIZER");
        if (recognized.contains("mulai") || recognized.contains("play")) {
          _triggerStartCountdown(); // Panggil fungsi trigger
        }
      });
    }
  }

  void _triggerStartCountdown() {
    if (_debounceTimer?.isActive ?? false) {
      // Cek apakah timer sedang aktif
      _debounceTimer!.cancel(); // Batalkan timer yang sedang berjalan
    }

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      startCountdown(); // Panggil startCountdown setelah 2 detik
      _debounceTimer = null; // Reset timer
    });
  }

  void startCountdown() {
    log("_isRunning status : $_isRunning", name: "VOICE RECORGNIZER");
    if (_isRunning) return;
    log("MULAI STOP LISTENING VOICE", name: "VOICE RECORGNIZER");
    _stopListening();
    log("SELESAI STOP LISTENING VOICE", name: "VOICE RECORGNIZER");
    setState(() {
      _isRunning = true;
      _isListening = false;
    });
    log("MEMULAI TIMER", name: "VOICE RECORGNIZER");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedTime < widget.initialTimeInSeconds) {
        setState(() {
          _elapsedTime++;
          _remainingTime = widget.initialTimeInSeconds - _elapsedTime;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
          _isListening = false;
        });
        widget.onTimerComplete();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  double _progress() {
    return _elapsedTime / widget.initialTimeInSeconds;
  }

  void resetProgress() {
    setState(() {
      _elapsedTime = widget.initialTimeInSeconds;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech.stop();
    _isListening = false;
    _isRunning = false;
    _debounceTimer?.cancel(); // Batalkan timer debounce saat widget di-dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              Text(
                _formatTime(_remainingTime),
                style: bebasNeue.copyWith(fontSize: 20.spMin, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GradientProgressBar(
            progress: _progress(),
            filledColor: primaryColor,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                    onPressed: _isRunning ? null : startCountdown,
                    icon: Icon(Icons.play_circle_fill_outlined)),
                if (_remainingTime == 0)
                  FilledButton.icon(
                    onPressed: resetProgress,
                    label: Text(context.l10n.next_set),
                    icon: Icon(Icons.skip_next_outlined),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
