part of 'chat_history_bloc.dart';

abstract class ChatHistoryEvent {}

class DoAddChatHistory extends ChatHistoryEvent {
  ChatHistoryModel chatHistoryModel;

  DoAddChatHistory(this.chatHistoryModel);
}

class DoLoadChatHistory extends ChatHistoryEvent {}

class DoResetChatHistory extends ChatHistoryEvent {}
