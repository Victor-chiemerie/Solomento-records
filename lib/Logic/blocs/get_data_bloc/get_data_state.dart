part of 'get_data_bloc.dart';

sealed class GetDataState extends Equatable {
  final List<Customer>? customers;
  final List<Car>? cars;

  const GetDataState({this.customers, this.cars});

  @override
  List<Object> get props => [];
}

final class GetDataInitial extends GetDataState {}

final class GetDataLoading extends GetDataState {}

final class GetDataFailure extends GetDataState {}

final class GetDataSuccess extends GetDataState {
  const GetDataSuccess({super.customers, super.cars});
}
