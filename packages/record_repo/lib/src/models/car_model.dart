// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Car extends Equatable {
  String id;
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
  DateTime pickUpDate;
  String customerName;
  String customerMobile;
  String customerStatus;
  String engineModel;
  String vin;
  String meterReading;
  String manufactureYear;
  String fuelLevel;
  String color;

  Car({
    required this.id,
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
    required this.pickUpDate,
    required this.customerName,
    required this.customerMobile,
    required this.customerStatus,
    required this.engineModel,
    required this.vin,
    required this.meterReading,
    required this.manufactureYear,
    required this.fuelLevel,
    required this.color,
  });

  /// Empty user which represents an unauthenticated car
  static Car empty = Car(
    id: "",
    modelName: "",
    plateNumber: "",
    picture: "",
    serviceAdviser: "",
    technician: "",
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
    pickUpDate: DateTime.utc(1999, 7, 20, 20, 18, 04),
    customerName: "",
    customerMobile: "",
    customerStatus: "unSettled",
    engineModel: "",
    vin: "",
    meterReading: "",
    manufactureYear: "",
    fuelLevel: "",
    color: "",
  );

  /// Convenience getter to determine whether the current Car has no details
  bool get isEmpty => this == Car.empty;

  /// Convenience getter to determine whether the current Car has details
  bool get isNotEmpty => this != Car.empty;

  Car copyWith({
    String? id,
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
    DateTime? pickUpDate,
    String? customerName,
    String? customerMobile,
    String? customerStatus,
    String? engineModel,
    String? vin,
    String? meterReading,
    String? manufactureYear,
    String? fuelLevel,
    String? color,
  }) {
    return Car(
      id: id ?? this.id,
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
      pickUpDate: pickUpDate ?? this.pickUpDate,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      customerStatus: customerStatus ?? this.customerStatus,
      engineModel: engineModel ?? this.engineModel,
      vin: vin ?? this.vin,
      meterReading: meterReading ?? this.meterReading,
      manufactureYear: manufactureYear ?? this.manufactureYear,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      color: color ?? this.color,
    );
  }

  CarEntity toEntity() {
    return CarEntity(
      id: id,
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
      pickUpDate: pickUpDate,
      customerName: customerName,
      customerMobile: customerMobile,
      customerStatus: customerStatus,
      engineModel: engineModel,
      vin: vin,
      meterReading: meterReading,
      manufactureYear: manufactureYear,
      fuelLevel: fuelLevel,
      color: color,
    );
  }

  static Car fromEntity(CarEntity entity) {
    return Car(
      id: entity.id,
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
      pickUpDate: entity.pickUpDate,
      customerName: entity.customerName,
      customerMobile: entity.customerMobile,
      customerStatus: entity.customerStatus,
      engineModel: entity.engineModel,
      vin: entity.vin,
      meterReading: entity.meterReading,
      manufactureYear: entity.manufactureYear,
      fuelLevel: entity.fuelLevel,
      color: entity.color,
    );
  }

  @override
  List<Object?> get props => [
        id,
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
        pickUpDate,
        customerName,
        customerMobile,
        customerStatus,
        engineModel,
        vin,
        meterReading,
        manufactureYear,
        fuelLevel,
        color,
      ];
}
