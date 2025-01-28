import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/profile/domain/entities/update_profile_entity.dart';
import 'package:gym_guardian_membership/profile/domain/usecase/update_profile.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileUsecase updateProfileUsecase;
  UpdateProfileBloc(this.updateProfileUsecase) : super(UpdateProfileInitial()) {
    on<DoUpdateProfile>((event, emit) async {
      emit(UpdateProfileLoading());
      GlobalLoader.show();
      var response = await updateProfileUsecase.execute(event.updateProfileEntity);
      response.fold((l) {
        emit(UpdateProfileFailure(l.message));
      }, (r) {
        emit(UpdateProfileSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
