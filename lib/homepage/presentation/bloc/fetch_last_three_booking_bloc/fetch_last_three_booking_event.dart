part of 'fetch_last_three_booking_bloc.dart';

abstract class FetchLastThreeBookingEvent {}

class DoFetchLastThreeBooking extends FetchLastThreeBookingEvent {
  final int? page;
  final int? limit;
  final String memberCode;

  DoFetchLastThreeBooking(this.memberCode, this.page, this.limit);
}
