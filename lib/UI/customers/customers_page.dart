import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';

import 'edit_customer_page.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Customers'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.people_alt,
              color: Color.fromRGBO(66, 178, 132, 1.0),
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetDataCubit, GetDataState>(
        builder: (context, state) {
          if (state.status == GetDataStatus.failure) {
            return const Center(
              child: Text('An error occured!!!'),
            );
          } else if (state.status == GetDataStatus.loading) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (state.status == GetDataStatus.success &&
              state.customers.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<GetDataCubit>().getData();
                },
                child: ListView.builder(
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    // get the customer object
                    final customer = state.customers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditCustomerPage(customer: customer)));
                          },
                          leading: const Icon(Icons.person_2),
                          title: Text(customer.name),
                          subtitle: Column(
                            children: [
                              Text('Phone Number: ${customer.mobile}'),
                              Text('Service Status: ${customer.status}'),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              // view the customer vehicle
                            },
                            child: const Text(
                              'Vehicle',
                              style: TextStyle(
                                color: Color.fromRGBO(66, 178, 132, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('No customers available.'),
            );
          }
        },
      ),
    );
  }
}
