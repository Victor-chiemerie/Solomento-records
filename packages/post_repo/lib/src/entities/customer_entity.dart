import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  // entity paramenters
  final String id;
  final String name;
  final String mobile;
  final String carId;
  final String status;

  const CustomerEntity({
    required this.id,
    required this.name,
    required this.mobile,
    required this.carId,
    this.status = 'Unsettled',
  });

  /// Converts the customer entity to a document to be stored to firebase
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'carId': carId,
      'status': status,
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
    }''';
  }

  @override
  List<Object?> get props => [id, name, mobile, carId, status];
}
