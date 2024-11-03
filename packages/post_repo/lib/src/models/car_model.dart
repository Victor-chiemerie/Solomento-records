import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Car extends Equatable {
  final String id;
  final String customerId;
  final String modelName;
  final String plateNumber;
  final String serviceAdviser;
  final String arrivalDate;
  final String jobDetails;
  final List<String> jobType;
  final double cost;
  final bool isApproved;
  final String approvalDate;
  final String paymentStatus;
  final double paymentMade;
  final List<Map<double, String>> paymentHistory;
  final String repairStatus;
  final String repairDetails;
  final String departureDate;

  const Car({
    required this.id,
    required this.customerId,
    required this.modelName,
    required this.plateNumber,
    required this.serviceAdviser,
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
  static const empty = Car(
    id: "",
    customerId: "",
    modelName: "",
    plateNumber: "",
    serviceAdviser: "",
    arrivalDate: "",
    jobDetails: "",
    jobType: [],
    cost: 0,
    isApproved: false,
    approvalDate: "",
    paymentStatus: "incomplete",
    paymentMade: 0,
    paymentHistory: [],
    repairStatus: "pending",
    repairDetails: "",
    departureDate: "",
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
    String? serviceAdviser,
    String? arrivalDate,
    String? jobDetails,
    List<String>? jobType,
    double? cost,
    bool? isApproved,
    String? approvalDate,
    String? paymentStatus,
    double? paymentMade,
    List<Map<double, String>>? paymentHistory,
    String? repairStatus,
    String? repairDetails,
    String? departureDate,
  }) {
    return Car(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      modelName: modelName ?? this.modelName,
      plateNumber: plateNumber ?? this.plateNumber,
      serviceAdviser: serviceAdviser ?? this.serviceAdviser,
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
      serviceAdviser: serviceAdviser,
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
      serviceAdviser: entity.serviceAdviser,
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
  // TODO: implement props
  List<Object?> get props => [
        id,
        customerId,
        modelName,
        plateNumber,
        serviceAdviser,
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
