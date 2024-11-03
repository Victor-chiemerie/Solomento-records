// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Customer extends Equatable {
  final String id;
  final String name;
  final String mobile;
  final String carId;
  final String status;

  const Customer({
    required this.id,
    required this.name,
    required this.mobile,
    required this.carId,
    this.status = 'Unsettled',
  });

  Customer copyWith({
    String? id,
    String? name,
    String? mobile,
    String? carId,
    String? status,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      carId: carId ?? this.carId,
      status: status ?? this.status,
    );
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
      mobile: mobile,
      carId: carId,
      status: status,
    );
  }

  static Customer fromEntity(CustomerEntity entity) {
    return Customer(
      id: entity.id,
      name: entity.name,
      mobile: entity.mobile,
      carId: entity.carId,
      status: entity.status,
    );
  }

  @override
  List<Object?> get props => [id, name, mobile, carId, status];
}
