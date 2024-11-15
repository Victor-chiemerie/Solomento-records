import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../Components/custom_button.dart';
import '../../Components/drop_down_menu.dart';
import '../../Components/functions.dart';
import '../../Components/screen_size.dart';
import '../../Components/text_field.dart';
import '../../Logic/blocs/save_data_bloc/save_data_bloc.dart';
import '../../Logic/cubits/get_data_cubit/get_data_cubit.dart';
import '../Theme/color_theme.dart';
import '../Theme/text_theme.dart';

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
  late MyUser user;
  String? selectedStatus; // Variable to store the technician

  final status = [
    'Settled',
    'unSettled',
  ];

  @override
  void initState() {
    newCustomer = widget.customer;
    nameController.text = newCustomer.name;
    mobileController.text = newCustomer.mobile;
    selectedStatus = newCustomer.status;

    user = BlocProvider.of<MyUserBloc>(context).state.user!;
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Customer details',
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
                  Text('Edit Customer Name', style: TextThemes.text),
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
                  Text('Edit Customer Mobile', style: TextThemes.text),
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

                  const SizedBox(height: 10),

                  // Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Edit Customer Status", style: TextThemes.text),
                      const SizedBox(height: 2),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MyDropDownMenu(
                          items: status, // List of statuses
                          value: selectedStatus, // Current selected value
                          hint: 'Select status',
                          onChanged: (value) {
                            setState(() => selectedStatus =
                                value); // Update selected value
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Update button
                  if (user.userType == 'admin')
                    CustomButton(
                      width: double.infinity,
                      height: 45,
                      color: AppColor.mainGreen,
                      text: 'Update customer',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          newCustomer.name = nameController.text;
                          newCustomer.mobile = mobileController.text;
                          newCustomer.status = selectedStatus!;

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
