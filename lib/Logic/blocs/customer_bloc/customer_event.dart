part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class GetAllCustomers extends CustomerEvent {
  const GetAllCustomers();

  @override
  List<Object> get props => [];
}
