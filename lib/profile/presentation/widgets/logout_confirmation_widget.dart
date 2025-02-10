import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/logout_member_bloc/logout_member_bloc.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:os_basecode/os_basecode.dart';

class LogoutConfirmationWidget extends StatelessWidget {
  const LogoutConfirmationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutMemberBloc, LogoutMemberState>(
      listener: (context, state) async {
        if (state is LogoutMemberSuccess) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.clear().then(
            (value) {
              if (!context.mounted) return;
              context.go("/login");
            },
          );
        } else if (state is LogoutMemberFailure) {
          showError(state.message, context);
        }
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logout.png",
              width: 0.3.sw,
            ),
            10.verticalSpacingRadius,
            Text(
              context.l10n.logout_dialog_title,
              style: bebasNeue.copyWith(fontSize: 25.spMin),
            ),
            5.verticalSpacingRadius,
            Text(
              context.l10n.logout_dialog_subtitle,
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
              child: Text(context.l10n.logout_dialog_negavite)),
          TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                context.read<LogoutMemberBloc>().add(DoLogoutMember());
              },
              child: Text(context.l10n.logout_dialog_positive))
        ],
      ),
    );
  }
}
