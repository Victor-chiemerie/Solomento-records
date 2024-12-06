part of 'get_data_cubit.dart';

enum GetDataStatus { initial, loading, success, failure }

class GetDataState extends Equatable {
  const GetDataState({
    required this.cars,
    this.status = GetDataStatus.initial,
    this.filteredCars,
    this.filterCriteria,
  });

  final List<Car> cars;
  final GetDataStatus status;
  final List<Car>? filteredCars; // List of cars filtered or searched
  final FilterCriteria? filterCriteria; // Filtering options

  GetDataState copyWith({
    List<Car>? cars,
    List<Car>? filteredCars,
    FilterCriteria? filterCriteria,
    GetDataStatus? status,
  }) {
    return GetDataState(
      cars: cars ?? this.cars,
      filteredCars: filteredCars ?? this.filteredCars,
      filterCriteria: filterCriteria ?? this.filterCriteria,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [cars, status, filteredCars, filterCriteria];
}
