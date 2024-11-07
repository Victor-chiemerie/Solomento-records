import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  final RecordRepository _recordRepository;

  GetDataBloc({required RecordRepository recordRepository})
      : _recordRepository = recordRepository,
        super(GetDataInitial()) {
    // get customers list
    on<GetAllCustomers>((event, emit) async {
      emit(GetDataLoading());
      try {
        List<Customer> customers = await _recordRepository.getCustomers();
        emit(GetDataSuccess(customers: customers, cars: state.cars));
      } catch (error) {
        emit(GetDataFailure());
      }
    });

    // get cars list
    on<GetAllCars>((event, emit) async {
      emit(GetDataLoading());
      try {
        List<Car> cars = await _recordRepository.getCars();
        emit(GetDataSuccess(cars: cars, customers: state.customers));
      } catch (error) {
        emit(GetDataFailure());
      }
    });
  }
}
