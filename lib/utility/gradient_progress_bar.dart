import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

class GradientProgressBar extends StatelessWidget {
  final double progress; // Nilai antara 0.1 - 1
  final int totalBars;
  final double barWidth;
  final double barHeight;
  final Color filledColor;
  final Color unfilledColor;

  const GradientProgressBar({
    super.key,
    required this.progress, // Dari 0.1 sampai 1.0 (100%)
    this.totalBars = 20, // Total bar tetap
    this.barWidth = 14, // Lebar tiap bar
    this.barHeight = 35, // Tinggi tiap bar
    this.filledColor = Colors.blue, // Warna bar aktif
    this.unfilledColor = Colors.black12, // Warna bar yang kosong
  });

  @override
  Widget build(BuildContext context) {
    // Hitung jumlah bar yang harus terisi berdasarkan progress (0.1 - 1)
    int filledBars = (progress * totalBars).round();

    return LayoutBuilder(
        builder: (context, constraints) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalBars, (index) {
                return AnimatedContainer(
                  duration: 500.milliseconds,
                  width: constraints.maxWidth / 20 - 5,
                  height: barHeight + (index < filledBars ? filledBars / totalBars * 6 : 0),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: index < filledBars
                        ? filledColor.withValues(
                            alpha: 1 - (((index) / totalBars) - 0.15)) // Efek gradasi
                        : unfilledColor,
                    borderRadius: BorderRadius.circular(10), // Membuat rounded effect
                  ),
                );
              }),
            ));
  }
}
