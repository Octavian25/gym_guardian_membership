import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';

import 'package:gym_guardian_membership/verify_account/presentation/widgets/otp_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "VERIFY ACCOUNT",
              style: bebasNeue.copyWith(fontSize: 30.spMin),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Verify your account by entering verification code we sent to ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: " johnwelles@gmail.com",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
              ]),
            ),
            39.verticalSpacingRadius,
            Center(child: OtpWidget()),
            25.verticalSpacingRadius,
            Center(
              child: Text(
                "RESEND",
                style: TextStyle(fontSize: 14),
              ),
            ),
            35.verticalSpacingRadius,
            PrimaryButton(
              title: "RESET PASSWORD",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
