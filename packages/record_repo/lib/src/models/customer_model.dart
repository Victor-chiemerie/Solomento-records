// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import '../entities/entities.dart';

class Customer extends Equatable {
  String id;
  String name;
  String mobile;
  String carId;
  String status;
  MyUser myUser;

  Customer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.carId,
    required this.status,
    required this.myUser,
  });

  /// Empty user which represents an unauthenticated Customer
  static Customer empty = Customer(
    id: "",
    name: "",
    mobile: "",
    carId: "",
    status: "unSettled",
    myUser: MyUser.empty,
  );

  /// Convenience getter to determine whether the current Customer has no details
  bool get isEmpty => this == Customer.empty;

  /// Convenience getter to determine whether the current Customer has details
  bool get isNotEmpty => this != Customer.empty;

  Customer copyWith({
    String? id,
    String? name,
    String? mobile,
    String? carId,
    String? status,
    MyUser? myUser,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      carId: carId ?? this.carId,
      status: status ?? this.status,
      myUser: myUser ?? this.myUser,
    );
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
      mobile: mobile,
      carId: carId,
      status: status,
      myUser: myUser,
    );
  }

  static Customer fromEntity(CustomerEntity entity) {
    return Customer(
      id: entity.id,
      name: entity.name,
      mobile: entity.mobile,
      carId: entity.carId,
      status: entity.status,
      myUser: entity.myUser,
    );
  }

  @override
  List<Object?> get props => [id, name, mobile, carId, status, myUser];
}
