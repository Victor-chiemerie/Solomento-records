import '../record_repository.dart';

abstract class RecordRepository {
  /// Save car and customer
  Future<Map<String, dynamic>> saveCustomerAndCarData(
    Customer customer,
    Car car,
  );

  /// Save a car
  Future<Car> saveCarData(Car car);

  /// Get list of all cars
  Future<List<Car>> getCars();

  /// Update car information

  /// Save a customer
  Future<Customer> saveCustomerData(Customer customer);

  /// Cet list of all customers
  Future<List<Customer>> getCustomers();
}
