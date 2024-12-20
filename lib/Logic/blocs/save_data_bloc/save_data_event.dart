part of 'save_data_bloc.dart';

abstract class SaveDataEvent extends Equatable {
  const SaveDataEvent();

  @override
  List<Object> get props => [];
}

class SaveCar extends SaveDataEvent {
  final Car car;

  const SaveCar(this.car);
}

class UpdateCarData extends SaveDataEvent {
  final String id;
  final Car car;

  const UpdateCarData(this.id, this.car);
}
