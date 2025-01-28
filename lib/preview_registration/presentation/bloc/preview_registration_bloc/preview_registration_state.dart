part of 'preview_registration_bloc.dart';

@immutable
sealed class PreviewRegistrationState {}

final class PreviewRegistrationInitial extends PreviewRegistrationState {}

final class PreviewRegistrationHasData extends PreviewRegistrationState {
  final PreviewRegistrationEntity previewRegistrationEntity;
  PreviewRegistrationHasData(this.previewRegistrationEntity);
}
