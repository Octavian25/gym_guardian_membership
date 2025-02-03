import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/workout_recommendation/data/models/exercise_model.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:y_player/y_player.dart';

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({
    super.key,
    required this.exerciseModel,
  });

  final ExerciseModel exerciseModel;

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late String youtubeURL;

  @override
  void initState() {
    youtubeURL = widget.exerciseModel.youtubeURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: YPlayer(
              youtubeUrl: youtubeURL,
              autoPlay: true,
              bottomButtonBarMargin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              seekBarMargin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              loadingWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  10.verticalSpacingRadius,
                  Text(
                    "Menyiapkan Video..",
                  )
                ],
              ),
              errorWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/error.png",
                    width: 0.3.sw,
                  ),
                  5.verticalSpacingRadius,
                  Text(
                    "Ada Kendala Saat Meminta Video Referensi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  5.verticalSpacingRadius,
                  SizedBox(
                      width: 0.5.sw,
                      child: FilledButton(
                        style: FilledButton.styleFrom(visualDensity: VisualDensity.compact),
                        onPressed: () {},
                        child: Text(
                          "Minta Ulang Video",
                          style: bebasNeue.copyWith(color: Colors.white, fontSize: 18.spMin),
                        ),
                      ))
                ],
              ),
            ),
          ),
          10.verticalSpacingRadius,
          Text(
            "Tutorial Cara Menggunakan Alat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.spMin),
          ),
          SizedBox(
            width: 0.8.sw,
            child: Text(
              "**Jika kamu ragu, silahkan bertanya kepada Personal Trainer atau staff pengelola tentang cara penggunaannya",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.spMin, color: Colors.black54),
            ),
          ),
          40.verticalSpacingRadius,
          PrimaryButton(
            title: "Tutup",
            onPressed: () {
              context.pop();
            },
          ),
          20.verticalSpacingRadius,
        ],
      ),
    );
  }
}
