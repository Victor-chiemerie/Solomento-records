import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:user_repository/user_repository.dart';

import '../../Components/functions.dart';
import '../../Logic/blocs/my_user_bloc/my_user_bloc.dart';
import '../Theme/text_theme.dart';
import 'edit_car_page.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key, required this.car});

  final Car car;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  late MyUser user;
  List<String> jobTypes = [];
  List<Map<String, dynamic>> paymentHistory = [];
  late bool isRepaired;

  @override
  void initState() {
    user = BlocProvider.of<MyUserBloc>(context).state.user ?? MyUser.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    jobTypes = List<String>.from(car.jobType);
    paymentHistory = List<Map<String, dynamic>>.from(car.paymentHistory);
    isRepaired = car.repairStatus == 'Fixed' ? true : false;
    final String pickUpDate = (car.pickUpDate.toUtc() != Functions.emptyDate)
        ? Functions.shortenDate(DateFormat('dd-MM-yyyy').format(car.pickUpDate))
        : 'Not set';
    final String departureDate =
        (car.departureDate.toUtc() != Functions.emptyDate)
            ? Functions.shortenDate(
                DateFormat('dd-MM-yyyy').format(car.departureDate))
            : 'Not set';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Car details',
          style: TextThemes.headline1.copyWith(fontSize: 20),
        ),
        actions: [
          if (user.userType == 'admin' || user.userType == 'supervisor')
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditCarPage(car: car)));
              },
              child: Text(
                'Edit car',
                style: TextThemes.text
                    .copyWith(color: Colors.blueAccent, fontSize: 15),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // car info section
              ExpansionTile(
                initiallyExpanded: true,
                iconColor: AppColor.mainGreen,
                title: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.mainGreen,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Car Information',
                    style: TextThemes.text.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // picture
                      Card(
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child:
                              const Icon(CupertinoIcons.car_detailed, size: 35),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // model name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Model Name",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.modelName,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // plate number
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Plate Number",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.plateNumber,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // VIN
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("VIN",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.vin,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // Manufacture Year
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Year of MFD",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.manufactureYear,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // Fuel level
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Fuel Level",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.fuelLevel,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // Meter Reading
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Meter Reading",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      '${car.meterReading}KM',
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                                Divider(height: 4, color: Colors.grey),
                                // Color
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Color",
                                        style: TextThemes.text.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      car.color,
                                      style: TextThemes.text
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // personnel info section
              ExpansionTile(
                iconColor: AppColor.mainGreen,
                title: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.mainGreen,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Personnel Information',
                    style: TextThemes.text.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Service Adviser
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Service Adviser",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                car.serviceAdviser,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Technician
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Technician",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                car.technician,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // job info section
              ExpansionTile(
                iconColor: AppColor.mainGreen,
                title: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.mainGreen,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Job Information',
                    style: TextThemes.text.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Arrival Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Arrival Date",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(car.arrivalDate),
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Job Description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Job Description",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                car.jobDetails,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Job Type
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Job Type",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                Functions.joinArrayContents(jobTypes),
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          CheckboxListTile(
                            value: car.isApproved,
                            tileColor: Colors.grey.shade200,
                            selected: car.isApproved,
                            selectedTileColor:
                                AppColor.mainGreen.withOpacity(0.3),
                            onChanged: (bool? newValue) {},
                            title: Text('Is vehicle Approved?',
                                style: TextThemes.text.copyWith(fontSize: 12)),
                            activeColor: AppColor.mainGreen,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // cost and payment info section
              if (user.userType == 'admin')
                ExpansionTile(
                  iconColor: AppColor.mainGreen,
                  title: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.mainGreen,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'Cost and Payment Information',
                      style: TextThemes.text.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cost of Repair
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cost of Repair",
                                    style: TextThemes.text
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  '₦ ${car.cost.toString()}',
                                  style: TextThemes.text.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            Divider(height: 4, color: Colors.grey),
                            // Payment History
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Payment History",
                                    style: TextThemes.text
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: paymentHistory.map((payment) {
                                    // Convert the Timestamp to DateTIme
                                    DateTime date =
                                        (payment['date'] as Timestamp).toDate();
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy').format(date);
                                    String formattedAmount =
                                        Functions.formatAmount(
                                            payment['amount']);

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('⚈  ₦$formattedAmount',
                                            style: TextThemes.text),
                                        Text(formattedDate,
                                            style: TextThemes.text),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              // repair info section
              ExpansionTile(
                iconColor: AppColor.mainGreen,
                title: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.mainGreen,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Repair Information',
                    style: TextThemes.text.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Repair Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Repair Status",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              CheckboxListTile(
                                value: isRepaired,
                                tileColor: Colors.grey.shade200,
                                selected: isRepaired,
                                selectedTileColor:
                                    AppColor.mainGreen.withOpacity(0.3),
                                onChanged: (bool? newValue) {},
                                title: Text('Is vehicle Repaired?',
                                    style:
                                        TextThemes.text.copyWith(fontSize: 12)),
                                activeColor: AppColor.mainGreen,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Repair Description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Repair Description",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                car.repairDetails,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Pick up Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Promised Delivery Date",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                pickUpDate,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Departure Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pick up Status",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              CheckboxListTile(
                                value: isRepaired,
                                tileColor: Colors.grey.shade200,
                                selected: isRepaired,
                                selectedTileColor:
                                    AppColor.mainGreen.withOpacity(0.3),
                                onChanged: (bool? newValue) {},
                                title: Text('Is vehicle out of compound?',
                                    style:
                                        TextThemes.text.copyWith(fontSize: 12)),
                                activeColor: AppColor.mainGreen,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 4, color: Colors.grey),
                          // Departure Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Departure Date",
                                  style: TextThemes.text
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                departureDate,
                                style: TextThemes.text.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
