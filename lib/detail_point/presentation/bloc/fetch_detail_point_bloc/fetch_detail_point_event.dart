part of 'fetch_detail_point_bloc.dart';

abstract class FetchDetailPointEvent {}

class DoFetchDetailPoint extends FetchDetailPointEvent {
  final String memberCode;
  final int? page;
  final int? limit;

  DoFetchDetailPoint(this.memberCode, this.page, this.limit);
}
