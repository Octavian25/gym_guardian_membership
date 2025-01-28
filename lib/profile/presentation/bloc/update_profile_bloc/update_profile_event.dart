part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent {}

class DoUpdateProfile extends UpdateProfileEvent {
  final UpdateProfileEntity updateProfileEntity;
  DoUpdateProfile(this.updateProfileEntity);
}
