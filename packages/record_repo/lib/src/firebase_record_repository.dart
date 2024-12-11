import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:record_repository/record_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseRecordRepository implements RecordRepository {
  // instantiate the collection of cars and customers
  final carCollection = FirebaseFirestore.instance.collection('cars');
  final customerCollection = FirebaseFirestore.instance.collection('customers');
  final uuid = const Uuid();

  // Save car
  @override
  Future<Car> saveCarData(Car car) async {
    try {
      // Generate ID car
      car.id = uuid.v1();
      car.arrivalDate = DateTime.now();

      // Save car data
      await carCollection.doc(car.id).set(car.toEntity().toDocument());

      // Return object in a Map
      return car;
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
      final querySnapshot =
          await carCollection.orderBy('arrivalDate', descending: true).get();
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

  // Delete a car and Customer
  @override
  Future<void> deleteCar(Car car) async {
    try {
      await carCollection.doc(car.id).delete();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateAllCars(Car car) async {
    // try {
    //   await carCollection.doc(car.plateNumber).update({
    //     'customerId': FieldValue.delete(),
    //   });
    //   print('Updated all cars field with the customer data');
    // } catch (error) {
    //   log(error.toString());
    //   rethrow;
    // }
  }
}
