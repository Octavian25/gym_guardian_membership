import 'dart:convert';

import 'package:gym_guardian_membership/utility/gemini_helper.dart';
import 'package:meta/meta.dart';
import 'package:os_basecode/os_basecode.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  SharedPreferences sharedPreferences;
  ChatHistoryBloc(this.sharedPreferences) : super(ChatHistoryInitial()) {
    on<DoLoadChatHistory>((event, emit) async {
      try {
        emit(ChatHistoryLoading());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? jsonString = prefs.getString('chat_history');
        if (jsonString != null) {
          List<dynamic> jsonData = jsonDecode(jsonString);
          List<ChatHistoryModel> chatHistory =
              jsonData.map((e) => ChatHistoryModel.fromJson(e)).toList();
          emit(ChatHistorySuccess(chatHistory));
        } else {
          emit(ChatHistorySuccess([]));
        }
      } catch (e) {
        emit(ChatHistoryFailure("Failed to load chat history"));
      }
    });
  }
}
