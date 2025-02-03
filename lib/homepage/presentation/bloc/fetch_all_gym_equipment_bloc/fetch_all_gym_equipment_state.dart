part of 'fetch_all_gym_equipment_bloc.dart';

@immutable
sealed class FetchAllGymEquipmentState {}

final class FetchAllGymEquipmentInitial extends FetchAllGymEquipmentState {}

class FetchAllGymEquipmentLoading extends FetchAllGymEquipmentState {}

class FetchAllGymEquipmentSuccess extends FetchAllGymEquipmentState {
  final List<GymEquipmentEntity> datas;
  FetchAllGymEquipmentSuccess(this.datas);
}

class FetchAllGymEquipmentFailure extends FetchAllGymEquipmentState {
  final String message;
  FetchAllGymEquipmentFailure(this.message);
}
