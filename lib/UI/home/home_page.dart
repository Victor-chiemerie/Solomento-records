import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/Theme/text_theme.dart';
import 'package:solomento_records/UI/customers/add_customer_page.dart';
import 'package:solomento_records/UI/customers/customers_page.dart';
import '../cars/cars_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logOut(BuildContext context) {
    context.read<SignInBloc>().add(const SignOutRequired());
  }

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              return Text(
                'Hi, ${state.user!.name}',
                style: TextThemes.headline1,
              );
            } else {
              return Text(
                'Hi there',
                style: TextThemes.headline1,
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => logOut(context),
            child: Text(
              'Log out',
              style: TextThemes.text
                  .copyWith(color: Colors.redAccent, fontSize: 15),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<GetDataCubit>(context).getData();
        },
        color: AppColor.mainGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Customers
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomersPage(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.people,
                                color: Colors.grey,
                              ),
                              Text(
                                '  Customers',
                                style: TextThemes.text,
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Cars
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarsPage(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.car_repair_outlined,
                                color: Colors.grey,
                              ),
                              BlocBuilder<GetDataCubit, GetDataState>(
                                builder: (context, state) {
                                  if (state.status == GetDataStatus.success) {
                                    final carCount = state.cars.length;
                                    return Text('  All Cars ($carCount)',
                                        style: TextThemes.text);
                                  } else {
                                    return Text('  All Cars (0)',
                                        style: TextThemes.text);
                                  }
                                },
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          if (state.status == MyUserStatus.success) {
            if (state.user!.userType == 'admin') {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCustomerPage(),
                    ),
                  );
                },
                backgroundColor: AppColor.mainGreen,
                shape: const CircleBorder(),
                tooltip: 'Add a new customer',
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
