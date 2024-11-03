import '../record_repository.dart';

abstract class RecordRepository {
  /// Save a car
  Future<void> saveCarData(Car car);

  /// Get list of all cars
  Future<List<Car>> getCars();

  /// Save a customer
  Future<void> saveCustomerData(Customer customer);

  /// Cet list of all customers
  Future<List<Customer>> getCustomers();
}
