import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/deleteData.dart';
import 'package:solomento_records/Logic/cubits/delete_data_cubit/delete_data_cubit.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/cars/edit_car_page.dart';

import '../../Components/functions.dart';
import '../Theme/text_theme.dart';
import '../customers/edit_customer_page.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteDataCubit, DeleteDataState>(
      listener: (context, state) {
        if (state.status == DeleteDataStatus.success) {
          Functions.hideLoadingPage(context);

          // Emit GetAllCars to refresh the data in the home page
          BlocProvider.of<GetDataCubit>(context).getData();

          // pop the screen
          Navigator.pop(context);
        } else if (state.status == DeleteDataStatus.loading) {
          Functions.showLoadingPage(context);
        } else if (state.status == DeleteDataStatus.failure) {
          Functions.hideLoadingPage(context);

          // pop the screen
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text('All Cars',
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
                  onRefresh: () async {
                    BlocProvider.of<GetDataCubit>(context).getData();
                  },
                  child: ListView.builder(
                    itemCount: state.cars.length,
                    itemBuilder: (context, index) {
                      // get the car object
                      final car = state.cars[index];
                      final String pickUpDate = (car.pickUpDate.toUtc() !=
                              DateTime.utc(1999, 7, 20, 20, 18, 04))
                          ? shortenDate(
                              DateFormat('dd-MM-yyyy').format(car.pickUpDate))
                          : 'Not set';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          child: ListTile(
                            onLongPress: () {
                              deleteData(
                                context,
                                car,
                                () => BlocProvider.of<DeleteDataCubit>(context)
                                    .deleteData(car),
                              );
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditCarPage(car: car)));
                            },
                            leading: const Icon(CupertinoIcons.car_detailed),
                            contentPadding: const EdgeInsets.all(5),
                            title: Text(car.modelName,
                                style: TextThemes.headline1
                                    .copyWith(fontSize: 16)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Plate Number: ',
                                    style:
                                        TextThemes.text.copyWith(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: car.plateNumber,
                                        style: TextThemes.text.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.mainGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Repair Status: ',
                                        style: TextThemes.text
                                            .copyWith(fontSize: 12)),
                                    if (car.repairStatus == 'Pending')
                                      Text(car.repairStatus,
                                          style: TextThemes.text.copyWith(
                                              fontSize: 12,
                                              color: Colors.redAccent)),
                                    if (car.repairStatus == 'Fixed')
                                      Text(car.repairStatus,
                                          style: TextThemes.text.copyWith(
                                              fontSize: 12,
                                              color: AppColor.mainGreen)),
                                  ],
                                ),
                                Text('Pick-Up Date: $pickUpDate',
                                    style:
                                        TextThemes.text.copyWith(fontSize: 12)),
                              ],
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                // view the vehicle owner
                                try {
                                  Customer customer =
                                      state.findCustomerById(car.customerId);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditCustomerPage(
                                                  customer: customer)));
                                } catch (error) {
                                  debugPrint(error.toString());
                                }
                              },
                              child: Text(
                                'View\nOwner',
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
                child: Text('No cars available.', style: TextThemes.headline1),
              );
            }
          },
        ),
      ),
    );
  }

  String shortenDate(String date, {int maxLength = 10}) {
    if (date.length <= maxLength) {
      return date; // If the date is shorter than maxLength, return as is
    }

    return '${date.substring(0, maxLength)}...'; // Truncate and add ellipsis
  }
}
