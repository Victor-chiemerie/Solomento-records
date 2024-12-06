import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

import '../../../Data/car_filter_model.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit({required this.recordRepository})
      : super(const GetDataState(cars: []));

  final RecordRepository recordRepository;

  Future<void> getData() async {
    emit(GetDataState(
      cars: state.cars,
      status: GetDataStatus.loading,
    ));
    try {
      List<Car> cars = await recordRepository.getCars();
      // TODO change state emission with copyWith
      emit(GetDataState(
        cars: cars,
        status: GetDataStatus.success,
      ));
    } catch (error) {
      // TODO change state emission with copyWith
      emit(GetDataState(
        cars: state.cars,
        status: GetDataStatus.failure,
      ));
    }
  }

  void filterCars(FilterCriteria criteria) {
    final filteredCars = state.cars.where((car) {
      final matchesRepairStatus = criteria.repairStatus == null ||
          car.repairStatus == criteria.repairStatus;
      final matchesApprovalStatus = criteria.approvalStatus == null ||
          car.isApproved == criteria.approvalStatus;
      final matchesTechnician = criteria.technician == null ||
          car.technician == criteria.technician;

      return matchesRepairStatus && matchesApprovalStatus && matchesTechnician;
    }).toList();

    emit(state.copyWith(
      filterCriteria: criteria,
      filteredCars: filteredCars,
    ));
  }
}
