part of 'update_profile_bloc.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final String datas;
  UpdateProfileSuccess(this.datas);
}

class UpdateProfileFailure extends UpdateProfileState {
  final String message;
  UpdateProfileFailure(this.message);
}
