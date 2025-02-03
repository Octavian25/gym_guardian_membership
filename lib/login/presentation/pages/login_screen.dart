import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/homepage/presentation/bloc/logout_member_bloc/logout_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/bloc/login_member_bloc/login_member_bloc.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_text_form_field.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:gym_guardian_membership/utility/show_bottom_dialog.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:os_updater/os_updater.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginState = GlobalKey<FormState>();

  void handleLogin() async {
    if (loginState.currentState!.validate()) {
      context
          .read<LoginMemberBloc>()
          .add(DoLoginMember(emailController.text.trim(), passwordController.text.trim()));
    }
  }

  void handleLoginWithGoogle() async {
    showBottomDialogueAlert(
        imagePath: "assets/sad.png",
        title: "Sorry",
        subtitle: "Login with google is under develop",
        duration: 3);
    // // Implement your Google login logic here
    // // For example, you can use Firebase Auth or any other method
    // try {
    //   // Example using Firebase Auth
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   if (googleUser == null) return; // The user canceled the sign-in

    //   context.go("/register", extra: googleUser);
    // } catch (e) {
    //   showError("Failed to sign in with Google: $e", context);
    // }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        removePreviousResult();
        if (Platform.isAndroid) {
          await UpdateManager.instance.checkForUpdate(
              "LoyalityMembership", // App name
              appVersion, // Current app version
              context // Context to display the dialog
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutMemberBloc, LogoutMemberState>(
      listener: (context, state) async {
        if (state is LogoutMemberSuccess) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.clear().then(
            (value) {
              if (value) {
                if (!context.mounted) return;
                context.go("/login");
              }
            },
          );
        } else if (state is LogoutMemberFailure) {
          showError(state.message, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<LoginMemberBloc, LoginMemberState>(
          listener: (context, state) async {
            if (state is LoginMemberFailure) {
              showError(state.message, context);
              if (state.message.contains("already logged in")) {
                showBottomConfirmationDialogueAlert(
                  imagePath: "assets/logout.png",
                  title: "You are already logged in on another device",
                  subtitle: "Do you want to log out from other device and log in from this device?",
                  handleConfirm: (context) {
                    context.read<LogoutMemberBloc>().add(DoForceLogout(emailController.text));
                    Navigator.pop(context);
                  },
                );
              }
              return;
            } else if (state is LoginMemberSuccess) {
              context.go("/homepage", extra: 'fetch');
              showSuccessWithoutButton("Selamat Datang Kembali, ${state.datas.userId}", context);
            }
          },
          child: Form(
            key: loginState,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SELAMAT DATANG DI LOYALTY MEMBERSHIP!",
                      style: bebasNeue.copyWith(fontSize: 30.spMin),
                    ),
                    Text(
                      "Silahkan login untuk lanjut kedalam aplikasi",
                    ),
                    39.verticalSpacingRadius,
                    CustomTextFormField(
                        controller: emailController,
                        title: "Alamat Email",
                        isRequired: true,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next),
                    14.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: passwordController,
                      title: "Kata Sandi",
                      obsecureText: true,
                      isRequired: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        handleLogin();
                      },
                    ),
                    // 16.verticalSpacingRadius,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         context.go("/login/forgot-password");
                    //       },
                    //       child: Text(
                    //         "Forgot Password?",
                    //         style: TextStyle(fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    35.verticalSpacingRadius,
                    PrimaryButton(
                      title: "MASUK",
                      onPressed: handleLogin,
                    ),
                    24.verticalSpacingRadius,
                    // Center(
                    //   child: Text(
                    //     "Or Login with",
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                    // 24.verticalSpacingRadius,
                    // ConnectWithGoogleButton(
                    //   onPressed: handleLoginWithGoogle,
                    // ),
                    // 24.verticalSpacingRadius,
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Belum punya akun? ", style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: " Daftar!",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go("/login/register");
                                },
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
