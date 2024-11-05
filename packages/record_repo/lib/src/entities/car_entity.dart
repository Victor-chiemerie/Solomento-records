import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String id;
  final String customerId;
  final String modelName;
  final String plateNumber;
  final String serviceAdviser;
  final DateTime arrivalDate;
  final String jobDetails;
  final List<String> jobType;
  final double cost;
  final bool isApproved;
  final DateTime approvalDate;
  final String paymentStatus;
  final double paymentMade;
  final List<Map<double, String>> paymentHistory;
  final String repairStatus;
  final String repairDetails;
  final DateTime departureDate;

  const CarEntity({
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

  /// Converts the car entity to a document to be stored to firebase
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'customerId': customerId,
      'modelName': modelName,
      'plateNumber': plateNumber,
      'serviceAdviser': serviceAdviser,
      'arrivalDate': arrivalDate,
      'jobDetails': jobDetails,
      'jobType': jobType,
      'cost': cost,
      'isApproved': isApproved,
      'approvalDate': approvalDate,
      'paymentStatus': paymentStatus,
      'paymentMade': paymentMade,
      'paymentHistory': paymentHistory,
      'repairStatus': repairStatus,
      'repairDetails': repairDetails,
      'departureDate': departureDate,
    };
  }

  /// Converts a document from firebase to a car entity
  static CarEntity fromDocument(Map<String, dynamic> doc) {
    return CarEntity(
      id: doc['id'] as String,
      customerId: doc['customerId'] as String,
      modelName: doc['modelName'] as String,
      plateNumber: doc['plateNumber'] as String,
      serviceAdviser: doc['serviceAdviser'] as String,
      arrivalDate: DateTime.parse(doc['arrivalDate']),
      jobDetails: doc['jobDetails'] as String,
      jobType: doc['jobType'] as List<String>,
      cost: doc['cost'] as double,
      isApproved: doc['isApproved'] as bool,
      approvalDate: DateTime.parse(doc['approvalDate']),
      paymentStatus: doc['paymentStatus'] as String,
      paymentMade: doc['paymentMade'] as double,
      paymentHistory: doc['paymentHistory'] as List<Map<double, String>>,
      repairStatus: doc['repairStatus'] as String,
      repairDetails: doc['repairDetails'] as String,
      departureDate: DateTime.parse(doc['departureDate']),
    );
  }

  @override
  String toString() {
    return '''CarEntity: {
      id: $id
      customerId: $customerId
      modelName: $modelName
      plateNumber: $plateNumber
      serviceAdviser: $serviceAdviser
      arrivalDate: $arrivalDate
      jobDetails: $jobDetails
      jobType: $jobType
      cost: $cost
      isApproved: $isApproved
      approvalDate: $approvalDate
      paymentStatus: $paymentStatus
      paymentMade: $paymentMade
      paymentHistory: $paymentHistory
      repairStatus: $repairStatus
      repairDetails: $repairDetails
      departureDate: $departureDate
    }''';
  }

  @override
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
