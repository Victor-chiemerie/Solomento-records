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
  final engineModelController = TextEditingController();
  final meterReadingController = TextEditingController();
  final manufactureYearController = TextEditingController();
  final vinController = TextEditingController();
  final fuelLevelController = TextEditingController();
  final colorController = TextEditingController();
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
  bool hasCarInfoError = false;
  bool hasPersonnelInfoError = false;
  bool hasJobInfoError = false;

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

                      // Engine Model
                      Text('Engine Model (Optional)', style: TextThemes.text),
                      MyTextField(
                        controller: engineModelController,
                        hintText: 'Enter Engine Model',
                        obscureText: false,
                        keyboardType: TextInputType.text,
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
                        text: 'click to select job type',
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
                      Text('Amount Paid (optional)', style: TextThemes.text),
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
                        hintText: 'Enter Repair Details',
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

                  // Save record
                  CustomButton(
                    width: double.infinity,
                    height: 45,
                    color: AppColor.mainGreen,
                    text: 'Save',
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
      // Form is valid
      car.modelName = modelNameController.text;
      car.plateNumber = plateNumberController.text;
      car.engineModel = engineModelController.text;
      car.meterReading = meterReadingController.text;
      car.manufactureYear = manufactureYearController.text;
      car.vin = vinController.text;
      car.fuelLevel = fuelLevelController.text;
      car.color = colorController.text;
      car.serviceAdviser = serviceAdviserController.text;
      car.technician =
          (selectedTechnician != null) ? selectedTechnician! : car.technician;
      car.arrivalDate = DateTime.now();
      car.jobDetails = jobDetailsController.text;
      car.jobType = selectedJobTypes;
      car.cost = (costController.text.isNotEmpty)
          ? Functions.parseDouble(costController.text)
          : car.cost;
      car.isApproved = isApproved!;
      car.pickUpDate = (selectedDate != null) ? selectedDate! : car.pickUpDate;
      car.approvalDate = (isApproved!) ? DateTime.now() : car.approvalDate;
      car.paymentStatus = (Functions.parseDouble(paidAmountController.text) >=
              Functions.parseDouble(costController.text))
          ? "Complete"
          : car.paymentStatus;
      car.paymentMade = (paidAmountController.text.isNotEmpty)
          ? Functions.parseDouble(paidAmountController.text)
          : car.paymentMade;
      car.paymentHistory = (paidAmountController.text.isNotEmpty)
          ? [
              {
                'date': DateTime.now(),
                'amount': Functions.parseDouble(paidAmountController.text),
              }
            ]
          : car.paymentHistory;
      car.repairStatus = (isRepaired!) ? "Fixed" : "Pending";
      car.repairDetails = (repairDetailsController.text.isNotEmpty)
          ? repairDetailsController.text
          : car.repairDetails;
      car.departureDate = (isDeparted!) ? DateTime.now() : car.departureDate;
      car.customerName = widget.customerName;
      car.customerMobile = widget.customerMobile;

      context.read<SaveDataBloc>().add(SaveCar(car));
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors before submitting.')),
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
