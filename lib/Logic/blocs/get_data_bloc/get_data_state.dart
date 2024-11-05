part of 'get_data_bloc.dart';

sealed class GetDataState extends Equatable {
  const GetDataState();

  @override
  List<Object> get props => [];
}

final class GetDataInitial extends GetDataState {}

final class GetDataLoading extends GetDataState {}

final class GetDataFailure extends GetDataState {}

final class GetDataSuccess extends GetDataState {
  final List<Customer>? customers;
  final List<Car>? cars;

  const GetDataSuccess({this.customers, this.cars});
  
}
