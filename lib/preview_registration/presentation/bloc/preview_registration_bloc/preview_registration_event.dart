part of 'preview_registration_bloc.dart';

@immutable
sealed class PreviewRegistrationEvent {}

class DoSavePreviewRegistration extends PreviewRegistrationEvent {
  final PreviewRegistrationEntity entity;
  DoSavePreviewRegistration(this.entity);
}
