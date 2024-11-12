import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import '../../Components/custom_button.dart';
import '../../Components/hide_loading.dart';
import '../../Components/show_loading.dart';
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

  final technicians = [
    'Stanley',
    'OJ',
    'Ebube',
    'Chika',
    'Leo',
    'Adewale',
    'Peter',
    'Nonso',
    'Uche',
    'Emma',
    'Family man',
  ];

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
  String? selectedTechnician; // Variable to store the technician
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

          // Emit GetAllCars to refresh the data in the home page
          BlocProvider.of<GetDataCubit>(context).getData();

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

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Technician",
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedTechnician,
                            isExpanded: true,
                            hint: const Text(
                              'pick a technician',
                            ),
                            items: technicians.map(technicianList).toList(),
                            onChanged: (value) {
                              setState(() => selectedTechnician = value);
                            },
                          ),
                        ),
                      ],
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
                        car.technician = (selectedTechnician != null)
                            ? selectedTechnician!
                            : car.technician;
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

  DropdownMenuItem technicianList(String technician) => DropdownMenuItem(
        value: technician,
        child: Text(
          technician,
        ),
      );

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
}
