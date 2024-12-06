import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/Theme/text_theme.dart';
import 'package:solomento_records/UI/cars/edit_car_page.dart';
import 'edit_customer_page.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('All Customers',
            style: TextThemes.headline1.copyWith(fontSize: 20)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.people_alt,
              color: AppColor.mainGreen,
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetDataCubit, GetDataState>(
        builder: (context, state) {
          if (state.status == GetDataStatus.failure) {
            return Center(
              child: Text('An error occured!!!', style: TextThemes.headline1),
            );
          } else if (state.status == GetDataStatus.loading) {
            return Center(
              child: Text('Loading...', style: TextThemes.headline1),
            );
          } else if (state.status == GetDataStatus.success &&
              state.cars.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: RefreshIndicator(
                color: AppColor.mainGreen,
                onRefresh: () async {
                  context.read<GetDataCubit>().getData();
                },
                child: ListView.builder(
                  itemCount: state.cars.length,
                  itemBuilder: (context, index) {
                    // get the customer object
                    final car = state.cars[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditCustomerPage(car: car)));
                          },
                          leading: const Icon(Icons.person_2),
                          title: Text(car.customerName,
                              style:
                                  TextThemes.headline1.copyWith(fontSize: 16)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mobile: ${car.customerMobile}',
                                  style:
                                      TextThemes.text.copyWith(fontSize: 12)),
                              Row(
                                children: [
                                  Text('Service Status: ',
                                      style: TextThemes.text
                                          .copyWith(fontSize: 12)),
                                  if (car.customerStatus == 'unSettled')
                                    Text(car.customerStatus,
                                        style: TextThemes.text.copyWith(
                                            fontSize: 12,
                                            color: Colors.redAccent)),
                                  if (car.customerStatus == 'Settled')
                                    Text(car.customerStatus,
                                        style: TextThemes.text.copyWith(
                                            fontSize: 12,
                                            color: AppColor.mainGreen)),
                                ],
                              ),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              // view the customer vehicle
                              try {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditCarPage(car: car)));
                              } catch (error) {
                                debugPrint(error.toString());
                              }
                            },
                            child: Text(
                              'View\nVehicle',
                              textAlign: TextAlign.center,
                              style: TextThemes.text.copyWith(
                                color: AppColor.mainGreen,
                                fontSize: 12,
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
            return Center(
              child:
                  Text('No customers available.', style: TextThemes.headline1),
            );
          }
        },
      ),
    );
  }
}
