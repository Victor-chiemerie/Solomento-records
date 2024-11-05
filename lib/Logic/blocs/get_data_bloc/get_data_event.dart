part of 'get_data_bloc.dart';

abstract class GetDataEvent extends Equatable {
  const GetDataEvent();

  @override
  List<Object> get props => [];
}

class GetAllCustomers extends GetDataEvent {
  
}

class GetAllCars extends GetDataEvent {
  
}
