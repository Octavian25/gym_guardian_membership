part of 'fetch_all_gym_equipment_bloc.dart';

abstract class FetchAllGymEquipmentEvent {}

class DoFetchAllGymEquipment extends FetchAllGymEquipmentEvent {
  final String? category;
  DoFetchAllGymEquipment(this.category);
}
