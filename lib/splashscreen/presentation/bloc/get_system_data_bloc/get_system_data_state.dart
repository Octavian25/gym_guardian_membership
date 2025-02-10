part of 'get_system_data_bloc.dart';

@immutable
sealed class GetSystemDataState {}

final class GetSystemDataInitial extends GetSystemDataState {}

class GetSystemDataLoading extends GetSystemDataState {}

class GetSystemDataSuccess extends GetSystemDataState {
  final SystemEntity datas;
  GetSystemDataSuccess(this.datas);
}

class GetSystemDataFailure extends GetSystemDataState {
  final String message;
  GetSystemDataFailure(this.message);
}
