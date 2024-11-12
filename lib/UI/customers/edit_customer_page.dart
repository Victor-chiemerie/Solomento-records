import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';

import '../../Components/custom_button.dart';
import '../../Components/hide_loading.dart';
import '../../Components/show_loading.dart';
import '../../Components/text_field.dart';
import '../../Logic/blocs/save_data_bloc/save_data_bloc.dart';
import '../../Logic/cubits/get_data_cubit/get_data_cubit.dart';

class EditCustomerPage extends StatefulWidget {
  const EditCustomerPage({super.key, required this.customer});

  final Customer customer;

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  late Customer newCustomer;

  @override
  void initState() {
    newCustomer = widget.customer;
    nameController.text = newCustomer.name;
    mobileController.text = newCustomer.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveDataBloc, SaveDataState>(
      listener: (context, state) {
        if (state is SaveDataSuccess) {
          hideLoadingPage(context);

          // Emit GetAllCars to refresh the data in the home page
          context.read<GetDataCubit>().getData();

          // pop the screen
          Navigator.pop(context);
        } else if (state is SaveDataLoading) {
          showLoadingPage(context);
        } else if (state is SaveDataFailure) {
          hideLoadingPage(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customer details'),
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
                  // customer picture
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 35),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // name
                  const Text('Edit Customer Name'),
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
                  const Text('Edit Customer Mobile'),
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
                    text: 'Update customer',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        newCustomer.name = nameController.text;
                        newCustomer.mobile = mobileController.text;

                        context.read<SaveDataBloc>().add(
                            UpdateCustomerData(newCustomer, newCustomer.id));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
