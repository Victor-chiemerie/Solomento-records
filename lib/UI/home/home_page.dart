import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Components/screen_size.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:solomento_records/UI/customers/customers_page.dart';

import '../cars/cars_page.dart';
import 'upload_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: SingleChildScrollView(
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
                              Icons.car_repair_outlined,
                              color: Colors.grey,
                            ),
                            Text('  Cars (0)'),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadPage(),
            ),
          );
        },
        backgroundColor: Colors.greenAccent,
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
