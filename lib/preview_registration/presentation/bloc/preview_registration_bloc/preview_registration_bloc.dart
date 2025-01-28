import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/preview_registration/domain/entities/preview_registration_model.dart';
import 'package:meta/meta.dart';

part 'preview_registration_event.dart';
part 'preview_registration_state.dart';

class PreviewRegistrationBloc extends Bloc<PreviewRegistrationEvent, PreviewRegistrationState> {
  PreviewRegistrationBloc() : super(PreviewRegistrationInitial()) {
    on<DoSavePreviewRegistration>((event, emit) {
      emit(PreviewRegistrationHasData(event.entity));
    });
  }
}
