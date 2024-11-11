part of 'delete_data_cubit.dart';

enum DeleteDataStatus { initial, loading, success, failure }

class DeleteDataState extends Equatable {
  const DeleteDataState({
    this.car,
    this.status = DeleteDataStatus.initial,
  });

  final Car? car;
  final DeleteDataStatus status;

  @override
  List<Object?> get props => [car, status];
}
