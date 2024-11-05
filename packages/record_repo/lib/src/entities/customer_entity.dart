import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class CustomerEntity extends Equatable {
  // entity paramenters
  String id;
  String name;
  String mobile;
  String carId;
  String status;
  MyUser myUser;

  CustomerEntity({
    required this.id,
    required this.name,
    required this.mobile,
    required this.carId,
    this.status = 'Unsettled',
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
      myUser: $myUser
    }''';
  }

  @override
  List<Object?> get props => [id, name, mobile, carId, status, myUser];
}
