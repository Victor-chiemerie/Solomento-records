import 'package:flutter/material.dart';
import 'package:solomento_records/Components/text_field.dart';

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
                ),

                const SizedBox(height: 10),

                // mobile
                const Text('Customer Mobile'),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'Enter Customer Mobile',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
