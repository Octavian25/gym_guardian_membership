import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/gradient_progress_bar.dart';
import 'package:os_basecode/os_basecode.dart';

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

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialTimeInSeconds;
    _elapsedTime = 0; // Mulai dari 0
  }

  void startCountdown() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

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
                    label: Text("Set Selanjutnya"),
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
