import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_repository/record_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseRecordRepository implements RecordRepository {
  // instantiate the collection of cars and customers
  final carCollection = FirebaseFirestore.instance.collection('cars');
  final customerCollection = FirebaseFirestore.instance.collection('customers');
  final uuid = const Uuid();

  // Save customer and car with cross-referencing IDs
  @override
  Future<Map<String, dynamic>> saveCustomerAndCarData(
    Customer customer,
    Car car,
  ) async {
    try {
      // Generate IDs for customer and car
      customer.id = uuid.v1();
      car.id = uuid.v1();

      // Set cross-referencing IDs
      customer.carId = car.id;
      car.customerId = customer.id;

      car.arrivalDate = DateTime.now();

      // Save customer and car data
      await Future.wait([
        customerCollection
            .doc(customer.id)
            .set(customer.toEntity().toDocument()),
        carCollection.doc(car.id).set(car.toEntity().toDocument())
      ]);

      // Return both objects in a Map
      return {
        "customer": customer,
        "car": car,
      };
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Update car data
  @override
  Future<Car> updateCarData(Car car, String id) async {
    try {
      await carCollection.doc(id).set(car.toEntity().toDocument());

      return car;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Get all Cars
  @override
  Future<List<Car>> getCars() async {
    try {
      final querySnapshot = await carCollection.get();
      // Convert each document to a Car object
      final cars = querySnapshot.docs.map((doc) {
        return Car.fromEntity(
          CarEntity.fromDocument(doc.data()),
        );
      }).toList();
      return cars;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Update customer data
  @override
  Future<Customer> updateCustomerData(Customer customer, String id) async {
    try {
      await customerCollection.doc(id).set(customer.toEntity().toDocument());

      return customer;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Get all Customers
  @override
  Future<List<Customer>> getCustomers() async {
    try {
      final querySnapshot = await customerCollection.get();
      // convert each document to a Customer object
      final customers = querySnapshot.docs.map((doc) {
        return Customer.fromEntity(
          CustomerEntity.fromDocument(doc.data()),
        );
      }).toList();
      return customers;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // Delete a car and Customer
  @override
  Future<void> deleteCustomerAndCar(Car car) async {
    try {
      await carCollection.doc(car.id).delete();
      await customerCollection.doc(car.customerId).delete();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
