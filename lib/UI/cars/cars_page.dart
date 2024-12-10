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
import '../../Data/car_filter_model.dart';
import '../Theme/text_theme.dart';
import '../customers/edit_customer_page.dart';

class CarsPage extends StatefulWidget {
  CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  // repair
  bool allRepairStatus = true;
  bool repaired = false;
  bool notRepaired = false;
  // approve
  bool allApprovalStatus = true;
  bool approved = false;
  bool notApproved = false;
  // technician
  bool allTechnicians = true;
  bool chika = false;
  bool OJ = false;
  bool ebube = false;
  bool stanley = false;
  bool uche = false;
  bool adewale = false;
  bool solue = false;
  bool leo = false;
  bool emma = false;
  bool familyMan = false;
  bool outsider = false;

  void toggleAllRepairStatus() {
    setState(() {
      if (allRepairStatus != true) {
        allRepairStatus = true; // Select All
        repaired = false; // Deselect Repaired
        notRepaired = false; // Deselect not Repaired
      }
    });
  }

  void toggleRepaired() {
    setState(() {
      if (repaired != true) {
        repaired = true; // Select Repaired
        allRepairStatus = false; // Deselect All
        notRepaired = false; // Deselect not Repaired
      }
    });
  }

  void toggleNotRepaired() {
    setState(() {
      if (notRepaired != true) {
        notRepaired = true; // Select not Repaired
        allRepairStatus = false; // Deselect All
        repaired = false; // Deselect Repaired
      }
    });
  }

  void toggleAllApprovalStatus() {
    setState(() {
      if (allApprovalStatus != true) {
        allApprovalStatus = true; // Select All
        approved = false; // Deselect Approved
        notApproved = false; // Deselect not Approved
      }
    });
  }

  void toggleApproved() {
    setState(() {
      if (approved != true) {
        approved = true; // Select Approved
        allApprovalStatus = false; // Deselect All
        notApproved = false; // Deselect not Approved
      }
    });
  }

  void toggleNotApproved() {
    setState(() {
      if (notApproved != true) {
        notApproved = true; // Select not Approved
        allApprovalStatus = false; // Deselect All
        approved = false; // Deselect Approved
      }
    });
  }

  void toggleAllTechnicians() {
    setState(() {
      if (allTechnicians != true) {
        allTechnicians = true; // Select All
        // Deselect the rest
        chika = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleChika() {
    setState(() {
      if (chika != true) {
        chika = true; // Select chika
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleOJ() {
    setState(() {
      if (OJ != true) {
        OJ = true; // Select OJ
        // Deselect the rest
        allTechnicians = false;
        chika = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleEbube() {
    setState(() {
      if (ebube != true) {
        ebube = true; // Select ebube
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        chika = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleStanley() {
    setState(() {
      if (stanley != true) {
        stanley = true; // Select stanley
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        chika = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleUche() {
    setState(() {
      if (uche != true) {
        uche = true; // Select uche
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        chika = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleAdewale() {
    setState(() {
      if (adewale != true) {
        adewale = true; // Select All
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        chika = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleSolue() {
    setState(() {
      if (solue != true) {
        solue = true; // Select solue
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        chika = false;
        leo = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleLeo() {
    setState(() {
      if (leo != true) {
        leo = true; // Select leo
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        chika = false;
        emma = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleEmma() {
    setState(() {
      if (emma != true) {
        emma = true; // Select All
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        chika = false;
        familyMan = false;
        outsider = false;
      }
    });
  }

  void toggleFamilyMan() {
    setState(() {
      if (familyMan != true) {
        familyMan = true; // Select Family man
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        chika = false;
        outsider = false;
      }
    });
  }

  void toggleOutsider() {
    setState(() {
      if (outsider != true) {
        outsider = true; // Select All
        // Deselect the rest
        allTechnicians = false;
        OJ = false;
        ebube = false;
        stanley = false;
        uche = false;
        adewale = false;
        solue = false;
        leo = false;
        emma = false;
        familyMan = false;
        chika = false;
      }
    });
  }

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
          leading: screenWidth < 800
              ? null // Show default drawer icon on mobile
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
          title: Row(
            children: [
              Text(
                'All Cars',
                style: TextThemes.headline1.copyWith(fontSize: 20),
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
              )
            :
            // web view
            Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // filter section
                  BlocBuilder<GetDataCubit, GetDataState>(
                    builder: (context, state) {
                      final filterCriteria = state.filterCriteria;
                      return Container(
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
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                if (filterCriteria?.repairStatus != null)
                                  TextButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () {
                                      toggleAllRepairStatus();
                                      if (allRepairStatus == true) {
                                        context
                                            .read<GetDataCubit>()
                                            .filterCars(FilterCriteria(
                                              repairStatus: null,
                                              approvalStatus:
                                                  filterCriteria.approvalStatus,
                                              technician:
                                                  filterCriteria.technician,
                                            ));
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
                                if (filterCriteria?.approvalStatus != null)
                                  TextButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () {
                                      toggleAllApprovalStatus();
                                      if (allApprovalStatus == true) {
                                        context
                                            .read<GetDataCubit>()
                                            .filterCars(FilterCriteria(
                                              repairStatus:
                                                  filterCriteria.repairStatus,
                                              approvalStatus: null,
                                              technician:
                                                  filterCriteria.technician,
                                            ));
                                      }
                                    },
                                    label: Text(
                                      filterCriteria!.approvalStatus!
                                          ? 'Approved'
                                          : 'Not Approved',
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
                                if (filterCriteria?.technician != null)
                                  TextButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    onPressed: () {
                                      toggleAllTechnicians();
                                      if (allTechnicians == true) {
                                        context
                                            .read<GetDataCubit>()
                                            .filterCars(FilterCriteria(
                                              repairStatus:
                                                  filterCriteria.repairStatus,
                                              approvalStatus:
                                                  filterCriteria.approvalStatus,
                                              technician: null,
                                            ));
                                      }
                                    },
                                    label: Text(
                                      filterCriteria!.technician!,
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
                            ),
                            Text(
                              "Filters",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                toggleAllRepairStatus();
                                context
                                    .read<GetDataCubit>()
                                    .filterCars(FilterCriteria(
                                      repairStatus: null,
                                      approvalStatus: null,
                                      technician: null,
                                    ));
                              },
                              child: Text(
                                "Reset filters",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // repair
                            ExpansionTile(
                              title: Text('Repair Status'),
                              children: [
                                CheckboxListTile(
                                  value: allRepairStatus,
                                  onChanged: (value) {
                                    toggleAllRepairStatus();
                                    if (allRepairStatus == true) {
                                      context
                                          .read<GetDataCubit>()
                                          .filterCars(FilterCriteria(
                                            repairStatus: null,
                                            approvalStatus:
                                                filterCriteria?.approvalStatus,
                                            technician:
                                                filterCriteria?.technician,
                                          ));
                                    }
                                  },
                                  title: Text('All'),
                                ),
                                CheckboxListTile(
                                  value: repaired,
                                  onChanged: (value) {
                                    toggleRepaired();
                                    if (repaired == true) {
                                      context
                                          .read<GetDataCubit>()
                                          .filterCars(FilterCriteria(
                                            repairStatus: 'Fixed',
                                            approvalStatus:
                                                filterCriteria?.approvalStatus,
                                            technician:
                                                filterCriteria?.technician,
                                          ));
                                    }
                                  },
                                  title: Text('Repaired'),
                                ),
                                CheckboxListTile(
                                  value: notRepaired,
                                  onChanged: (value) {
                                    toggleNotRepaired();
                                    if (notRepaired == true) {
                                      context.read<GetDataCubit>().filterCars(
                                            FilterCriteria(
                                              repairStatus: 'Pending',
                                              approvalStatus: filterCriteria
                                                  ?.approvalStatus,
                                              technician:
                                                  filterCriteria?.technician,
                                            ),
                                          );
                                    }
                                  },
                                  title: Text('Pending'),
                                ),
                              ],
                            ),
                            // approve
                            ExpansionTile(
                              title: Text('Approved'),
                              children: [
                                CheckboxListTile(
                                  value: allApprovalStatus,
                                  onChanged: (value) {
                                    toggleAllApprovalStatus();
                                    if (allApprovalStatus == true) {
                                      context.read<GetDataCubit>().filterCars(
                                            FilterCriteria(
                                              repairStatus:
                                                  filterCriteria?.repairStatus,
                                              approvalStatus: null,
                                              technician:
                                                  filterCriteria?.technician,
                                            ),
                                          );
                                    }
                                  },
                                  title: Text('All'),
                                ),
                                CheckboxListTile(
                                  value: approved,
                                  onChanged: (value) {
                                    toggleApproved();
                                    if (approved == true) {
                                      context.read<GetDataCubit>().filterCars(
                                            FilterCriteria(
                                              repairStatus:
                                                  filterCriteria?.repairStatus,
                                              approvalStatus: true,
                                              technician:
                                                  filterCriteria?.technician,
                                            ),
                                          );
                                    }
                                  },
                                  title: Text('Yes'),
                                ),
                                CheckboxListTile(
                                  value: notApproved,
                                  onChanged: (value) {
                                    toggleNotApproved();
                                    if (notApproved == true) {
                                      context.read<GetDataCubit>().filterCars(
                                            FilterCriteria(
                                              repairStatus:
                                                  filterCriteria?.repairStatus,
                                              approvalStatus: false,
                                              technician:
                                                  filterCriteria?.technician,
                                            ),
                                          );
                                    }
                                  },
                                  title: Text('No'),
                                ),
                              ],
                            ),
                            // technician
                            ExpansionTile(
                              title: Text('Technician'),
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.4,
                                  child: ListView(
                                    children: [
                                      CheckboxListTile(
                                        value: allTechnicians,
                                        onChanged: (value) {
                                          toggleAllTechnicians();
                                          if (allTechnicians == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: null,
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('All'),
                                      ),
                                      CheckboxListTile(
                                        value: chika,
                                        onChanged: (value) {
                                          toggleChika();
                                          if (chika == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Chika',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Chika'),
                                      ),
                                      CheckboxListTile(
                                        value: OJ,
                                        onChanged: (value) {
                                          toggleOJ();
                                          if (OJ == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'OJ',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('OJ'),
                                      ),
                                      CheckboxListTile(
                                        value: ebube,
                                        onChanged: (value) {
                                          toggleEbube();
                                          if (ebube == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Ebube',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Ebube'),
                                      ),
                                      CheckboxListTile(
                                        value: stanley,
                                        onChanged: (value) {
                                          toggleStanley();
                                          if (stanley == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Stanley',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Stanley'),
                                      ),
                                      CheckboxListTile(
                                        value: uche,
                                        onChanged: (value) {
                                          toggleUche();
                                          if (uche == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Uche',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Uche'),
                                      ),
                                      CheckboxListTile(
                                        value: adewale,
                                        onChanged: (value) {
                                          toggleAdewale();
                                          if (adewale == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Adewale',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Adewale'),
                                      ),
                                      CheckboxListTile(
                                        value: solue,
                                        onChanged: (value) {
                                          toggleSolue();
                                          if (solue == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Solue',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Solue'),
                                      ),
                                      CheckboxListTile(
                                        value: leo,
                                        onChanged: (value) {
                                          toggleLeo();
                                          if (leo == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Leo',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Leo'),
                                      ),
                                      CheckboxListTile(
                                        value: emma,
                                        onChanged: (value) {
                                          toggleEmma();
                                          if (emma == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Emma',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Emma'),
                                      ),
                                      CheckboxListTile(
                                        value: familyMan,
                                        onChanged: (value) {
                                          toggleFamilyMan();
                                          if (familyMan == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Family man',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Family man'),
                                      ),
                                      CheckboxListTile(
                                        value: outsider,
                                        onChanged: (value) {
                                          toggleOutsider();
                                          if (outsider == true) {
                                            context
                                                .read<GetDataCubit>()
                                                .filterCars(
                                                  FilterCriteria(
                                                    repairStatus: filterCriteria
                                                        ?.repairStatus,
                                                    approvalStatus:
                                                        filterCriteria
                                                            ?.approvalStatus,
                                                    technician: 'Outsider',
                                                  ),
                                                );
                                          }
                                        },
                                        title: Text('Outsider'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                              child: ListView.builder(
                                itemCount: carsToShow.length,
                                itemBuilder: (context, index) {
                                  // get the car object
                                  final car = carsToShow[index];
                                  final String pickUpDate =
                                      (car.pickUpDate.toUtc() !=
                                              Functions.emptyDate)
                                          ? Functions.shortenDate(
                                              DateFormat('dd-MM-yyyy')
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
                                              () => BlocProvider.of<
                                                      DeleteDataCubit>(context)
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
                                        leading: const Icon(
                                            CupertinoIcons.car_detailed),
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
                                                    style: TextThemes.text
                                                        .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                        .copyWith(
                                                            fontSize: 12)),
                                                if (car.repairStatus ==
                                                    'Pending')
                                                  Text(car.repairStatus,
                                                      style: TextThemes.text
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .redAccent)),
                                                if (car.repairStatus == 'Fixed')
                                                  Text(car.repairStatus,
                                                      style: TextThemes.text
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: AppColor
                                                                  .mainGreen)),
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
