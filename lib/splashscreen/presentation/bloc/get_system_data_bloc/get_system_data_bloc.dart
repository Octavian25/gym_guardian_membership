import 'package:bloc/bloc.dart';
import 'package:gym_guardian_membership/splashscreen/domain/entities/system_entity.dart';
import 'package:gym_guardian_membership/splashscreen/domain/usecase/get_system_data.dart';
import 'package:meta/meta.dart';

part 'get_system_data_event.dart';
part 'get_system_data_state.dart';

class GetSystemDataBloc extends Bloc<GetSystemDataEvent, GetSystemDataState> {
  GetSystemDataUsecase getSystemDataUsecase;
  GetSystemDataBloc(this.getSystemDataUsecase) : super(GetSystemDataInitial()) {
    on<DoGetSystemData>((event, emit) async {
      emit(GetSystemDataLoading());
      var response = await getSystemDataUsecase.execute();
      response.fold((l) {
        emit(GetSystemDataFailure(l.message));
      }, (r) {
        emit(GetSystemDataSuccess(r));
      });
    });
  }
}
