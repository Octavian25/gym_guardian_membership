part of 'fetch_booking_bloc.dart';

abstract class FetchBookingEvent {}

class DoFetchBooking extends FetchBookingEvent {
  final int? page;
  final int? limit;
  final String memberCode;
  final bool forceFetch;

  DoFetchBooking(this.memberCode, this.page, this.limit, this.forceFetch);
}
