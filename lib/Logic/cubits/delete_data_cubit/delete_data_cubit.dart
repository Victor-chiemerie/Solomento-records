import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';

part 'delete_data_state.dart';

class DeleteDataCubit extends Cubit<DeleteDataState> {
  DeleteDataCubit({required this.recordRepository})
      : super(const DeleteDataState());

  final RecordRepository recordRepository;

  Future<void> deleteData(Car car) async {
    emit(const DeleteDataState(status: DeleteDataStatus.loading));
    try {
      await recordRepository.deleteCustomerAndCar(car);
      emit(const DeleteDataState(status: DeleteDataStatus.success));
    } catch (error) {
      emit(const DeleteDataState(status: DeleteDataStatus.failure));
    }
  }
}
