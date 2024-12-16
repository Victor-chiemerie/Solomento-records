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
  final vinController = TextEditingController();
  final manufactureYearController = TextEditingController();
  final fuelLevelController = TextEditingController();
  final meterReadingController = TextEditingController();
  final colorController = TextEditingController();
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
  bool hasCarInfoError = false;
  bool hasPersonnelInfoError = false;
  bool hasJobInfoError = false;

  @override
  void initState() {
    newCar = widget.car;
    user = BlocProvider.of<MyUserBloc>(context).state.user!;
    modelNameController.text = newCar.modelName;
    plateNumberController.text = newCar.plateNumber;
    vinController.text = newCar.vin;
    manufactureYearController.text = newCar.manufactureYear;
    fuelLevelController.text = newCar.fuelLevel;
    meterReadingController.text = newCar.meterReading;
    colorController.text = newCar.color;
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
                  // Car Information
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    initiallyExpanded: true,
                    maintainState: true,
                    iconColor: AppColor.mainGreen,
                    title: Text(
                      'Car Information',
                      style: TextThemes.text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: hasCarInfoError ? Colors.red : Colors.black,
                      ),
                    ),
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
                          child:
                              const Icon(CupertinoIcons.car_detailed, size: 35),
                        ),
                      ),
                      // Model name
                      Text('Model Name', style: TextThemes.text),
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

                      // Vin
                      Text('VIN (Optional)', style: TextThemes.text),
                      MyTextField(
                        controller: vinController,
                        hintText: 'Enter VIN',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),

                      // Manufacture Year
                      Text('Manufacture Year (Optional)',
                          style: TextThemes.text),
                      MyTextField(
                        controller: manufactureYearController,
                        hintText: 'Enter MeManufacture Year',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),

                      // Fuel Level
                      Text('Fuel Level (Optional)', style: TextThemes.text),
                      MyTextField(
                        controller: fuelLevelController,
                        hintText: 'Enter Fuel Level',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),

                      // Meter Reading
                      Text('Meter Reading (Optional)', style: TextThemes.text),
                      MyTextField(
                        controller: meterReadingController,
                        hintText: 'Enter Meter Reading',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 10),

                      // Car Color
                      Text('Car Color (Optional)', style: TextThemes.text),
                      MyTextField(
                        controller: colorController,
                        hintText: 'Enter Car Color',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),

                  // Personnel Information
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    maintainState: true,
                    iconColor: AppColor.mainGreen,
                    title: Text(
                      'Personnel Information',
                      style: TextThemes.text.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            hasPersonnelInfoError ? Colors.red : Colors.black,
                      ),
                    ),
                    children: [
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

                      // Technician
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Technician (Optional)", style: TextThemes.text),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                menuWidth: deviceWidth * 0.5,
                                menuMaxHeight: deviceHeight * 0.5,
                                padding:
                                    const EdgeInsets.only(left: 12, right: 10),
                                value: selectedTechnician,
                                isExpanded: true,
                                hint: Text(
                                  'pick a technician',
                                  style: TextStyle(color: Colors.grey[500]),
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

                      const SizedBox(height: 5),
                    ],
                  ),

                  // Job Information
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    maintainState: true,
                    iconColor: AppColor.mainGreen,
                    title: Text(
                      'Job Information',
                      style: TextThemes.text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: hasJobInfoError ? Colors.red : Colors.black,
                      ),
                    ),
                    children: [
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
                        color: Colors.grey.shade200,
                        text: 'click to edit job type',
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

                      // is Approved
                      Text('Approval Status (Optional)',
                          style: TextThemes.text),
                      const SizedBox(height: 2),
                      CheckboxListTile(
                        value: isApproved,
                        tileColor: Colors.grey.shade200,
                        selected: isApproved!,
                        selectedTileColor: AppColor.mainGreen.withOpacity(0.3),
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
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),

                  // Cost and Payment Information
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    iconColor: AppColor.mainGreen,
                    title: Text(
                      'Cost and Payment Information',
                      style: TextThemes.text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      // Cost
                      Text('Cost of repair (optional)', style: TextThemes.text),
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

                      // Payment made
                      Text('Add Payment (optional)', style: TextThemes.text),
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

                      const SizedBox(height: 5),
                    ],
                  ),

                  // Repair and Pick-up Information
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    iconColor: AppColor.mainGreen,
                    title: Text(
                      'Repair Information',
                      style: TextThemes.text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      // Repair status
                      Text('Repair status (Optional)', style: TextThemes.text),
                      const SizedBox(height: 2),
                      CheckboxListTile(
                        value: isRepaired,
                        tileColor: Colors.grey.shade200,
                        selected: isRepaired!,
                        selectedTileColor: AppColor.mainGreen.withOpacity(0.3),
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
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Repair Details
                      Text('Repair Details (optional)', style: TextThemes.text),
                      const SizedBox(height: 2),
                      MyTextField(
                        controller: repairDetailsController,
                        hintText: 'Edit Repair Details',
                        obscureText: false,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 10),

                      // Pick-Up date
                      Text('Promised Delivery Date (Optional)',
                          style: TextThemes.text),
                      const SizedBox(height: 2),
                      MyTextField(
                        prefixIcon: const Icon(Icons.calendar_today),
                        controller: pickUpDateDateController,
                        hintText: 'Edit Pick-Up date',
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

                      // is Departed
                      Text('Pick up status (Optional)', style: TextThemes.text),
                      const SizedBox(height: 2),
                      CheckboxListTile(
                        value: isDeparted,
                        tileColor: Colors.grey.shade200,
                        selected: isDeparted!,
                        selectedTileColor: AppColor.mainGreen.withOpacity(0.3),
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
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Update record
                  if (user.userType == 'admin' || user.userType == 'supervisor')
                    CustomButton(
                      width: double.infinity,
                      height: 45,
                      color: AppColor.mainGreen,
                      text: 'Update details',
                      onPressed: validateForm,
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

  void validateForm() {
    // Perform validation for the Car Information section
    setState(() {
      hasCarInfoError = modelNameController.text.isEmpty ||
          plateNumberController.text.isEmpty;
      hasPersonnelInfoError = serviceAdviserController.text.isEmpty;
      hasJobInfoError =
          jobDetailsController.text.isEmpty || selectedJobTypes.isEmpty;
    });

    // Validate the entire form
    if (_formKey.currentState!.validate() & selectedJobTypes.isNotEmpty) {
      // form is valid
      newCar.modelName = modelNameController.text;
      newCar.plateNumber = plateNumberController.text;
      newCar.vin = vinController.text;
      newCar.manufactureYear = manufactureYearController.text;
      newCar.fuelLevel = fuelLevelController.text;
      newCar.meterReading = meterReadingController.text;
      newCar.color = colorController.text;
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
      newCar.approvalDate =
          (isApproved! & (newCar.approvalDate.toUtc() == Functions.emptyDate))
              ? DateTime.now()
              : newCar.approvalDate;
      newCar.paymentStatus =
          (amountPaid >= Functions.parseDouble(costController.text))
              ? "Complete"
              : newCar.paymentStatus;
      newCar.paymentMade = amountPaid;
      newCar.paymentHistory = paymentHistory;
      newCar.repairStatus = (isRepaired!) ? "Fixed" : "Pending";
      newCar.repairDetails = (repairDetailsController.text.isNotEmpty)
          ? repairDetailsController.text
          : newCar.repairDetails;
      newCar.departureDate =
          (isDeparted! & (newCar.departureDate.toUtc() == Functions.emptyDate))
              ? DateTime.now()
              : newCar.departureDate;
      newCar.pickUpDate =
          (selectedDate != null) ? selectedDate! : newCar.pickUpDate;

      context.read<SaveDataBloc>().add(UpdateCarData(newCar.id, newCar));
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors before updating.')),
      );
    }
  }

  DropdownMenuItem technicianList(String technician) => DropdownMenuItem(
        value: technician,
        child: Text(
          technician,
        ),
      );
}
