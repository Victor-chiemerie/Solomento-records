import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record_repository/record_repository.dart';
part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final RecordRepository _recordRepository;
  CustomerBloc({required RecordRepository myRecordRepository})
      : _recordRepository = myRecordRepository,
        super(const CustomerState.loading()) {
    on<GetAllCustomers>((event, emit) async {
      try {
        List<Customer> customers = await _recordRepository.getCustomers();
        emit(CustomerState.success(customers));
      } catch (error) {
        log(error.toString());
        emit(const CustomerState.failure());
      }
    });
  }
}
