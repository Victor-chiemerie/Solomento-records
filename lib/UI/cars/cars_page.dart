import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/blocs/get_data_bloc/get_data_bloc.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cars'),
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
      body: BlocBuilder<GetDataBloc, GetDataState>(
        builder: (context, state) {
          if (state is GetDataFailure) {
            return const Center(
              child: Text('An error occured!!!'),
            );
          } else if (state is GetDataLoading) {
            return const Center(
              child: Text('Loading...'),
            );
          } else if (state is GetDataSuccess && state.cars != null) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<GetDataBloc>().add(GetAllCars());
                },
                child: ListView.builder(
                  itemCount: state.cars!.length,
                  itemBuilder: (context, index) {
                    // get the car object
                    final car = state.cars![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(CupertinoIcons.car_detailed),
                          title: Text(car.modelName),
                          subtitle: Column(
                            children: [
                              const Text('Color: '),
                              RichText(
                                text: TextSpan(
                                  text: 'Plate Number',
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
    );
  }
}
