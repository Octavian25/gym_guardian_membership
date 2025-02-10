part of 'register_attendance_bloc.dart';

abstract class RegisterAttendanceEvent {}

class DoRegisterAttendance extends RegisterAttendanceEvent {
  final String memberCode;
  final String eligibleForPoints;
  DoRegisterAttendance(this.memberCode, this.eligibleForPoints);
}
