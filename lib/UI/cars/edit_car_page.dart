import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:user_repository/user_repository.dart';
import '../../Components/custom_button.dart';
import '../../Components/functions.dart';
import '../../Components/text_field.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Logic/blocs/my_user_bloc/my_user_bloc.dart';
import '../../Logic/cubits/delete_data_cubit/delete_data_cubit.dart';
import '../Theme/text_theme.dart';

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
  late MyUser user;
  double amountPaid = 0;
  String? selectedTechnician; // Variable to store the technician
  DateTime? selectedDate;

  @override
  void initState() {
    newCar = widget.car;
    user = BlocProvider.of<MyUserBloc>(context).state.user!;
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
        newCar.departureDate.toUtc() != Functions.emptyDate ? true : false;
    arrivalDateController.text =
        DateFormat('dd-MM-yyyy').format(newCar.arrivalDate);
    pickUpDateDateController.text =
        newCar.pickUpDate.toUtc() != Functions.emptyDate
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
          Functions.hideLoadingPage(context);

          // Emit GetAllCars to refresh the data in the home page
          context.read<GetDataCubit>().getData();

          // pop the screen
          Navigator.pop(context);
        } else if (state is SaveDataLoading) {
          Functions.showLoadingPage(context);
        } else if (state is SaveDataFailure) {
          Functions.hideLoadingPage(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
            if (user.userType == 'admin')
              BlocListener<DeleteDataCubit, DeleteDataState>(
                listener: (context, state) {
                  if (state.status == DeleteDataStatus.success) {
                    Functions.hideLoadingPage(context);

                    // Emit GetAllCars to refresh the data in the home page
                    BlocProvider.of<GetDataCubit>(context).getData();

                    // pop the screen
                    Navigator.pop(context);
                  } else if (state.status == DeleteDataStatus.loading) {
                    Functions.showLoadingPage(context);
                  } else if (state.status == DeleteDataStatus.failure) {
                    Functions.hideLoadingPage(context);

                    // pop the screen
                    Navigator.pop(context);
                  }
                },
                child: IconButton(
                  onPressed: () {
                    Functions.deleteData(
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
                  Text('Edit Model Name', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Edit Plate Number', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Date of Arrival', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Edit Service Adviser', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Edit Job Details', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Edit Job Type', style: TextThemes.text),
                  const SizedBox(height: 2),
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

                  const SizedBox(height: 2),

                  if (selectedJobTypes.isNotEmpty)
                    Text(Functions.joinArrayContents(selectedJobTypes),
                        style: TextThemes.text.copyWith(fontSize: 11.5)),

                  if (selectedJobTypes.isEmpty)
                    Text('Select one job or more',
                        style: TextThemes.text.copyWith(color: Colors.red)),

                  const SizedBox(height: 10),

                  // Technician
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Edit Technician", style: TextThemes.text),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            menuWidth: deviceWidth * 0.5,
                            menuMaxHeight: deviceHeight * 0.5,
                            padding: const EdgeInsets.only(left: 12, right: 10),
                            value: selectedTechnician,
                            isExpanded: true,
                            hint: const Text('pick a technician'),
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
                  if (user.userType == 'admin')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edit Cost of repair', style: TextThemes.text),
                        const SizedBox(height: 2),
                        MyTextField(
                          controller: costController,
                          hintText: 'Enter Amount',
                          prefixText: '₦ ',
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),

                  // is Approved
                  Text('Edit Approval Status', style: TextThemes.text),
                  const SizedBox(height: 2),
                  CheckboxListTile(
                    value: isApproved,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isApproved = newValue;
                      });
                    },
                    title: Text('Is vehicle Approved?',
                        style: TextThemes.text.copyWith(fontSize: 12)),
                    activeColor: AppColor.mainGreen,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Payment made
                  if (user.userType == 'admin')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edit Amount Paid', style: TextThemes.text),
                        const SizedBox(height: 2),
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
                                scrollable: true,
                                title: Text('Payment History',
                                    style: TextThemes.headline1),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: paymentHistory.map((payment) {
                                        // Convert the Timestamp to DateTIme
                                        DateTime date =
                                            (payment['date'] as Timestamp)
                                                .toDate();
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date);
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
                                    const SizedBox(height: 10),

                                    // Cost
                                    Text('Add payment', style: TextThemes.text),
                                    const SizedBox(height: 2),
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
                                      color: const Color.fromRGBO(
                                          66, 178, 132, 1.0),
                                      text: 'Add payment',
                                      onPressed: () {
                                        if (paidAmountController
                                            .text.isNotEmpty) {
                                          setState(() {
                                            amountPaid = amountPaid +
                                                Functions.parseDouble(
                                                    paidAmountController.text);
                                            paymentHistory.add({
                                              'amount': Functions.parseDouble(
                                                  paidAmountController.text),
                                              'date': Timestamp.fromDate(
                                                  DateTime.now()),
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
                      ],
                    ),

                  // Pick-Up date
                  Text('Date of Pick-Up', style: TextThemes.text),
                  const SizedBox(height: 2),
                  MyTextField(
                    prefixIcon: const Icon(Icons.calendar_today),
                    controller: pickUpDateDateController,
                    hintText: 'Enter Pick-Up date',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () {
                      Functions.selectDate(context, (pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            pickUpDateDateController.text =
                                pickedDate.toString().split(" ")[0];
                            selectedDate = pickedDate;
                          });
                        }
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  // Repair status
                  Text('Edit Repair status', style: TextThemes.text),
                  const SizedBox(height: 2),
                  CheckboxListTile(
                    value: isRepaired,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isRepaired = newValue;
                      });
                    },
                    title: Text('Is vehicle Repaired?',
                        style: TextThemes.text.copyWith(fontSize: 12)),
                    activeColor: const Color.fromRGBO(66, 178, 132, 1.0),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Repair Details
                  Text('Edit Repair Details', style: TextThemes.text),
                  const SizedBox(height: 2),
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
                  Text('Edit Pick up status', style: TextThemes.text),
                  const SizedBox(height: 2),
                  CheckboxListTile(
                    value: isDeparted,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isDeparted = newValue;
                      });
                    },
                    title: Text('Is vehicle out of compound?',
                        style: TextThemes.text.copyWith(fontSize: 12)),
                    activeColor: AppColor.mainGreen,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Update record
                  if (user.userType == 'admin')
                    CustomButton(
                      width: double.infinity,
                      height: 45,
                      color: AppColor.mainGreen,
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
                              ? Functions.parseDouble(costController.text)
                              : newCar.cost;
                          newCar.isApproved = isApproved!;
                          newCar.approvalDate = (isApproved! &
                                  (newCar.approvalDate.toUtc() ==
                                      Functions.emptyDate))
                              ? DateTime.now()
                              : newCar.approvalDate;
                          newCar.paymentStatus = (amountPaid >=
                                  Functions.parseDouble(costController.text))
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
                                      Functions.emptyDate))
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

  DropdownMenuItem technicianList(String technician) => DropdownMenuItem(
        value: technician,
        child: Text(
          technician,
        ),
      );
}
