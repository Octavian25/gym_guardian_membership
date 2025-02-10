import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
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
            context.l10n.delete_account_title,
            style: bebasNeue.copyWith(fontSize: 25.spMin),
          ),
          5.verticalSpacingRadius,
          Text(
            context.l10n.delete_account_subtitle,
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
            child: Text(context.l10n.delete_account_positive)),
        TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {},
            child: Text(context.l10n.delete_account_negative))
      ],
    );
  }
}
