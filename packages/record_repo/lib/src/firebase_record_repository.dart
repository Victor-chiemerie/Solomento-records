import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_repository/record_repository.dart';

class FirebaseRecordRepository implements RecordRepository {
  // instantiate the collection of cars and customers
  final carCollection = FirebaseFirestore.instance.collection('cars');
  final customerCollection = FirebaseFirestore.instance.collection('customers');

  // Save car
  @override
  Future<void> saveCarData(Car car) async {
    try {
      await carCollection.doc(car.id).set(car.toEntity().toDocument());
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

  // Save customer
  @override
  Future<void> saveCustomerData(Customer customer) async {
    try {
      await customerCollection
          .doc(customer.id)
          .set(customer.toEntity().toDocument());
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
}
