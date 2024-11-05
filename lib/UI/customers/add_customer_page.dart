import 'package:flutter/material.dart';
import 'package:solomento_records/Components/text_field.dart';
import 'package:solomento_records/UI/cars/add_car_page.dart';

import '../../Components/custom_button.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Customer'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                const Text('Customer Name'),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'Enter Customer Name',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 10),

                // mobile
                const Text('Customer Mobile'),
                const SizedBox(height: 10),
                MyTextField(
                  controller: mobileController,
                  hintText: 'Enter Customer Mobile',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20),

                // Add car page
                CustomButton(
                  width: double.infinity,
                  height: 45,
                  color: const Color.fromRGBO(66, 178, 132, 1.0),
                  text: 'Vehicle',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCarPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
