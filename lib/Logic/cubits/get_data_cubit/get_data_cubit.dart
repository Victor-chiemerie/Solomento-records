import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit({required this.recordRepository})
      : super(const GetDataState(customers: [], cars: []));

  final RecordRepository recordRepository;

  Future<void> getData() async {
    emit(GetDataState(
      customers: state.customers,
      cars: state.cars,
      status: GetDataStatus.loading,
    ));
    try {
      List<Customer> customers = await recordRepository.getCustomers();
      List<Car> cars = await recordRepository.getCars();
      emit(GetDataState(
        customers: customers,
        cars: cars,
        status: GetDataStatus.success,
      ));
    } catch (error) {
      emit(GetDataState(
        customers: state.customers,
        cars: state.cars,
        status: GetDataStatus.failure,
      ));
    }
  }
}
