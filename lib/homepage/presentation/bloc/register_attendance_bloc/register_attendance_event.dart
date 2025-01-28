part of 'register_attendance_bloc.dart';

abstract class RegisterAttendanceEvent {}

class DoRegisterAttendance extends RegisterAttendanceEvent {
  final String memberCode;
  DoRegisterAttendance(this.memberCode);
}
