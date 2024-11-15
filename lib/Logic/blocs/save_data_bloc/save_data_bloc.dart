import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

part 'save_data_event.dart';
part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  final RecordRepository _recordRepository;

  SaveDataBloc({required RecordRepository recordRepository})
      : _recordRepository = recordRepository,
        super(SaveDataInitial()) {
    on<SaveCustomerAndCar>((event, emit) async {
      emit(SaveDataLoading());
      try {
        final data = await _recordRepository.saveCustomerAndCarData(event.customer, event.car);
        emit(SaveDataSuccess(customer: data['customer'], car: data['car']));
      } catch (error) {
        emit(SaveDataFailure());
      }
    });

    on<UpdateCustomerData>((event, emit) async {
      emit(SaveDataLoading());
      try {
        final data = await _recordRepository.updateCustomerData(event.customer, event.id);
        emit(SaveDataSuccess(customer: data));
      } catch (error) {
        emit(SaveDataFailure());
      }
    });

    on<UpdateCarData>((event, emit) async {
      emit(SaveDataLoading());
      try {
        final data = await _recordRepository.updateCarData(event.car, event.id);
        emit(SaveDataSuccess(car: data));
      } catch (error) {
        emit(SaveDataFailure());
      }
    });
  }
}
