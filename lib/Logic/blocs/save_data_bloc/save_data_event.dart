part of 'save_data_bloc.dart';

abstract class SaveDataEvent extends Equatable {
  const SaveDataEvent();

  @override
  List<Object> get props => [];
}

class SaveCustomerAndCar extends SaveDataEvent {
  final Customer customer;
  final Car car;

  const SaveCustomerAndCar(this.customer, this.car);
}

class UpdateCustomerData extends SaveDataEvent {
  final Customer customer;
  final String id;

  const UpdateCustomerData(this.customer, this.id);
}

class UpdateCarData extends SaveDataEvent {
  final String id;
  final Car car;

  const UpdateCarData(this.id, this.car);
}
