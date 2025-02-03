import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/homepage/domain/entities/gym_equipment_entity.dart';
import 'package:gym_guardian_membership/homepage/domain/usecase/fetch_all_gym_equipment.dart';
import 'package:meta/meta.dart';

part 'fetch_all_gym_equipment_event.dart';
part 'fetch_all_gym_equipment_state.dart';

class FetchAllGymEquipmentBloc extends Bloc<FetchAllGymEquipmentEvent, FetchAllGymEquipmentState> {
  FetchAllGymEquipmentUsecase fetchAllGymEquipmentUsecase;
  FetchAllGymEquipmentBloc(this.fetchAllGymEquipmentUsecase)
      : super(FetchAllGymEquipmentInitial()) {
    on<DoFetchAllGymEquipment>((event, emit) async {
      emit(FetchAllGymEquipmentLoading());
      var response = await fetchAllGymEquipmentUsecase.execute(event.category);
      response.fold((l) {
        emit(FetchAllGymEquipmentFailure(l.message));
      }, (r) {
        emit(FetchAllGymEquipmentSuccess(r));
      });
    });
  }
}
