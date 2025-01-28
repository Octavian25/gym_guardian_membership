import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:os_basecode/os_basecode.dart';

class PointOutWidget extends StatelessWidget {
  final DatumPointHistoryEntity data;
  const PointOutWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        height: 35.h,
        width: 35.h,
        decoration:
            BoxDecoration(color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(5),
        child: Image.asset(
          "assets/point_out.png",
        ),
      ),
      trailing: Icon(Icons.chevron_right_outlined),
      title: Text(
        "${data.pointOut} Poin",
        style: TextStyle(fontSize: 14.spMin),
      ),
      subtitle: Text(
        data.description,
        style: TextStyle(fontSize: 12.spMin),
      ),
    );
  }
}
