import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String id;
  final String customerId;
  final String modelName;
  final String plateNumber;
  final String picture;
  final String serviceAdviser;
  final String technician;
  final DateTime arrivalDate;
  final String jobDetails;
  final List<dynamic> jobType;
  final double cost;
  final bool isApproved;
  final DateTime approvalDate;
  final String paymentStatus;
  final double paymentMade;
  final List<dynamic> paymentHistory;
  final String repairStatus;
  final String repairDetails;
  final DateTime departureDate;
  final DateTime pickUpDate;
  final String customerName;
  final String customerMobile;
  final String customerStatus;
  final String engineModel;
  final String vin;
  final String meterReading;
  final String manufactureYear;
  final String fuelLevel;
  final String color;

  const CarEntity({
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

  /// Converts the car entity to a document to be stored to firebase
  Map<String, Object> toDocument() {
    return {
      'id': id,
      'customerId': customerId,
      'modelName': modelName,
      'plateNumber': plateNumber,
      'picture': picture,
      'serviceAdviser': serviceAdviser,
      'technician': technician,
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
      'pickUpDate': pickUpDate,
      'customerName': customerName,
      'customerMobile': customerMobile,
      'customerStatus': customerStatus,
      'engineModel': engineModel,
      'vin': vin,
      'meterReading': meterReading,
      'manufactureYear': manufactureYear,
      'fuelLevel': fuelLevel,
      'color': color,
    };
  }

  /// Converts a document from firebase to a car entity
  static CarEntity fromDocument(Map<String, dynamic> doc) {
    return CarEntity(
      id: doc['id'] as String,
      customerId: doc['customerId'] as String,
      modelName: doc['modelName'] as String,
      plateNumber: doc['plateNumber'] as String,
      picture: doc['picture'] as String,
      serviceAdviser: doc['serviceAdviser'] as String,
      technician: doc['technician'] as String,
      arrivalDate: (doc['arrivalDate'] as Timestamp).toDate(),
      jobDetails: doc['jobDetails'] as String,
      jobType: doc['jobType'] as List<dynamic>,
      cost: doc['cost'] as double,
      isApproved: doc['isApproved'] as bool,
      approvalDate: (doc['approvalDate'] as Timestamp).toDate(),
      paymentStatus: doc['paymentStatus'] as String,
      paymentMade: doc['paymentMade'] as double,
      paymentHistory: doc['paymentHistory'] as List<dynamic>,
      repairStatus: doc['repairStatus'] as String,
      repairDetails: doc['repairDetails'] as String,
      departureDate: (doc['departureDate'] as Timestamp).toDate(),
      pickUpDate: (doc['pickUpDate'] as Timestamp).toDate(),
      customerName: doc['customerName'] as String,
      customerMobile: doc['customerMobile'] as String,
      customerStatus: doc['customerStatus'] as String,
      engineModel: doc['engineModel'] as String,
      vin: doc['vin'] as String,
      meterReading: doc['meterReading'] as String,
      manufactureYear: doc['manufactureYear'] as String,
      fuelLevel: doc['fuelLevel'] as String,
      color: doc['color'] as String,
    );
  }

  @override
  String toString() {
    return '''CarEntity: {
      id: $id
      customerId: $customerId
      modelName: $modelName
      plateNumber: $plateNumber
      picture: $picture
      serviceAdviser: $serviceAdviser
      technician: $technician
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
      pickUpDate: $pickUpDate
      customerName: $customerName
      customerMobile: $customerMobile
      customerStatus: $customerStatus
      engineModel: $engineModel
      vin: $vin
      meterReading: $meterReading
      manufactureYear: $manufactureYear
      fuelLevel: $fuelLevel
      color: $color
    }''';
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
