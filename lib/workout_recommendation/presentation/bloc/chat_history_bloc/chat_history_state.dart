part of 'chat_history_bloc.dart';

@immutable
sealed class ChatHistoryState {}

final class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoading extends ChatHistoryState {}

class ChatHistorySuccess extends ChatHistoryState {
  final List<ChatHistoryModel> datas;
  ChatHistorySuccess(this.datas);
}

class ChatHistoryFailure extends ChatHistoryState {
  final String message;
  ChatHistoryFailure(this.message);
}
