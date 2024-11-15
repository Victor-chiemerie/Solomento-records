part of 'get_data_cubit.dart';

enum GetDataStatus { initial, loading, success, failure }

class GetDataState extends Equatable {
  const GetDataState({
    required this.customers,
    required this.cars,
    this.status = GetDataStatus.initial,
  });

  final List<Customer> customers;
  final List<Car> cars;
  final GetDataStatus status;

  @override
  List<Object> get props => [customers, cars, status];

  // Method to find a car by ID
  Car findCarById(String id) {
    return cars.firstWhere((car) => car.id == id);
  }

  // Method to find a customer by ID
  Customer findCustomerById(String id) {
    return customers.firstWhere((customer) => customer.id == id);
  }
}
