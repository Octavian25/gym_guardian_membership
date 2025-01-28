import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/homepage/data/models/workout_recommendation_model.dart';

import 'package:gym_guardian_membership/login/presentation/widgets/primary_button.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/preview_registration_bloc/preview_registration_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/bloc/workout_suggestions_bloc/workout_suggestions_bloc.dart';
import 'package:gym_guardian_membership/preview_registration/presentation/pages/term_and_condition.dart';
import 'package:gym_guardian_membership/register/domain/entities/register_request_entity.dart';
import 'package:gym_guardian_membership/register/presentation/bloc/register_member_bloc/register_member_bloc.dart';
import 'package:gym_guardian_membership/utility/base_sliver_padding.dart';
import 'package:gym_guardian_membership/utility/blurred_dialogue_widget.dart';

import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/custom_toast.dart';
import 'package:os_basecode/os_basecode.dart';

class PreviewRegistrationScreen extends StatefulWidget {
  const PreviewRegistrationScreen({super.key});

  @override
  State<PreviewRegistrationScreen> createState() => _PreviewRegistrationScreenState();
}

class _PreviewRegistrationScreenState extends State<PreviewRegistrationScreen> {
  ScrollController scrollController = ScrollController();
  bool acceptTermAndCondition = false;
  @override
  void initState() {
    super.initState();
  }

  void handleRegister() async {
    var previewState = context.read<PreviewRegistrationBloc>().state;
    if (previewState is PreviewRegistrationHasData) {
      RegisterRequestEntity registerRequestEntity = RegisterRequestEntity(
          memberName: previewState.previewRegistrationEntity.fullName,
          memberEmail: previewState.previewRegistrationEntity.emailAddress,
          noHandphone: previewState.previewRegistrationEntity.phoneNumber,
          password: previewState.previewRegistrationEntity.password,
          packageCode: previewState.previewRegistrationEntity.selectedPricingPlan!.packageCode,
          activityLevel: previewState.previewRegistrationEntity.activityLevel,
          age: previewState.previewRegistrationEntity.age,
          weight: previewState.previewRegistrationEntity.weight,
          height: previewState.previewRegistrationEntity.height,
          availableTime: previewState.previewRegistrationEntity.workoutAt,
          fitnessGoal: previewState.previewRegistrationEntity.goal,
          workoutPreferences: [previewState.previewRegistrationEntity.workoutPreference]);
      context.read<RegisterMemberBloc>().add(DoRegisterMember(registerRequestEntity));
    }
  }

  void handleGenerateWorkoutSuggestions(PreviewRegistrationEntity data) async {
    context.read<WorkoutSuggestionsBloc>().add(DoWorkoutSuggestions(data, null));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return WorkoutSuggestionResultWidget(
            data: data,
            handleReCreate: (customPromp) async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove("lastGeneratedResult");
              if (!context.mounted) return;
              context.read<WorkoutSuggestionsBloc>().add(DoWorkoutSuggestions(data, customPromp));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutSuggestionsBloc, WorkoutSuggestionsState>(
      listener: (context, state) {
        if (state is WorkoutSuggestionsSuccess) {}
      },
      child: Scaffold(
        body: BlocListener<RegisterMemberBloc, RegisterMemberState>(
          listener: (context, state) {
            if (state is RegisterMemberSuccess) {
              context.go("/login");
              showSuccess(state.datas, context);
              return;
            } else if (state is RegisterMemberFailure) {
              showError(state.message, context);
              return;
            }
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Periksa Kembali Data Anda",
                    style: bebasNeue.copyWith(fontSize: 30.spMin),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Silahkan periksa kembali data anda, jika sudah benar silahkan tekan daftar ",
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 23.verticalSpacingRadius),
              baseSliverPadding(
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<PreviewRegistrationBloc, PreviewRegistrationState>(
                    builder: (context, state) {
                      if (state is PreviewRegistrationHasData) {
                        PreviewRegistrationEntity data = state.previewRegistrationEntity;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: "Full Name",
                                    value: data.fullName,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Phone Number",
                                    value: data.phoneNumber,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Gender",
                                    value: data.gender,
                                  ),
                                )
                              ],
                            ),
                            InformationDetail(title: "Email", value: data.emailAddress),
                            Row(
                              children: [
                                Expanded(
                                    child: InformationDetail(
                                        title: "Age", value: data.age.toString())),
                                Expanded(
                                    child: InformationDetail(
                                        title: "Height (cm)", value: data.height.toString())),
                                Expanded(
                                    child: InformationDetail(
                                        title: "Weight (Kg)", value: data.weight.toString()))
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: "Goals",
                                    value: data.goal,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Activity Level",
                                    value: data.activityLevel,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: "Workout Preferences",
                                    value: data.workoutPreference,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Workout Duration",
                                    value: data.workoutDuration,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InformationDetail(
                                    title: "Preference Workout At",
                                    value: data.workoutAt,
                                  ),
                                ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Special Condition",
                                    value: data.specialCondition,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                if (data.condition != null)
                                  Expanded(
                                    child: InformationDetail(
                                      title: "Condition *",
                                      value: data.condition!,
                                    ),
                                  ),
                                Expanded(
                                  child: InformationDetail(
                                    title: "Motivation",
                                    value: data.motivation,
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: OutlinedButton.icon(
                                  icon: Icon(Icons.polyline_rounded),
                                  onPressed: () {
                                    handleGenerateWorkoutSuggestions(data);
                                  },
                                  label: Text("Generate Workout Suggestions")),
                            ),
                            Divider(),
                            Text(
                              "Paket Dipilih",
                              style: TextStyle(fontSize: 12.spMin),
                            ),
                            ListTile(
                              splashColor: primaryColor.withValues(alpha: 0.1),
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              title: Text(
                                data.selectedPricingPlan?.packageName ?? "-",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Durasi : ${data.selectedPricingPlan?.duration} Hari"),
                              leading: Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              ),
                              trailing: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    formatRupiah(data.selectedPricingPlan?.price.toDouble() ?? 0),
                                    style: bebasNeue.copyWith(fontSize: 20.spMin),
                                  )),
                            ),
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              value: acceptTermAndCondition,
                              onChanged: null,
                              title: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Saya setuju dengan",
                                    style: GoogleFonts.montserrat(color: Colors.black)),
                                TextSpan(
                                    text: " syarat dan ketentuan yang berlaku",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var result = await showBlurredBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BlurContainerWrapper(
                                              child: SizedBox(
                                                  height: 0.8.sh,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: TermsAndConditionsScreen(),
                                                  )),
                                            );
                                          },
                                        );
                                        if (result != null && result == true) {
                                          setState(() {
                                            acceptTermAndCondition = true;
                                          });
                                        }
                                      },
                                    style: GoogleFonts.montserrat(
                                        color: primaryColor, fontWeight: FontWeight.bold)),
                              ])),
                            )
                          ],
                        );
                      } else {
                        return Text("Terdapat kesalahan saat menampilkan data");
                      }
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: PrimaryButton(
                    title: "REGISTER",
                    onPressed: acceptTermAndCondition ? handleRegister : null,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: 30.verticalSpacingRadius),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutSuggestionResultWidget extends StatelessWidget {
  const WorkoutSuggestionResultWidget(
      {super.key, required this.data, required this.handleReCreate});
  final PreviewRegistrationEntity data;
  final Function(String promp) handleReCreate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<WorkoutSuggestionsBloc, WorkoutSuggestionsState>(
          builder: (context, state) {
            if (state is WorkoutSuggestionsSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rekomendasi Jadwal Dari Kami",
                      style: bebasNeue.copyWith(fontSize: 23.spMin),
                    ),
                    Text(
                      state.datas.notes,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 11.spMin,
                      ),
                    ),
                    Divider(),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.datas.weeklyPlan.length,
                      itemBuilder: (context, index) {
                        WeeklyPlan weeklyPlan = state.datas.weeklyPlan[index];
                        return Theme(
                          data: ThemeData().copyWith(
                              dividerColor: Colors.transparent,
                              textTheme: GoogleFonts.montserratTextTheme()),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            leading: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  weeklyPlan.workout.aktivitas
                                      .fold<int>(
                                        0,
                                        (previousValue, element) => previousValue + element.waktu,
                                      )
                                      .toString(),
                                  style: bebasNeue.copyWith(fontSize: 20.spMin),
                                ),
                                Text(
                                  "Menit",
                                  style: TextStyle(fontSize: 9.spMin),
                                )
                              ],
                            ),
                            title: Text(
                              weeklyPlan.day,
                              style: bebasNeue.copyWith(fontSize: 25.spMin),
                            ),
                            subtitle: Text(
                              "Sentuh Untuk Melihat Detail Rencana",
                              style: TextStyle(fontSize: 11.spMin, color: Colors.black38),
                            ),
                            children: weeklyPlan.workout.aktivitas.map((e) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.schedule,
                                  color: Colors.grey,
                                ),
                                title: Text(
                                  e.nama,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  e.deskripsi,
                                  style: TextStyle(fontSize: 11.spMin),
                                ),
                                trailing: Text(e.waktu.toString()),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    Text(
                      "**Gemini AI telah menyusun jadwal ini untuk membantu Anda mencapai tujuan fitness Anda.",
                      style: TextStyle(fontSize: 11.spMin),
                    ),
                    20.verticalSpacingRadius,
                    Center(
                      child: Text(
                        "Butuh rekomendasi lain yang lebih sesuai?",
                        style: TextStyle(fontSize: 12.spMin),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        child: Text("Buat Ulang Rekomendasi"),
                        onPressed: () async {
                          TextEditingController controller = TextEditingController();
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text("Ingin Lebih Personal ?"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        "Jika kamu ingin jadwal lebih personal seperti saya ingin hari libur pada senin dan selasa, atau perintah yang lainnya, silahkan tuliskan pada kolom dibawah"),
                                    TextFormField(
                                      controller: controller,
                                      decoration:
                                          InputDecoration(labelText: "Masukan Perintah Anda"),
                                    )
                                  ],
                                ),
                                actions: [
                                  PrimaryButton(
                                    title: "Buat Rekomendasi",
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                  SizedBox(
                                    width: 1.sw,
                                    child: TextButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: Text("Batal")),
                                  )
                                ],
                              );
                            },
                          );
                          handleReCreate(controller.text);
                        },
                      ),
                    ),
                    10.verticalSpacingRadius,
                    PrimaryButton(
                      title: "Simpan Rekomendasi",
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    20.verticalSpacingRadius,
                  ],
                ),
              );
            } else if (state is WorkoutSuggestionsFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/ai.png",
                    width: 0.4.sw,
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(period: 3.seconds),
                      )
                      .shimmer(
                        duration: 2.seconds,
                        delay: 1.seconds,
                      ),
                  10.verticalSpacingRadius,
                  SizedBox(
                    width: 0.7.sw,
                    child: Text(
                      "Tunggu Sebentar",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.spMin, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 0.7.sw,
                    child: Text(
                      "Kami sedang memikirkan rekomendasi terbaik untuk anda",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.spMin),
                    ),
                  ),
                  20.verticalSpacingRadius,
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class InformationDetail extends StatelessWidget {
  final String title;
  final String value;
  const InformationDetail({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 11.spMin),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14.spMin, fontWeight: FontWeight.bold),
        ),
        10.verticalSpacingRadius,
      ],
    );
  }
}
