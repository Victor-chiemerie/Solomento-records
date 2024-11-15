// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class CustomerEntity extends Equatable {
  // entity paramenters
  String id;
  String name;
  String mobile;
  String carId;
  String status;
  DateTime createdAt;
  MyUser myUser;

  CustomerEntity({
    required this.id,
    required this.name,
    required this.mobile,
    required this.carId,
    this.status = 'Unsettled',
    required this.createdAt,
    required this.myUser,
  });

  /// Converts the customer entity to a document to be stored to firebase
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'carId': carId,
      'status': status,
      'createdAt': createdAt,
      'myUser': myUser.toEntity().toDocument(),
    };
  }

  /// Converts a document from firebase to a customer entity
  static CustomerEntity fromDocument(Map<String, dynamic> doc) {
    return CustomerEntity(
      id: doc['id'] as String,
      name: doc['name'] as String,
      mobile: doc['mobile'] as String,
      carId: doc['carId'] as String,
      status: doc['status'] as String,
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      myUser: MyUser.fromEntity(MyUserEntity.fromDocument(doc['myUser'])),
    );
  }

  @override
  String toString() {
    return '''CustomerEntity: {
      id: $id
      name: $name
      mobile: $mobile
      carId: $carId
      status: $status
      createdAt: $createdAt
      myUser: $myUser
    }''';
  }

  @override
  List<Object?> get props =>
      [id, name, mobile, carId, status, createdAt, myUser];
}
