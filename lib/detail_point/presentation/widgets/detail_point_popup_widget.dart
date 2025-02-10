import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class DetailPointPopupWidget extends StatelessWidget {
  const DetailPointPopupWidget({
    super.key,
    required this.data,
  });

  final DatumPointHistoryEntity data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              data.pointIn >= 0 ? "assets/point_in.png" : "assets/point_out.png",
              width: 0.3.sw,
            ),
          ),
          10.verticalSpacingRadius,
          Text(
            context.l10n.description, // Changed "Description" to "Deskripsi"
            style: TextStyle(fontSize: 12.spMin),
          ),
          5.verticalSpacingRadius,
          Text(
            data.description,
            style: bebasNeue.copyWith(fontSize: 25.spMin),
          ),
          20.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.starting_point, // Changed "Initial Point" to "Poin Awal"
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  Text(
                    data.pointAwal.toString(),
                    style: bebasNeue.copyWith(fontSize: 25.spMin),
                  )
                ],
              )),
              if (data.pointIn >= 0)
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.entry_point, // Changed "Point In" to "Poin Masuk"
                      style: TextStyle(fontSize: 12.spMin),
                    ),
                    Text(
                      data.pointIn.toString(),
                      style: bebasNeue.copyWith(fontSize: 25.spMin),
                    )
                  ],
                )),
              if (data.pointOut > 0)
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.final_point, // Changed "Point Out" to "Poin Keluar"
                      style: TextStyle(fontSize: 12.spMin),
                    ),
                    Text(
                      data.pointOut.toString(),
                      style: bebasNeue.copyWith(fontSize: 25.spMin),
                    )
                  ],
                )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Poin Akhir", // Changed "Final Point" to "Poin Akhir"
                    style: TextStyle(fontSize: 12.spMin),
                  ),
                  Text(
                    data.pointAkhir.toString(),
                    style: bebasNeue.copyWith(fontSize: 20.spMin),
                  )
                ],
              ))
            ],
          ),
          20.verticalSpacingRadius,
        ],
      ),
    );
  }
}
