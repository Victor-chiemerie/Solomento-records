import 'package:flutter/material.dart';
import 'package:solomento_records/Components/multiSelectDialog.dart';
import '../../Components/custom_button.dart';
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

  final jobTypes = [
    'Mechanical',
    'Electrical',
    'Body Work',
    'Air Conditioning',
    'Painting',
  ];
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
                keyboardType: TextInputType.text,
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
                text: 'select job types',
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
