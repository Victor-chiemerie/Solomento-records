import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import '../../Components/custom_button.dart';
import '../../Components/format_amount.dart';
import '../../Components/text_field.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final modelNameController = TextEditingController();
  final plateNumberController = TextEditingController();
  final serviceAdviserController = TextEditingController();
  final jobDetailsController = TextEditingController();
  final costController = TextEditingController();
  final paidAmountController =
      TextEditingController(text: '₦${formatAmount(0)}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add customer vehicle'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
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
              ),

              const SizedBox(height: 10),

              // Plate number
              const Text('Plate Number'),
              const SizedBox(height: 10),
              MyTextField(
                controller: modelNameController,
                hintText: 'Enter Plate Number',
                obscureText: false,
                keyboardType: TextInputType.text,
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

              const SizedBox(height: 10),

              // Cost
              const Text('Cost of repair'),
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
              const Text('Amount Paid'),
              const SizedBox(height: 10),
              MyTextField(
                controller: paidAmountController,
                hintText: 'Enter Amount',
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
              const Text('Repair Details'),
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
                onPressed: () {},
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // join array variables
  String joinArrayContents(List<dynamic> array) {
    return array.join(', ');
  }
}
