import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import '../../Components/custom_button.dart';
import '../../Components/deleteData.dart';
import '../../Components/format_amount.dart';
import '../../Components/hide_loading.dart';
import '../../Components/show_loading.dart';
import '../../Components/text_field.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Logic/cubits/delete_data_cubit/delete_data_cubit.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({super.key, required this.car});

  final Car car;

  @override
  State<EditCarPage> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final _formKey = GlobalKey<FormState>();
  final modelNameController = TextEditingController();
  final plateNumberController = TextEditingController();
  final serviceAdviserController = TextEditingController();
  final jobDetailsController = TextEditingController();
  final costController = TextEditingController();
  final paidAmountController = TextEditingController();
  final repairDetailsController = TextEditingController();
  final arrivalDateController = TextEditingController();
  final pickUpDateDateController = TextEditingController();

  final jobTypes = [
    'Mechanical',
    'Electrical',
    'Body Work',
    'Air Conditioning',
    'Painting',
  ];
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
  bool? isApproved = false;
  bool? isRepaired = false;
  bool? isDeparted = false;
  List<String> selectedJobTypes = [];
  List<Map<String, dynamic>> paymentHistory = [];
  late Car newCar;
  double amountPaid = 0;
  String? selectedTechnician; // Variable to store the technician
  DateTime? selectedDate;

  @override
  void initState() {
    newCar = widget.car;
    modelNameController.text = newCar.modelName;
    plateNumberController.text = newCar.plateNumber;
    serviceAdviserController.text = newCar.serviceAdviser;
    jobDetailsController.text = newCar.jobDetails;
    selectedTechnician =
        (newCar.technician.isNotEmpty) ? newCar.technician : null;
    costController.text = newCar.cost.toString();
    amountPaid = newCar.paymentMade;
    repairDetailsController.text = newCar.repairDetails;
    selectedJobTypes = List<String>.from(newCar.jobType);
    paymentHistory = List<Map<String, dynamic>>.from(newCar.paymentHistory);
    isApproved = newCar.isApproved;
    isRepaired = newCar.repairStatus == 'Fixed' ? true : false;
    isDeparted =
        newCar.departureDate.toUtc() != DateTime.utc(1999, 7, 20, 20, 18, 04)
            ? true
            : false;
    arrivalDateController.text =
        DateFormat('dd-MM-yyyy').format(newCar.arrivalDate);
    pickUpDateDateController.text =
        newCar.pickUpDate.toUtc() != DateTime.utc(1999, 7, 20, 20, 18, 04)
            ? DateFormat('dd-MM-yyyy').format(newCar.pickUpDate)
            : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return BlocListener<SaveDataBloc, SaveDataState>(
      listener: (context, state) {
        if (state is SaveDataSuccess) {
          hideLoadingPage(context);

          // Emit GetAllCars to refresh the data in the home page
          context.read<GetDataCubit>().getData();

          // pop the screen
          Navigator.pop(context);
        } else if (state is SaveDataLoading) {
          showLoadingPage(context);
        } else if (state is SaveDataFailure) {
          hideLoadingPage(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Car details'),
          actions: [
            BlocListener<DeleteDataCubit, DeleteDataState>(
              listener: (context, state) {
                if (state.status == DeleteDataStatus.success) {
                  hideLoadingPage(context);

                  // Emit GetAllCars to refresh the data in the home page
                  BlocProvider.of<GetDataCubit>(context).getData();

                  // pop the screen
                  Navigator.pop(context);
                } else if (state.status == DeleteDataStatus.loading) {
                  showLoadingPage(context);
                } else if (state.status == DeleteDataStatus.failure) {
                  hideLoadingPage(context);

                  // pop the screen
                  Navigator.pop(context);
                }
              },
              child: IconButton(
                onPressed: () {
                  deleteData(
                    context,
                    newCar,
                    () => BlocProvider.of<DeleteDataCubit>(context)
                        .deleteData(newCar),
                  );
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
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
                  // car picture
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.car_detailed, size: 35),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Model name
                  const Text('Edit Model Name'),
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
                  const Text('Edit Plate Number'),
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

                  // Arrival date
                  const Text('Date of Arrival'),
                  const SizedBox(height: 10),
                  MyTextField(
                    prefixIcon: const Icon(Icons.calendar_today),
                    controller: arrivalDateController,
                    hintText: 'Enter Arrival date',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                  ),

                  const SizedBox(height: 10),

                  // Service adviser
                  const Text('Edit Service Adviser'),
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
                  const Text('Edit Job Details'),
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
                  const Text('Edit Job Type'),
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

                  // Technician
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Edit Technician",
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            menuWidth: deviceWidth * 0.5,
                            menuMaxHeight: deviceHeight * 0.5,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Cost
                  const Text('Edit Cost of repair'),
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
                  const Text('Edit Approval Status'),
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
                  const Text('Edit Amount Paid'),
                  const SizedBox(height: 10),
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: Colors.white,
                    text: 'view and add new payment',
                    border: Border.all(),
                    onPressed: () {
                      // show dialog box with trasaction history
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Payment History'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: paymentHistory.map((payment) {
                                  // Convert the Timestamp to DateTIme
                                  DateTime date =
                                      (payment['date'] as Timestamp).toDate();
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy').format(date);
                                  String formattedAmount =
                                      formatAmount(payment['amount']);

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('₦$formattedAmount',
                                          style: const TextStyle(fontSize: 16)),
                                      Text(formattedDate,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 10),

                              // Cost
                              const Text('Add payment'),
                              const SizedBox(height: 10),
                              MyTextField(
                                controller: paidAmountController,
                                hintText: 'Enter Amount',
                                prefixText: '₦ ',
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Add payment
                              CustomButton(
                                width: double.infinity,
                                height: 45,
                                color: const Color.fromRGBO(66, 178, 132, 1.0),
                                text: 'Add payment',
                                onPressed: () {
                                  if (paidAmountController.text.isNotEmpty) {
                                    setState(() {
                                      amountPaid = amountPaid +
                                          parseDouble(
                                              paidAmountController.text);
                                      paymentHistory.add({
                                        'amount': parseDouble(
                                            paidAmountController.text),
                                        'date':
                                            Timestamp.fromDate(DateTime.now()),
                                      });
                                    });
                                  }
                                  Navigator.pop(context);
                                  paidAmountController.clear();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  // Pick-Up date
                  const Text('Date of Pick-Up'),
                  const SizedBox(height: 10),
                  MyTextField(
                    prefixIcon: const Icon(Icons.calendar_today),
                    controller: pickUpDateDateController,
                    hintText: 'Enter Pick-Up date',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () {
                      _selecDate();
                    },
                  ),

                  const SizedBox(height: 10),

                  // Repair status
                  const Text('Edit Repair status'),
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
                  const Text('Edit Repair Details'),
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
                  const Text('Edit Pick up status'),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: isDeparted,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isDeparted = newValue;
                      });
                      print('Is departed = $isDeparted');
                    },
                    title: const Text('Is vehicle out of compound?'),
                    activeColor: const Color.fromRGBO(66, 178, 132, 1.0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Update record
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: const Color.fromRGBO(66, 178, 132, 1.0),
                    text: 'Update details',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &
                          selectedJobTypes.isNotEmpty) {
                        newCar.modelName = modelNameController.text;
                        newCar.plateNumber = plateNumberController.text;
                        newCar.serviceAdviser = serviceAdviserController.text;
                        newCar.technician = (selectedTechnician != null)
                            ? selectedTechnician!
                            : newCar.technician;
                        newCar.jobDetails = jobDetailsController.text;
                        newCar.jobType = selectedJobTypes;
                        newCar.cost = (costController.text.isNotEmpty)
                            ? parseDouble(costController.text)
                            : newCar.cost;
                        newCar.isApproved = isApproved!;
                        newCar.approvalDate = (isApproved! &
                                (newCar.approvalDate.toUtc() ==
                                    DateTime.utc(1999, 7, 20, 20, 18, 04)))
                            ? DateTime.now()
                            : newCar.approvalDate;
                        newCar.paymentStatus =
                            (amountPaid >= parseDouble(costController.text))
                                ? "Complete"
                                : newCar.paymentStatus;
                        newCar.paymentMade = amountPaid;
                        newCar.paymentHistory = paymentHistory;
                        newCar.repairStatus =
                            (isRepaired!) ? "Fixed" : "Pending";
                        newCar.repairDetails =
                            (repairDetailsController.text.isNotEmpty)
                                ? repairDetailsController.text
                                : newCar.repairDetails;
                        newCar.departureDate = (isDeparted! &
                                (newCar.departureDate.toUtc() ==
                                    DateTime.utc(1999, 7, 20, 20, 18, 04)))
                            ? DateTime.now()
                            : newCar.departureDate;
                        newCar.pickUpDate = (selectedDate != null)
                            ? selectedDate!
                            : newCar.pickUpDate;

                        context
                            .read<SaveDataBloc>()
                            .add(UpdateCarData(newCar.id, newCar));
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

  // calendar
  Future<void> _selecDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        pickUpDateDateController.text = _picked.toString().split(" ")[0];
        selectedDate = _picked;
      });
    }
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
