import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/deleteData.dart';
import 'package:solomento_records/Logic/cubits/delete_data_cubit/delete_data_cubit.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/cars/edit_car_page.dart';

import '../../Components/hide_loading.dart';
import '../../Components/show_loading.dart';
import '../Theme/text_theme.dart';
import '../customers/edit_customer_page.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteDataCubit, DeleteDataState>(
      listener: (context, state) {
        if (state.status == DeleteDataStatus.success) {
          hideLoadingPage(context);

          // Emit GetAllCars to refresh the data in the home page
          BlocProvider.of<GetDataCubit>(context).getData();

          // pop the screen
          Navigator.pop(context);
        } else if (state.status == DeleteDataStatus.loading) {
          showLoadingPage(context);
        } else if (state.status == DeleteDataStatus.failure) {
          hideLoadingPage(context);

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
                            title: Text(car.modelName),
                            subtitle: Column(
                              children: [
                                const Text('Color: '),
                                RichText(
                                  text: TextSpan(
                                    text: 'Plate Number: ',
                                    children: [
                                      TextSpan(
                                        text: car.plateNumber,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(66, 178, 132, 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text('Repair Status: ${car.repairStatus}'),
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
                                  print(error.toString());
                                }
                              },
                              child: const Text(
                                'Owner',
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
                child: Text('No cars available.'),
              );
            }
          },
        ),
      ),
    );
  }
}
