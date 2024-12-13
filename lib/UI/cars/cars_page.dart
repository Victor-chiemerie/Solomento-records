// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:record_repository/record_repository.dart';
import 'package:solomento_records/Components/my_drawer.dart';
import 'package:solomento_records/Logic/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:solomento_records/Logic/cubits/delete_data_cubit/delete_data_cubit.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';
import 'package:solomento_records/UI/cars/edit_car_page.dart';
import 'package:user_repository/user_repository.dart';
import '../../Components/functions.dart';
import '../Theme/text_theme.dart';
import '../customers/edit_customer_page.dart';

class CarsPage extends StatefulWidget {
  CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  Widget build(BuildContext context) {
    MyUser user = BlocProvider.of<MyUserBloc>(context).state.user!;
    final screenWidth = MediaQuery.of(context).size.width;
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
          leading: screenWidth < 800
              ? null // Show default drawer icon on mobile
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // pop till home screen
                  Navigator.popUntil(context, (route) {
                    return route.isFirst;
                  });
                },
                child: Text(
                  'All Cars',
                  style: TextThemes.headline1.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.directions_car,
                color: AppColor.mainGreen,
              ),
            ],
          ),
          actions: [
            BlocBuilder<GetDataCubit, GetDataState>(
              builder: (context, state) {
                final List<Car> cars = state.filteredCars ?? state.cars;
                return Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () => showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(cars: cars),
                    ),
                    icon: const Icon(
                      Icons.search,
                      color: AppColor.mainGreen,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        drawer: screenWidth < 800 ? MyDrawer() : null, // No drawer on web
        body: (screenWidth < 800)
            ?
            // mobile view
            BlocBuilder<GetDataCubit, GetDataState>(
                builder: (context, state) {
                  final carsToShow = state.filteredCars ?? state.cars;
                  if (state.status == GetDataStatus.failure) {
                    return Center(
                      child: Text('An error occured!!! \nRefresh your browser',
                          textAlign: TextAlign.center,
                          style: TextThemes.headline1),
                    );
                  } else if (state.status == GetDataStatus.loading) {
                    return Center(
                      child: Text('Loading...', style: TextThemes.headline1),
                    );
                  } else if (state.status == GetDataStatus.success &&
                      carsToShow.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditCarPage(car: car)));
                                  },
                                  leading: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[200],
                                    ),
                                    child:
                                        const Icon(CupertinoIcons.car_detailed),
                                  ),
                                  contentPadding: const EdgeInsets.all(5),
                                  title: Text(car.customerName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextThemes.headline1
                                          .copyWith(fontSize: 16)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Model: ${car.modelName}',
                                          style: TextThemes.text
                                              .copyWith(fontSize: 12)),
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
                                      Text(
                                        'Details: ${car.repairDetails}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextThemes.text
                                            .copyWith(fontSize: 12),
                                      ),
                                      Text('Promised DD: $pickUpDate',
                                          style: TextThemes.text
                                              .copyWith(fontSize: 12)),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              car.modelName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextThemes.headline1
                                                  .copyWith(fontSize: 15),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // view owner
                                                ListTile(
                                                  leading: Icon(Icons.person),
                                                  title: Text(
                                                    'View owner details',
                                                    style: TextThemes.text,
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    // view the vehicle owner
                                                    try {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditCustomerPage(
                                                                      car:
                                                                          car)));
                                                    } catch (error) {
                                                      debugPrint(
                                                          error.toString());
                                                    }
                                                  },
                                                ),
                                                // delete car
                                                if (user.userType == 'admin')
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.delete,
                                                      color: Colors.redAccent,
                                                    ),
                                                    title: Text(
                                                      'Delete Car',
                                                      style: TextThemes.text,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Functions.deleteData(
                                                        context,
                                                        car,
                                                        () => BlocProvider.of<
                                                                    DeleteDataCubit>(
                                                                context)
                                                            .deleteData(car),
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.more_vert),
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
              )
            :
            // web view
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // filter section
                  MyDrawer(),
                  // cars section
                  Expanded(
                    child: BlocBuilder<GetDataCubit, GetDataState>(
                      builder: (context, state) {
                        final carsToShow = state.filteredCars ?? state.cars;
                        if (state.status == GetDataStatus.failure) {
                          return Center(
                            child: Text(
                                'An error occured!!! \nRefresh your browser',
                                style: TextThemes.headline1),
                          );
                        } else if (state.status == GetDataStatus.loading) {
                          return Center(
                            child:
                                Text('Loading...', style: TextThemes.headline1),
                          );
                        } else if (state.status == GetDataStatus.success &&
                            carsToShow.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: RefreshIndicator(
                              color: AppColor.mainGreen,
                              onRefresh: () async {
                                BlocProvider.of<GetDataCubit>(context)
                                    .getData();
                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Wrap(
                                    spacing: 16.0,
                                    runSpacing: 16.0,
                                    children: carsToShow.map((car) {
                                      final String pickUpDate =
                                          (car.pickUpDate.toUtc() !=
                                                  Functions.emptyDate)
                                              ? Functions.shortenDate(
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(car.pickUpDate))
                                              : 'Not set';
                                      return Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          // Car details
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditCarPage(
                                                              car: car)),
                                                );
                                              },
                                              child: Container(
                                                width: 250,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 45, 10, 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4.0,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            car.customerName,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextThemes
                                                                .headline1
                                                                .copyWith(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                              'Model: ${car.modelName}',
                                                              style: TextThemes
                                                                  .text
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                          RichText(
                                                            text: TextSpan(
                                                              text:
                                                                  'Plate Number: ',
                                                              style: TextThemes
                                                                  .text
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                              children: [
                                                                TextSpan(
                                                                  text: car
                                                                      .plateNumber,
                                                                  style: TextThemes
                                                                      .text
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColor
                                                                        .mainGreen,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Repair Status: ',
                                                                  style: TextThemes
                                                                      .text
                                                                      .copyWith(
                                                                          fontSize:
                                                                              12)),
                                                              if (car.repairStatus ==
                                                                  'Pending')
                                                                Text(car.repairStatus,
                                                                    style: TextThemes.text.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .redAccent)),
                                                              if (car.repairStatus ==
                                                                  'Fixed')
                                                                Text(car.repairStatus,
                                                                    style: TextThemes.text.copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: AppColor
                                                                            .mainGreen)),
                                                            ],
                                                          ),
                                                          Text(
                                                            'Details: ${car.repairDetails}',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextThemes
                                                                .text
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          Text(
                                                              'Promised DD: $pickUpDate',
                                                              style: TextThemes
                                                                  .text
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                car.modelName,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextThemes
                                                                    .headline1
                                                                    .copyWith(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  // view owner
                                                                  ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .person),
                                                                    title: Text(
                                                                      'View owner details',
                                                                      style: TextThemes
                                                                          .text,
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      // view the vehicle owner
                                                                      try {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => EditCustomerPage(car: car)));
                                                                      } catch (error) {
                                                                        debugPrint(
                                                                            error.toString());
                                                                      }
                                                                    },
                                                                  ),
                                                                  // delete car
                                                                  if (user.userType ==
                                                                      'admin')
                                                                    ListTile(
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .redAccent,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        'Delete Car',
                                                                        style: TextThemes
                                                                            .text,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Functions
                                                                            .deleteData(
                                                                          context,
                                                                          car,
                                                                          () =>
                                                                              BlocProvider.of<DeleteDataCubit>(context).deleteData(car),
                                                                        );
                                                                      },
                                                                    ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon:
                                                          Icon(Icons.more_vert),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // car Icon / car photo
                                          Container(
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey[200],
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.car_detailed,
                                              size: 40,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
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
        // mobile view
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
        // web view
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
