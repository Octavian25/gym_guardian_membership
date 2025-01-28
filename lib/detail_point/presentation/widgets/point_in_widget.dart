import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/detail_point/domain/entities/point_history_entity.dart';
import 'package:gym_guardian_membership/detail_point/presentation/widgets/detail_point_popup_widget.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class PointInWidget extends StatelessWidget {
  final DatumPointHistoryEntity data;
  const PointInWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showBlurredBottomSheet(
          context: context,
          builder: (context) {
            return BlurContainerWrapper(child: DetailPointPopupWidget(data: data));
          },
        );
      },
      leading: Container(
        height: 35.h,
        width: 35.h,
        decoration:
            BoxDecoration(color: "#F5F5F5".toColor(), borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(5),
        child: Image.asset(
          "assets/point_in.png",
        ),
      ),
      trailing: Icon(Icons.chevron_right_outlined),
      title: Text(
        "${data.pointIn} Poin",
        style: TextStyle(fontSize: 14.spMin),
      ),
      subtitle: Text(
        data.description,
        style: TextStyle(fontSize: 12.spMin),
      ),
    );
  }
}
