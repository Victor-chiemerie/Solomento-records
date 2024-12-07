// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/cubits/delete_data_cubit/delete_data_cubit.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/cars/edit_car_page.dart';
import 'package:user_repository/user_repository.dart';
import '../../Components/functions.dart';
import '../../Data/car_filter_model.dart';
import '../Theme/text_theme.dart';
import '../customers/edit_customer_page.dart';

class CarsPage extends StatefulWidget {
  CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  bool checkboxValue1 = true;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;

  void toggleCheckbox1() {
    setState(() {
      if (checkboxValue1 != true) {
        checkboxValue1 = true; // Select checkbox 1
        checkboxValue2 = false; // Deselect checkbox 2
        checkboxValue3 = false; // Deselect checkbox 3
      }
    });
  }

  void toggleCheckbox2() {
    setState(() {
      if (checkboxValue2 != true) {
        checkboxValue2 = true; // Select checkbox 2
        checkboxValue1 = false; // Deselect checkbox 1
        checkboxValue3 = false; // Deselect checkbox 3
      }
    });
  }

  void toggleCheckbox3() {
    setState(() {
      if (checkboxValue3 != true) {
        checkboxValue3 = true; // Select checkbox 3
        checkboxValue1 = false; // Deselect checkbox 1
        checkboxValue2 = false; // Deselect checkbox 2
      }
    });
  }

  String _selectedRepairOption = "";

  String _selectedTechnicianOption = "";

  @override
  Widget build(BuildContext context) {
    MyUser user = BlocProvider.of<MyUserBloc>(context).state.user!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          actions: [
            BlocBuilder<GetDataCubit, GetDataState>(
              builder: (context, state) {
                final List<Car> cars = state.filteredCars ?? state.cars;
                return IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(cars: cars),
                  ),
                  icon: const Icon(
                    Icons.search,
                    color: AppColor.mainGreen,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 10),
              child: Icon(
                Icons.directions_car,
                color: AppColor.mainGreen,
              ),
            ),
          ],
        ),
        body: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // filter section
            Container(
              height: screenHeight,
              width: screenWidth * 0.15,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<GetDataCubit, GetDataState>(
                    builder: (context, state) {
                      final filterCriteria = state.filterCriteria;
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          if (filterCriteria?.repairStatus != null)
                            TextButton.icon(
                              iconAlignment: IconAlignment.end,
                              onPressed: () {
                                toggleCheckbox1();
                                if (checkboxValue1 == true) {
                                  context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(repairStatus: null));
                                }
                              },
                              label: Text(
                                filterCriteria!.repairStatus!,
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.black,
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                          TextButton.icon(
                            iconAlignment: IconAlignment.end,
                            onPressed: () {},
                            label: Text(
                              "Approved",
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.black,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          TextButton.icon(
                            iconAlignment: IconAlignment.end,
                            onPressed: () {},
                            label: Text(
                              "Chika",
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.black,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Reset filters",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: Text('Repair Status'),
                    children: [
                      CheckboxListTile(
                        value: checkboxValue1,
                        onChanged: (value) {
                          toggleCheckbox1();
                          if (checkboxValue1 == true) {
                            context
                                .read<GetDataCubit>()
                                .filterCars(FilterCriteria(repairStatus: null));
                          }
                        },
                        title: Text('All'),
                      ),
                      CheckboxListTile(
                        value: checkboxValue2,
                        onChanged: (value) {
                          toggleCheckbox2();
                          if (checkboxValue2 == true) {
                            context.read<GetDataCubit>().filterCars(
                                FilterCriteria(repairStatus: 'Fixed'));
                          }
                        },
                        title: Text('Repaired'),
                      ),
                      CheckboxListTile(
                        value: checkboxValue3,
                        onChanged: (value) {
                          toggleCheckbox3();
                          if (checkboxValue3 == true) {
                            context.read<GetDataCubit>().filterCars(
                                FilterCriteria(repairStatus: 'Pending'));
                          }
                        },
                        title: Text('Pending'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Approved'),
                    children: [
                      CheckboxListTile(
                        value: true,
                        onChanged: (value) {
                          context
                              .read<GetDataCubit>()
                              .filterCars(FilterCriteria(approvalStatus: true));
                        },
                        title: Text('Yes'),
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {
                          context.read<GetDataCubit>().filterCars(
                              FilterCriteria(approvalStatus: false));
                        },
                        title: Text('No'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Technician'),
                    children: [
                      SizedBox(
                        height: screenHeight * 0.4,
                        child: ListView(
                          children: [
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                    FilterCriteria(technician: 'Chika'));
                              },
                              title: Text('Chika'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('OJ'),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text('Ebube'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Stanley'),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text('Uche'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Adewale'),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text('Solue'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Leo'),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text('Emma'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Family man'),
                            ),
                            CheckboxListTile(
                              value: true,
                              onChanged: (value) {},
                              title: Text('Blessing'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Peter'),
                            ),
                            CheckboxListTile(
                              value: false,
                              onChanged: (value) {},
                              title: Text('Outsider'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GetDataCubit, GetDataState>(
                builder: (context, state) {
                  final carsToShow = state.filteredCars ?? state.cars;
                  if (state.status == GetDataStatus.failure) {
                    return Center(
                      child: Text('An error occured!!! \nRefresh your browser',
                          style: TextThemes.headline1),
                    );
                  } else if (state.status == GetDataStatus.loading) {
                    return Center(
                      child: Text('Loading...', style: TextThemes.headline1),
                    );
                  } else if (state.status == GetDataStatus.success &&
                      carsToShow.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: RefreshIndicator(
                        color: AppColor.mainGreen,
                        onRefresh: () async {
                          BlocProvider.of<GetDataCubit>(context).getData();
                        },
                        child: ListView.builder(
                          itemCount: carsToShow.length,
                          itemBuilder: (context, index) {
                            // get the car object
                            final car = carsToShow[index];
                            final String pickUpDate = (car.pickUpDate.toUtc() !=
                                    Functions.emptyDate)
                                ? Functions.shortenDate(DateFormat('dd-MM-yyyy')
                                    .format(car.pickUpDate))
                                : 'Not set';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                child: ListTile(
                                  onLongPress: () {
                                    if (user.userType == 'admin') {
                                      Functions.deleteData(
                                        context,
                                        car,
                                        () => BlocProvider.of<DeleteDataCubit>(
                                                context)
                                            .deleteData(car),
                                      );
                                    }
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditCarPage(car: car)));
                                  },
                                  leading:
                                      const Icon(CupertinoIcons.car_detailed),
                                  contentPadding: const EdgeInsets.all(5),
                                  title: Text(car.modelName,
                                      style: TextThemes.headline1
                                          .copyWith(fontSize: 16)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Plate Number: ',
                                          style: TextThemes.text
                                              .copyWith(fontSize: 12),
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
                                          style: TextThemes.text
                                              .copyWith(fontSize: 12)),
                                    ],
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      // view the vehicle owner
                                      try {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditCustomerPage(
                                                        car: car)));
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
                      child: Text('No cars available.',
                          style: TextThemes.headline1),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.cars});
  final List<Car> cars;
  // Customize the search hint text
  @override
  String get searchFieldLabel =>
      'Search for cars by customer / car model name / plate number';

  // Style the search hint text
  @override
  TextStyle? get searchFieldStyle => TextStyle(
        color: Colors.grey.shade600,
        fontSize: 16,
        fontStyle: FontStyle.italic,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Car> matchQuery = [];
    for (var car in cars) {
      if (car.modelName.toLowerCase().contains(query.toLowerCase()) ||
          car.plateNumber.toLowerCase().contains(query.toLowerCase()) ||
          car.customerName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(car);
      }
    }

    if (matchQuery.isEmpty) {
      // Display a "No car found" message if no matches
      return Center(
        child: Text(
          'No car found',
          style: TextThemes.headline1,
        ),
      );
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        // get the car object
        final car = matchQuery[index];
        return ListTile(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: const Icon(CupertinoIcons.car_detailed, size: 100),
          ),
          title: Text(
            car.modelName,
            style: TextThemes.headline1.copyWith(fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                car.plateNumber,
                style: TextThemes.text.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.mainGreen,
                ),
              ),
              Text(
                car.customerName,
                style: TextThemes.text.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.mainGreen,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditCarPage(car: car)));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Car> matchQuery = [];
    for (var car in cars) {
      if (car.modelName.toLowerCase().contains(query.toLowerCase()) ||
          car.plateNumber.toLowerCase().contains(query.toLowerCase()) ||
          car.customerName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(car);
      }
    }

    if (matchQuery.isEmpty) {
      // Display a "No car found" message if no matches
      return Center(
        child: Text(
          'No car found',
          style: TextThemes.headline1,
        ),
      );
    }

    return (screenWidth < 800)
        ? ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              // get the car object
              final car = matchQuery[index];
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(CupertinoIcons.car_detailed),
                ),
                title: Text(
                  car.modelName,
                  style: TextThemes.headline1.copyWith(fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.plateNumber,
                      style: TextThemes.text.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mainGreen,
                      ),
                    ),
                    Text(
                      car.customerName,
                      style: TextThemes.text.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mainGreen,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCarPage(car: car)));
                },
              );
            },
          )
        : SingleChildScrollView(
            child: Wrap(
              spacing: 16.0, // Horizontal spacing between items
              runSpacing: 16.0, // Vertical spacing between lines
              children: matchQuery.map((car) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCarPage(car: car)),
                    );
                  },
                  child: Container(
                    width: 150, // Set a fixed width for items
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.car_detailed,
                            size: 40,
                          ),
                        ),
                        Text(
                          car.modelName,
                          style: TextThemes.headline1.copyWith(fontSize: 16),
                        ),
                        Text(
                          car.plateNumber,
                          style: TextThemes.text.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mainGreen,
                          ),
                        ),
                        Text(
                          car.customerName,
                          style: TextThemes.text.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mainGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }
}
