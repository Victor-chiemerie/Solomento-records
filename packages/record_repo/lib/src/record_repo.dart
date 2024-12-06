import '../record_repository.dart';

abstract class RecordRepository {
  /// Save car
  Future<Car> saveCarData(Car car);

  /// Update a car data
  Future<Car> updateCarData(Car car, String id);

  /// Get list of all cars
  Future<List<Car>> getCars();

  /// Update a customer data
  Future<Customer> updateCustomerData(Customer customer, String id);

  /// Cet list of all customers
  Future<List<Customer>> getCustomers();

  /// Delete customer and car data
  Future<void> deleteCustomerAndCar(Car car);

  /// Update all cars
  Future<void> updateAllCars(Car car, Customer customer);
}
