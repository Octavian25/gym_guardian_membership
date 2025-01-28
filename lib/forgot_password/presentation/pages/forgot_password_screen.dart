import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_text_form_field.dart';
import 'package:os_basecode/os_basecode.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
              "FORGOT PASSWORD!",
              style: bebasNeue.copyWith(fontSize: 30.spMin),
            ),
            Text(
              "Please enter your email below to receive your password reset code.",
            ),
            39.verticalSpacingRadius,
            CustomTextFormField(
              controller: emailController,
              title: "Email Address",
            ),
            35.verticalSpacingRadius,
            PrimaryButton(
              title: "RESET PASSWORD",
              onPressed: () {
                context.go("/login/forgot-password/verify-otp");
              },
            ),
          ],
        ),
      ),
    );
  }
}
