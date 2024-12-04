part of 'get_data_cubit.dart';

enum GetDataStatus { initial, loading, success, failure }

class GetDataState extends Equatable {
  const GetDataState({
    required this.customers,
    required this.cars,
    this.status = GetDataStatus.initial,
    this.filteredCars,
    this.filterCriteria,
  });

  final List<Customer> customers;
  final List<Car> cars;
  final GetDataStatus status;
  final List<Car>? filteredCars; // List of cars filtered or searched
  final FilterCriteria? filterCriteria; // Filtering options

  GetDataState copyWith({
    List<Customer>? customers,
    List<Car>? cars,
    List<Car>? filteredCars,
    FilterCriteria? filterCriteria,
    GetDataStatus? status,
  }) {
    return GetDataState(
      customers: customers ?? this.customers,
      cars: cars ?? this.cars,
      filteredCars: filteredCars ?? this.filteredCars,
      filterCriteria: filterCriteria ?? this.filterCriteria,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [customers, cars, status, filteredCars, filterCriteria];

  // Method to find a car by ID
  Car findCarById(String id) {
    return cars.firstWhere((car) => car.id == id);
  }

  // Method to find a customer by ID
  Customer findCustomerById(String id) {
    return customers.firstWhere((customer) => customer.id == id);
  }
}
