// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Car extends Equatable {
  String id;
  String customerId;
  String modelName;
  String plateNumber;
  String picture;
  String serviceAdviser;
  String technician;
  DateTime arrivalDate;
  String jobDetails;
  List<dynamic> jobType;
  double cost;
  bool isApproved;
  DateTime approvalDate;
  String paymentStatus;
  double paymentMade;
  List<dynamic> paymentHistory;
  String repairStatus;
  String repairDetails;
  DateTime departureDate;

  Car({
    required this.id,
    required this.customerId,
    required this.modelName,
    required this.plateNumber,
    required this.picture,
    required this.serviceAdviser,
    required this.technician,
    required this.arrivalDate,
    required this.jobDetails,
    required this.jobType,
    required this.cost,
    required this.isApproved,
    required this.approvalDate,
    required this.paymentStatus,
    required this.paymentMade,
    required this.paymentHistory,
    required this.repairStatus,
    required this.repairDetails,
    required this.departureDate,
  });

  /// Empty user which represents an unauthenticated car
  static Car empty = Car(
    id: "",
    customerId: "",
    modelName: "",
    plateNumber: "",
    picture: "",
    serviceAdviser: "",
    technician: "Stanley",
    arrivalDate: DateTime.now(),
    jobDetails: "",
    jobType: const [],
    cost: 0,
    isApproved: false,
    approvalDate: DateTime.utc(1999, 7, 20, 20, 18, 04),
    paymentStatus: "incomplete",
    paymentMade: 0,
    paymentHistory: const [],
    repairStatus: "pending",
    repairDetails: "",
    departureDate: DateTime.utc(1999, 7, 20, 20, 18, 04),
  );

  /// Convenience getter to determine whether the current Car has no details
  bool get isEmpty => this == Car.empty;

  /// Convenience getter to determine whether the current Car has details
  bool get isNotEmpty => this != Car.empty;

  Car copyWith({
    String? id,
    String? customerId,
    String? modelName,
    String? plateNumber,
    String? picture,
    String? serviceAdviser,
    String? technician,
    DateTime? arrivalDate,
    String? jobDetails,
    List<String>? jobType,
    double? cost,
    bool? isApproved,
    DateTime? approvalDate,
    String? paymentStatus,
    double? paymentMade,
    List<dynamic>? paymentHistory,
    String? repairStatus,
    String? repairDetails,
    DateTime? departureDate,
  }) {
    return Car(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      modelName: modelName ?? this.modelName,
      plateNumber: plateNumber ?? this.plateNumber,
      picture: picture ?? this.picture,
      serviceAdviser: serviceAdviser ?? this.serviceAdviser,
      technician: technician ?? this.technician,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      jobDetails: jobDetails ?? this.jobDetails,
      jobType: jobType ?? this.jobType,
      cost: cost ?? this.cost,
      isApproved: isApproved ?? this.isApproved,
      approvalDate: approvalDate ?? this.approvalDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMade: paymentMade ?? this.paymentMade,
      paymentHistory: paymentHistory ?? this.paymentHistory,
      repairStatus: repairStatus ?? this.repairStatus,
      repairDetails: repairDetails ?? this.repairDetails,
      departureDate: departureDate ?? this.departureDate,
    );
  }

  CarEntity toEntity() {
    return CarEntity(
      id: id,
      customerId: customerId,
      modelName: modelName,
      plateNumber: plateNumber,
      picture: picture,
      serviceAdviser: serviceAdviser,
      technician: technician,
      arrivalDate: arrivalDate,
      jobDetails: jobDetails,
      jobType: jobType,
      cost: cost,
      isApproved: isApproved,
      approvalDate: approvalDate,
      paymentStatus: paymentStatus,
      paymentMade: paymentMade,
      paymentHistory: paymentHistory,
      repairStatus: repairStatus,
      repairDetails: repairDetails,
      departureDate: departureDate,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      id: entity.id,
      customerId: entity.customerId,
      modelName: entity.modelName,
      plateNumber: entity.plateNumber,
      picture: entity.picture,
      serviceAdviser: entity.serviceAdviser,
      technician: entity.technician,
      arrivalDate: entity.arrivalDate,
      jobDetails: entity.jobDetails,
      jobType: entity.jobType,
      cost: entity.cost,
      isApproved: entity.isApproved,
      approvalDate: entity.approvalDate,
      paymentStatus: entity.paymentStatus,
      paymentMade: entity.paymentMade,
      paymentHistory: entity.paymentHistory,
      repairStatus: entity.repairStatus,
      repairDetails: entity.repairDetails,
      departureDate: entity.departureDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        modelName,
        plateNumber,
        picture,
        serviceAdviser,
        technician,
        arrivalDate,
        jobDetails,
        jobType,
        cost,
        isApproved,
        approvalDate,
        paymentStatus,
        paymentMade,
        paymentHistory,
        repairStatus,
        repairDetails,
        departureDate,
      ];
}
