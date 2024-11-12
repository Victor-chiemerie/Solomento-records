part of 'save_data_bloc.dart';

sealed class SaveDataState extends Equatable {
  const SaveDataState();

  @override
  List<Object> get props => [];
}

final class SaveDataInitial extends SaveDataState {}

final class SaveDataLoading extends SaveDataState {}

final class SaveDataSuccess extends SaveDataState {
  final Customer customer;
  final Car car;

  const SaveDataSuccess(this.customer, this.car);
}

final class SaveDataFailure extends SaveDataState {}
