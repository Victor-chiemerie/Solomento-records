import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/functions.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import '../../Components/custom_button.dart';
import '../../Components/text_field.dart';
import '../Theme/text_theme.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage(
      {super.key, required this.customerName, required this.customerMobile});

  final String customerName;
  final String customerMobile;

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
  final pickUpDateDateController = TextEditingController();

  final technicians = [
    'Chika',
    'OJ',
    'Ebube',
    'Stanley',
    'Uche',
    'Adewale',
    'Solue',
    'Leo',
    'Emma',
    'Family man',
    'Outsider',
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
  DateTime? selectedDate;
  late Car car;

  @override
  void initState() {
    car = Car.empty;
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
          BlocProvider.of<GetDataCubit>(context).getData();

          // pop till home screen
          Navigator.popUntil(context, (route) {
            return route.isFirst;
          });
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
            'Add customer vehicle',
            style: TextThemes.headline1.copyWith(fontSize: 20),
          ),
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
                  Text('Model Name', style: TextThemes.text),
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
                  Text('Plate Number', style: TextThemes.text),
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

                  // Service adviser
                  Text('Service Adviser', style: TextThemes.text),
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
                  Text('Job Details', style: TextThemes.text),
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
                  Text('Job Type', style: TextThemes.text),
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

                  const SizedBox(height: 5),

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
                      Text("Technician", style: TextThemes.text),
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
                  const Text('Cost of repair (optional)'),
                  const SizedBox(height: 2),
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
                  Text('Approval Status', style: TextThemes.text),
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
                  Text('Amount Paid (optional)', style: TextThemes.text),
                  const SizedBox(height: 2),
                  MyTextField(
                    controller: paidAmountController,
                    hintText: 'Enter Amount',
                    prefixText: '₦ ',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),

                  const SizedBox(height: 10),

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
                  Text('Repair status', style: TextThemes.text),
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
                    activeColor: AppColor.mainGreen,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: const BorderSide(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Repair Details
                  Text('Repair Details (optional)', style: TextThemes.text),
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
                  Text('Pick up status', style: TextThemes.text),
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

                  // Save record
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: AppColor.mainGreen,
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
                            ? Functions.parseDouble(costController.text)
                            : car.cost;
                        car.isApproved = isApproved!;
                        car.pickUpDate = (selectedDate != null)
                            ? selectedDate!
                            : car.pickUpDate;
                        car.approvalDate =
                            (isApproved!) ? DateTime.now() : car.approvalDate;
                        car.paymentStatus =
                            (Functions.parseDouble(paidAmountController.text) >=
                                    Functions.parseDouble(costController.text))
                                ? "Complete"
                                : car.paymentStatus;
                        car.paymentMade = (paidAmountController.text.isNotEmpty)
                            ? Functions.parseDouble(paidAmountController.text)
                            : car.paymentMade;
                        car.paymentHistory =
                            (paidAmountController.text.isNotEmpty)
                                ? [
                                    {
                                      'date': DateTime.now(),
                                      'amount': Functions.parseDouble(
                                          paidAmountController.text),
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
                        car.customerName = widget.customerName;
                        car.customerMobile = widget.customerMobile;

                        context
                            .read<SaveDataBloc>()
                            .add(SaveCar(car));
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
