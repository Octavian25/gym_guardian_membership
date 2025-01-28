part of 'register_attendance_bloc.dart';

@immutable
sealed class RegisterAttendanceState {}

final class RegisterAttendanceInitial extends RegisterAttendanceState {}

class RegisterAttendanceLoading extends RegisterAttendanceState {}

class RegisterAttendanceSuccess extends RegisterAttendanceState {
  final RegisterAttendanceResponseEntity datas;
  RegisterAttendanceSuccess(this.datas);
}

class RegisterAttendanceFailure extends RegisterAttendanceState {
  final String message;
  RegisterAttendanceFailure(this.message);
}
