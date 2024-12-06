import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/text_field.dart';
import 'package:solomento_records/Logic/blocs/save_data_bloc/save_data_bloc.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/cars/add_car_page.dart';

import '../../Components/custom_button.dart';
import '../Theme/text_theme.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Add a new Customer',
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
                // name
                Text('Customer Name', style: TextThemes.text),
                const SizedBox(height: 2),
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
                Text('Customer Mobile', style: TextThemes.text),
                const SizedBox(height: 2),
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
                  color: AppColor.mainGreen,
                  text: 'Vehicle',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SaveDataBloc(
                                recordRepository: FirebaseRecordRepository()),
                            child: AddCarPage(customerName: nameController.text, customerMobile: mobileController.text,),
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
