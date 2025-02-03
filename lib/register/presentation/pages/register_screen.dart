import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/preview_registration_bloc/preview_registration_bloc.dart';
import 'package:gym_guardian_membership/pricing_plan/presentation/bloc/fetch_all_pricing_plan_bloc/fetch_all_pricing_plan_bloc.dart';
import 'package:gym_guardian_membership/utility/custom_select_field.dart';
import 'package:gym_guardian_membership/utility/custom_text_form_field.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:os_basecode/os_basecode.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ScrollController scrollController = ScrollController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final TextEditingController genderController = TextEditingController(text: "Pria");
  final TextEditingController goalController = TextEditingController(text: "Membentuk Otot");
  final TextEditingController activityLevelController =
      TextEditingController(text: "Jarang Olahraga");
  final TextEditingController workoutPreferenceController =
      TextEditingController(text: 'Latihan Di Gym');
  final TextEditingController workoutDurationController =
      TextEditingController(text: '15-30 Menit');
  final TextEditingController workoutAtController = TextEditingController(text: 'Pagi Hari');
  final TextEditingController specialConditionController = TextEditingController(text: 'Tidak Ada');
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController motivationController = TextEditingController(text: 'Kesehatan');
  String gender = "Pria";
  String goal = "Membentuk Otot";
  String activityLevel = "Jarang Olahraga";
  String workoutPreference = 'Latihan Di Gym';
  String workoutDuration = '15-30 Menit';
  String workoutAt = 'Pagi Hari';
  String specialCondition = 'Tidak Ada';
  String motivation = 'Kesehatan';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<FetchAllPricingPlanBloc>().add(DoFetchAllPricingPlan());
      },
    );
  }

  GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  void handleRegistration() async {
    if (registrationKey.currentState!.validate()) {
      if (passwordController.text != repasswordController.text) {
        showError("Password tidak sama", context);
        return;
      }
      PreviewRegistrationEntity previewRegistrationEntity = PreviewRegistrationEntity(
          emailAddress: emailController.text,
          password: passwordController.text,
          fullName: fullNameController.text,
          phoneNumber: phoneController.text,
          activityLevel: activityLevel,
          age: getNumberOnly(ageController.text),
          gender: gender,
          goal: goal,
          height: getNumberOnly(heightController.text),
          motivation: motivation,
          weight: getNumberOnly(weightController.text),
          workoutAt: workoutAt,
          workoutDuration: workoutDuration,
          workoutPreference: workoutPreference,
          specialCondition: specialCondition,
          condition: conditionController.text,
          selectedPricingPlan: null);
      context
          .read<PreviewRegistrationBloc>()
          .add(DoSavePreviewRegistration(previewRegistrationEntity));
      context.go("/login/register/pricing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Daftar Member Baru",
                style: bebasNeue.copyWith(fontSize: 30.spMin),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Silahkan masukan data diri anda",
              ),
            ),
          ),
          SliverToBoxAdapter(child: 23.verticalSpacingRadius),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: registrationKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informasi Pribadi",
                      style: bebasNeue.copyWith(fontSize: 20.spMin),
                    ),
                    Divider(),
                    10.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: fullNameController,
                      title: "Nama Lengkap",
                      isRequired: true,
                      textInputAction: TextInputAction.done,
                    ),
                    16.verticalSpacingRadius,
                    Row(
                      children: [
                        Expanded(
                          child: CustomSelectField<String>(
                            controller: genderController,
                            title: "Jenis Kelamin",
                            isRequired: true,
                            selected: gender,
                            textInputAction: TextInputAction.next,
                            onSelect: (value) {
                              setState(() {
                                gender = value;
                                genderController.text = value;
                              });
                              context.pop();
                            },
                            options: ["Pria", "Wanita"],
                          ),
                        ),
                        16.horizontalSpaceRadius,
                        Expanded(
                          child: CustomTextFormField(
                            controller: ageController,
                            title: "Umur",
                            isRequired: true,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpacingRadius,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: heightController,
                            title: "Tinggi ( Cm )",
                            isRequired: true,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        16.horizontalSpaceRadius,
                        Expanded(
                          child: CustomTextFormField(
                            controller: weightController,
                            title: "Berat ( Kg )",
                            isRequired: true,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: phoneController,
                      title: "Nomor Telepon",
                      isRequired: true,
                      textInputType: TextInputType.phone,
                    ),
                    16.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: emailController,
                      title: "Alamat Email",
                      isRequired: true,
                      textInputType: TextInputType.emailAddress,
                    ),
                    16.verticalSpacingRadius,
                    Text(
                      "Informasi Umum",
                      style: bebasNeue.copyWith(fontSize: 20.spMin),
                    ),
                    Divider(),
                    10.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: goalController,
                      title: "Apa Tujuan Utam Anda ?",
                      isRequired: true,
                      selected: goal,
                      onSelect: (value) {
                        setState(() {
                          goal = value;
                          goalController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Menurunkan Berat Badan",
                        "Membentuk Otot",
                        "Meningkatkan Stamina atau Kebugaran",
                        "Relaksasi dan Fleksibilitas",
                        "Latihan Pemulihan Cedera"
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: activityLevelController,
                      title: "Seberapa aktif Anda sekarang ?",
                      isRequired: true,
                      selected: activityLevel,
                      onSelect: (value) {
                        setState(() {
                          activityLevel = value;
                          activityLevelController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Jarang Olahraga",
                        "Kadang Olahraga",
                        "Rutin Olahraga",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: workoutPreferenceController,
                      title: "Jenis latihan apa yang Anda sukai?",
                      isRequired: true,
                      selected: workoutPreference,
                      onSelect: (value) {
                        setState(() {
                          workoutPreference = value;
                          workoutPreferenceController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Latihan Di Gym",
                        "Cardio Intens",
                        "Kombinasi ( Gym dan Cardio )",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: workoutDurationController,
                      title: "Berapa lama waktu yang Anda miliki untuk latihan?",
                      isRequired: true,
                      selected: workoutDuration,
                      onSelect: (value) {
                        setState(() {
                          workoutDuration = value;
                          workoutDurationController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "15-30 Menit",
                        "30-60 Menit",
                        "60+ Menit",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: workoutAtController,
                      title: "Kapan Anda lebih sering berolahraga?",
                      isRequired: true,
                      selected: workoutAt,
                      onSelect: (value) {
                        setState(() {
                          workoutAt = value;
                          workoutAtController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Pagi Hari",
                        "Siang / Sore Hari",
                        "Malam hari",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: specialConditionController,
                      title: "Apakah anda memiliki kondisi khusus yang perlu diperhatikan?",
                      isRequired: true,
                      selected: specialCondition,
                      onSelect: (value) {
                        setState(() {
                          specialCondition = value;
                          specialConditionController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Tidak Ada",
                        "Cedera Tertentu",
                        "Masalah Kesehatan",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: conditionController,
                      title: "Jika ada, tuliskan kondisi khusus Anda",
                      isRequired: false,
                      enabled: specialCondition != "Tidak Ada",
                      textInputAction: TextInputAction.next,
                    ),
                    16.verticalSpacingRadius,
                    CustomSelectField<String>(
                      controller: motivationController,
                      title: "Apa motivasi terbesa Anda untuk memulai latihan?",
                      isRequired: true,
                      selected: motivation,
                      onSelect: (value) {
                        setState(() {
                          motivation = value;
                          motivationController.text = value;
                        });
                        context.pop();
                      },
                      options: [
                        "Kesehatan",
                        "Penampilan",
                        "Kebiasaan Hidup",
                        "Aktivitas Sosial",
                      ],
                    ),
                    16.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: passwordController,
                      title: "Kata Sandi",
                      isRequired: true,
                      obsecureText: true,
                    ),
                    16.verticalSpacingRadius,
                    CustomTextFormField(
                      controller: repasswordController,
                      title: "Ulang Kata Sandi",
                      isRequired: true,
                      obsecureText: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: 24.verticalSpacingRadius),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: PrimaryButton(
                title: "Lanjutkan",
                onPressed: handleRegistration,
              ),
            ),
          ),
          SliverToBoxAdapter(child: 24.verticalSpacingRadius),
          SliverToBoxAdapter(
            child: Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Sudah punya akun?", style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: " Masuk!",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go("/login");
                        },
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
          SliverToBoxAdapter(child: 30.verticalSpacingRadius),
        ],
      ),
    );
  }
}
