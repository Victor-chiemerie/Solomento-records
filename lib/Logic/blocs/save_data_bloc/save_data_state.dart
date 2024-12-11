part of 'save_data_bloc.dart';

sealed class SaveDataState extends Equatable {
  const SaveDataState();

  @override
  List<Object?> get props => [];
}

final class SaveDataInitial extends SaveDataState {}

final class SaveDataLoading extends SaveDataState {}

class SaveDataSuccess extends SaveDataState {
  final Car? car;

  const SaveDataSuccess({this.car});

  @override
  List<Object?> get props => [car];
}

final class SaveDataFailure extends SaveDataState {}
