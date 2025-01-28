import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:os_basecode/os_basecode.dart';

class DeleteConfirmationWidget extends StatelessWidget {
  const DeleteConfirmationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/sad.png",
            width: 0.3.sw,
          ),
          10.verticalSpacingRadius,
          Text(
            "We're sad to see you go!",
            style: bebasNeue.copyWith(fontSize: 25.spMin),
          ),
          5.verticalSpacingRadius,
          Text(
            "If you delete your account, you’ll lose all your data, points, and rewards permanently.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsOverflowDirection: VerticalDirection.down,
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actions: [
        FilledButton(
            onPressed: () {
              context.pop();
            },
            child: Text("Nevermind, Keep It!")),
        TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {},
            child: Text("Yes, Delete my Account"))
      ],
    );
  }
}
