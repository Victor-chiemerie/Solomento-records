import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/cubit/get_data_cubit.dart';
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            } else {
              return const Text(
                'Hi there',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => logOut(context),
            child: const Text(
              'Log out',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<GetDataCubit>(context).getData();
        },
        color: const Color.fromRGBO(66, 178, 132, 1.0),
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
                  child: const Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.grey,
                              ),
                              Text('  Customers'),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward,
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
                        builder: (context) => const CarsPage(),
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
                                    return Text('   Cars ($carCount)');
                                  } else {
                                    return const Text('  Cars (0)');
                                  }
                                },
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCustomerPage(),
            ),
          );
        },
        backgroundColor: const Color.fromRGBO(66, 178, 132, 1.0),
        shape: const CircleBorder(),
        tooltip: 'Add a new customer',
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
