import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/text_field.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/UI/cars/add_car_page.dart';

import '../../Components/custom_button.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  late Customer customer;

  @override
  void initState() {
    customer = Customer.empty;
    customer.myUser = context.read<MyUserBloc>().state.user!;
    super.initState();
  }

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
            key: _formKey,
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
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }
                    return null;
                  },
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
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Add car page
                CustomButton(
                  width: double.infinity,
                  height: 45,
                  color: const Color.fromRGBO(66, 178, 132, 1.0),
                  text: 'Vehicle',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customer.name = nameController.text;
                      customer.mobile = mobileController.text;
                      log(customer.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SaveDataBloc(recordRepository: FirebaseRecordRepository()),
                            child: AddCarPage(customer: customer),
                          ),
                        ),
                      );
                    }
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
