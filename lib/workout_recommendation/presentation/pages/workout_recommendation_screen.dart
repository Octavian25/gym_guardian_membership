import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_guardian_membership/utility/constant.dart';
import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:gym_guardian_membership/utility/helper.dart';
import 'package:gym_guardian_membership/utility/show_bottom_confirmation_dialog.dart';
import 'package:gym_guardian_membership/workout_recommendation/data/models/exercise_model.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/bloc/chat_history_bloc/chat_history_bloc.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/widgets/bottom_chat_form_widget.dart';
import 'package:gym_guardian_membership/workout_recommendation/presentation/widgets/excercise_widget.dart';
import 'package:os_basecode/os_basecode.dart';

class WorkoutRecommendationScreen extends StatefulWidget {
  const WorkoutRecommendationScreen({super.key});

  @override
  State<WorkoutRecommendationScreen> createState() => _WorkoutRecommendationScreenState();
}

class _WorkoutRecommendationScreenState extends State<WorkoutRecommendationScreen> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> scrollNotifier = ValueNotifier<bool>(false);

  TextEditingController customPromptController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<ChatHistoryBloc>().add(DoLoadChatHistory());
    scrollController.addListener(
      () {
        if (scrollController.position.pixels > 50) {
          scrollNotifier.value = true;
        } else {
          scrollNotifier.value = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/background_home.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SafeArea(
            top: false,
            bottom: false,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      ValueListenableBuilder(
                        valueListenable: scrollNotifier,
                        builder: (context, isScrolled, child) => SliverAppBar(
                          backgroundColor: Colors.white,
                          forceMaterialTransparency: isScrolled ? false : true,
                          floating: true,
                          pinned: true,
                          actions: [
                            IconButton(
                                onPressed: () async {
                                  showBottomConfirmationDialogueAlert(
                                    imagePath: "assets/clear_chat.png",
                                    title: context.l10n.delete_chat_jiva,
                                    subtitle: context.l10n.delete_chat_jiva_subtitle,
                                    handleConfirm: (context) async {
                                      await clearChatHistory(context);
                                      if (!context.mounted) return;
                                      context.pop();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.cleaning_services_outlined,
                                  color: onPrimaryColor,
                                )),
                            10.horizontalSpaceRadius,
                          ],
                          title: Text(
                            "JIVA ( Virtual Assistance )",
                            style: TextStyle(
                                fontSize: 18.spMin,
                                color: onPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: IconButton(
                              onPressed: () {
                                context.go("/homepage");
                              },
                              icon: Icon(Icons.chevron_left_rounded, color: onPrimaryColor)),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: 10.verticalSpacingRadius,
                      ),
                      BlocConsumer<ChatHistoryBloc, ChatHistoryState>(
                        listener: (context, state) {
                          if (state is ChatHistorySuccess) {
                            customPromptController.clear();
                            Timer(
                              200.milliseconds,
                              () {
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: 500.milliseconds,
                                    curve: Curves.ease);
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ChatHistorySuccess) {
                            return SliverList.separated(
                              separatorBuilder: (context, index) => 5.verticalSpacingRadius,
                              itemCount: state.datas.length,
                              itemBuilder: (context, index) {
                                ChatHistoryModel chatHistory = state.datas[index];
                                if (chatHistory.role == "user") {
                                  return QuestionChatWidget(
                                    chatHistory: chatHistory.text,
                                    timeStamp: chatHistory.timestamp,
                                  );
                                } else {
                                  if (chatHistory.prompt.contains("```json")) {
                                    try {
                                      Map<String, String> extractedData =
                                          extractJson(chatHistory.prompt);
                                      String jsonString = extractedData["jsonString"]!;

                                      if (jsonString.isNotEmpty) {
                                        ExerciseModel exerciseModel =
                                            exerciseModelFromJson(jsonString);

                                        List<Widget> children = [];

                                        if (extractedData["beforeJson"]!.isNotEmpty) {
                                          children.add(QuestionChatWidget(
                                            chatHistory: extractedData["beforeJson"]!,
                                            timeStamp: chatHistory.timestamp,
                                            isSender: false,
                                          ));
                                        }

                                        children.add(ExcerciseWidget(
                                            exerciseModel: exerciseModel,
                                            chatHistory: chatHistory));

                                        if (extractedData["afterJson"]!.isNotEmpty) {
                                          children.add(QuestionChatWidget(
                                            chatHistory: extractedData["afterJson"]!,
                                            timeStamp: chatHistory.timestamp,
                                            isSender: false,
                                          ));
                                        }

                                        return Column(
                                          spacing: 10,
                                          children: children,
                                        );
                                      } else {
                                        return const Text(
                                            "Data latihan tidak ditemukan atau format JSON salah."); // Pesan yang lebih informatif
                                      }
                                    } catch (e) {
                                      return const Text(
                                          "Error memproses data latihan. Periksa format JSON."); // Pesan yang lebih informatif
                                    }
                                  } else {
                                    return QuestionChatWidget(
                                      chatHistory: chatHistory.text,
                                      timeStamp: chatHistory.timestamp,
                                      isSender: false,
                                    );
                                  }
                                }
                              },
                            );
                          } else {
                            return SliverToBoxAdapter(
                              child: SizedBox.shrink(),
                            );
                          }
                        },
                      ),
                      SliverToBoxAdapter(
                        child: 150.verticalSpacingRadius,
                      )
                    ],
                  ),
                ),
                BottomChatFormWidget(
                    customPromptController: customPromptController,
                    scrollController: scrollController)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionChatWidget extends StatelessWidget {
  final String chatHistory;
  final DateTime timeStamp;
  final bool isSender;
  const QuestionChatWidget(
      {super.key, required this.chatHistory, required this.timeStamp, this.isSender = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(left: isSender ? 30 : 5, right: isSender ? 5 : 30),
        decoration: BoxDecoration(
            color: isSender
                ? primaryColor.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chatHistory,
              style: TextStyle(fontSize: 13.spMin),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatDateWithTime(timeStamp),
                  style: TextStyle(fontSize: 8.spMin),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
