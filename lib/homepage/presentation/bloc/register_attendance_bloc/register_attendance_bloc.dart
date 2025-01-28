import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/register_attendance_reponse_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/register_attendance.dart';
import 'package:gym_guardian_membership/utility/global_loader.dart';
import 'package:meta/meta.dart';

part 'register_attendance_event.dart';
part 'register_attendance_state.dart';

class RegisterAttendanceBloc extends Bloc<RegisterAttendanceEvent, RegisterAttendanceState> {
  RegisterAttendanceUsecase registerAttendanceUsecase;
  RegisterAttendanceBloc(this.registerAttendanceUsecase) : super(RegisterAttendanceInitial()) {
    on<DoRegisterAttendance>((event, emit) async {
      emit(RegisterAttendanceLoading());
      GlobalLoader.show();
      var response = await registerAttendanceUsecase.execute(event.memberCode);
      response.fold((l) {
        emit(RegisterAttendanceFailure(l.message));
      }, (r) {
        emit(RegisterAttendanceSuccess(r));
      });
      GlobalLoader.hide();
    });
  }
}
