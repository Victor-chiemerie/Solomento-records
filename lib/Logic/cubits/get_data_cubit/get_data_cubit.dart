import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

import '../../../Data/car_filter_model.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit({required this.recordRepository})
      : super(const GetDataState(
          cars: [],
          filterCriteria: FilterCriteria(repairStatus: 'Pending'),
        ));

  final RecordRepository recordRepository;

  Future<void> getData() async {
    emit(GetDataState(
      cars: state.cars,
      status: GetDataStatus.loading,
    ));
    try {
      List<Car> cars = await recordRepository.getCars();
      // TODO change state emission with copyWith
      emit(
        GetDataState(
          cars: cars,
          status: GetDataStatus.success,
          filterCriteria: FilterCriteria(repairStatus: 'Pending'),
        ),
      );
    } catch (error) {
      // TODO change state emission with copyWith
      emit(GetDataState(
        cars: state.cars,
        status: GetDataStatus.failure,
      ));
    }
  }

  void filterCars(FilterCriteria newCriteria) {
    final filteredCars = state.cars.where((car) {
      final matchesRepairStatus = newCriteria.repairStatus == null ||
          car.repairStatus == newCriteria.repairStatus;
      final matchesApprovalStatus = newCriteria.approvalStatus == null ||
          car.isApproved == newCriteria.approvalStatus;
      final matchesTechnician = newCriteria.technician == null ||
          car.technician == newCriteria.technician;

      return matchesRepairStatus && matchesApprovalStatus && matchesTechnician;
    }).toList();

    emit(state.copyWith(
      filterCriteria: newCriteria,
      filteredCars: filteredCars,
    ));
  }
}
