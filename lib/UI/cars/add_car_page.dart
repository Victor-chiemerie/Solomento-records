import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import '../../Components/custom_button.dart';
import '../../Components/text_field.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key, required this.customer});

  final Customer customer;

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  final modelNameController = TextEditingController();
  final plateNumberController = TextEditingController();
  final serviceAdviserController = TextEditingController();
  final jobDetailsController = TextEditingController();
  final costController = TextEditingController();
  final paidAmountController = TextEditingController();
  final repairDetailsController = TextEditingController();

  final jobTypes = [
    'Mechanical',
    'Electrical',
    'Body Work',
    'Air Conditioning',
    'Painting',
  ];
  bool? isApproved = false;
  bool? isRepaired = false;
  bool? isDeparted = false;
  List<String> selectedJobTypes = [];
  late Car car;

  @override
  void initState() {
    car = Car.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveDataBloc, SaveDataState>(
      listener: (context, state) {
        if (state is SaveDataSuccess) {
          hideLoadingPage(context);
          // pop till home screen
          Navigator.popUntil(context, (route) {
            return route.isFirst;
          });
        } else if (state is SaveDataLoading) {
          showLoadingPage(context);
        } else if (state is SaveDataFailure) {
          hideLoadingPage(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add customer vehicle'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Model name
                  const Text('Model Name'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: modelNameController,
                    hintText: 'Enter Model Name',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Plate number
                  const Text('Plate Number'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: plateNumberController,
                    hintText: 'Enter Plate Number',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Service adviser
                  const Text('Service Adviser'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: serviceAdviserController,
                    hintText: 'Enter Service Adviser',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Job Details
                  const Text('Job Details'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: jobDetailsController,
                    hintText: 'Enter Job Details',
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Job Type
                  const Text('Job Type'),
                  const SizedBox(height: 10),
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: Colors.white,
                    text: 'select job type',
                    border: Border.all(),
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) => MultiSelectDialog(
                          jobTypes: jobTypes,
                          selectedJobTypes: selectedJobTypes,
                        ),
                      );

                      // Update `selectedJobTypes` if there's a result and rebuild the UI
                      if (result != null) {
                        setState(() {
                          selectedJobTypes = result;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 5),

                  if (selectedJobTypes.isNotEmpty)
                    Text(joinArrayContents(selectedJobTypes)),

                  if (selectedJobTypes.isEmpty)
                    const Text(
                      'Select one job or more',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),

                  const SizedBox(height: 10),

                  // Cost
                  const Text('Cost of repair (optional)'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: costController,
                    hintText: 'Enter Amount',
                    prefixText: '₦ ',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),

                  const SizedBox(height: 10),

                  // is Approved
                  const Text('Approval Status'),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: isApproved,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isApproved = newValue;
                      });
                    },
                    title: const Text('Is vehicle Approved?'),
                    activeColor: const Color.fromRGBO(66, 178, 132, 1.0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Payment made
                  const Text('Amount Paid (optional)'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: paidAmountController,
                    hintText: 'Enter Amount',
                    prefixText: '₦ ',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    readOnly: true,
                  ),

                  const SizedBox(height: 10),

                  // Repair status
                  const Text('Repair status'),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: isRepaired,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isRepaired = newValue;
                      });
                    },
                    title: const Text('Is vehicle Repaired?'),
                    activeColor: const Color.fromRGBO(66, 178, 132, 1.0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Repair Details
                  const Text('Repair Details (optional)'),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: repairDetailsController,
                    hintText: 'Enter Repair Details',
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                  ),

                  const SizedBox(height: 10),

                  // is Departed
                  const Text('Pick up status'),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: isDeparted,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isDeparted = newValue;
                      });
                    },
                    title: const Text('Is vehicle out of compound?'),
                    activeColor: const Color.fromRGBO(66, 178, 132, 1.0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Save record
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: const Color.fromRGBO(66, 178, 132, 1.0),
                    text: 'Save',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &
                          selectedJobTypes.isNotEmpty) {
                        car.modelName = modelNameController.text;
                        car.plateNumber = plateNumberController.text;
                        car.serviceAdviser = serviceAdviserController.text;
                        car.arrivalDate = DateTime.now();
                        car.jobDetails = jobDetailsController.text;
                        car.jobType = selectedJobTypes;
                        car.cost = (costController.text.isNotEmpty)
                            ? parseDouble(costController.text)
                            : car.cost;
                        car.isApproved = isApproved!;
                        car.approvalDate =
                            (isApproved!) ? DateTime.now() : car.approvalDate;
                        car.paymentStatus =
                            (parseDouble(paidAmountController.text) >=
                                    parseDouble(costController.text))
                                ? "Complete"
                                : car.paymentStatus;
                        car.paymentMade = (paidAmountController.text.isNotEmpty)
                            ? parseDouble(paidAmountController.text)
                            : car.paymentMade;
                        car.paymentHistory = (paidAmountController
                                .text.isNotEmpty)
                            ? [
                                {
                                  'date': DateTime.now(),
                                  'amount':
                                      parseDouble(paidAmountController.text),
                                }
                              ]
                            : car.paymentHistory;
                        car.repairStatus = (isRepaired!) ? "Fixed" : "Pending";
                        car.repairDetails =
                            (repairDetailsController.text.isNotEmpty)
                                ? repairDetailsController.text
                                : car.repairDetails;
                        car.departureDate =
                            (isDeparted!) ? DateTime.now() : car.departureDate;

                        log(car.toString());

                        context
                            .read<SaveDataBloc>()
                            .add(SaveCustomerAndCar(widget.customer, car));
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // join array variables
  String joinArrayContents(List<dynamic> array) {
    return array.join(', ');
  }

  // Helper function to safely parse text to double
  double parseDouble(String text, {double defaultValue = 0.0}) {
    try {
      return double.parse(text);
    } catch (e) {
      return defaultValue; // Or handle the error in another way if needed
    }
  }

  void showLoadingPage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button press
          child: Stack(
            children: [
              // Blurry background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    color: const Color.fromARGB(255, 70, 70, 70)
                        .withOpacity(0.3), // Semi-transparent dark overlay
                  ),
                ),
              ),
              // Loading indicator in the center
              const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(66, 178, 132, 1.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingPage(BuildContext context) {
    // If the dialog is still shown, pop it
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
