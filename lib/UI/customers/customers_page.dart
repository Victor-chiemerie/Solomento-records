import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Logic/blocs/get_data_bloc/get_data_bloc.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  fetchCustomers() {
    context.read<GetDataBloc>().add(GetAllCustomers());
  }

  @override
  void initState() {
    fetchCustomers();
    super.initState();
  }

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
      body: const Center(
        child: Text('Customer Page'),
      ),
    );
  }
}
