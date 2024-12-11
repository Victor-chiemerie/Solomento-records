import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solomento_records/Logic/cubits/get_data_cubit/get_data_cubit.dart';
import 'package:solomento_records/UI/Theme/color_theme.dart';

import '../Data/car_filter_model.dart';
import '../UI/Theme/text_theme.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // repair
  bool allRepairStatus = true;
  bool repaired = false;
  bool notRepaired = false;
  // approve
  bool allApprovalStatus = true;
  bool approved = false;
  bool notApproved = false;

  String? technician = null;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        height: screenHeight,
        padding: const EdgeInsets.all(15),
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
        child: BlocBuilder<GetDataCubit, GetDataState>(
          builder: (context, state) {
            final filterCriteria = state.filterCriteria;

            // Update local repair state based on filterCriteria
            allRepairStatus = filterCriteria?.repairStatus == null;
            repaired = filterCriteria?.repairStatus == 'Fixed';
            notRepaired = filterCriteria?.repairStatus == 'Pending';

            // Update local approval state based on filterCriteria
            allApprovalStatus = filterCriteria?.approvalStatus == null;
            approved = filterCriteria?.approvalStatus == true;
            notApproved = filterCriteria?.approvalStatus == false;

            // Update local technician state based on filterCriteria
            technician = filterCriteria?.technician;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // filters
                Text(
                  "Filters",
                  style: TextThemes.headline1.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (filterCriteria?.repairStatus != null)
                      TextButton.icon(
                        iconAlignment: IconAlignment.end,
                        onPressed: () {
                          context.read<GetDataCubit>().filterCars(
                                FilterCriteria(
                                  repairStatus: null,
                                  approvalStatus: filterCriteria.approvalStatus,
                                  technician: filterCriteria.technician,
                                ),
                              );
                        },
                        label: Text(
                          filterCriteria!.repairStatus!,
                          style: TextThemes.text,
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
                          context.read<GetDataCubit>().filterCars(
                                FilterCriteria(
                                  repairStatus: filterCriteria.repairStatus,
                                  approvalStatus: null,
                                  technician: filterCriteria.technician,
                                ),
                              );
                        },
                        label: Text(
                          filterCriteria!.approvalStatus!
                              ? 'Approved'
                              : 'Not Approved',
                          style: TextThemes.text,
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
                          context.read<GetDataCubit>().filterCars(
                                FilterCriteria(
                                  repairStatus: filterCriteria.repairStatus,
                                  approvalStatus: filterCriteria.approvalStatus,
                                  technician: null,
                                ),
                              );
                        },
                        label: Text(
                          filterCriteria!.technician!,
                          style: TextThemes.text,
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
                const SizedBox(height: 10),
                // reset filter
                TextButton(
                  onPressed: () {
                    context.read<GetDataCubit>().filterCars(
                          FilterCriteria(
                            repairStatus: 'Pending',
                            approvalStatus: null,
                            technician: null,
                          ),
                        );
                  },
                  child: Text(
                    "Reset filters",
                    style: TextThemes.text.copyWith(color: Colors.blue[400]),
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // repair
                        ExpansionTile(
                          title: Text(
                            'Repair Status',
                            style: TextThemes.text.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          iconColor: AppColor.mainGreen,
                          initiallyExpanded: true,
                          children: [
                            CheckboxListTile(
                              value: allRepairStatus,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus: null,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('All', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: repaired,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus: 'Fixed',
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('Repaired', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: notRepaired,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus: 'Pending',
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('Pending', style: TextThemes.text),
                            ),
                          ],
                        ),

                        // approve
                        ExpansionTile(
                          title: Text(
                            'Approved',
                            style: TextThemes.text.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          iconColor: AppColor.mainGreen,
                          children: [
                            CheckboxListTile(
                              value: allApprovalStatus,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus: null,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('All', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: approved,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus: true,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('Yes', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: notApproved,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus: false,
                                        technician: filterCriteria?.technician,
                                      ),
                                    );
                              },
                              title: Text('No', style: TextThemes.text),
                            ),
                          ],
                        ),

                        // technician
                        ExpansionTile(
                          title: Text(
                            'Technician',
                            style: TextThemes.text.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          iconColor: AppColor.mainGreen,
                          children: [
                            CheckboxListTile(
                              value: technician == null ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: null,
                                      ),
                                    );
                              },
                              title: Text('All', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Chika' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Chika',
                                      ),
                                    );
                              },
                              title: Text('Chika', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'OJ' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'OJ',
                                      ),
                                    );
                              },
                              title: Text('OJ', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Ebube' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Ebube',
                                      ),
                                    );
                              },
                              title: Text('Ebube', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Stanley' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Stanley',
                                      ),
                                    );
                              },
                              title: Text('Stanley', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Uche' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Uche',
                                      ),
                                    );
                              },
                              title: Text('Uche', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Adewale' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Adewale',
                                      ),
                                    );
                              },
                              title: Text('Adewale', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Solue' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Adewale',
                                      ),
                                    );
                              },
                              title: Text('Solue', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Leo' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Leo',
                                      ),
                                    );
                              },
                              title: Text('Leo', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Emma' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Emma',
                                      ),
                                    );
                              },
                              title: Text('Emma', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Family man' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Family man',
                                      ),
                                    );
                              },
                              title: Text('Family man', style: TextThemes.text),
                            ),
                            CheckboxListTile(
                              value: technician == 'Outsider' ? true : false,
                              activeColor: AppColor.mainGreen,
                              onChanged: (value) {
                                context.read<GetDataCubit>().filterCars(
                                      FilterCriteria(
                                        repairStatus:
                                            filterCriteria?.repairStatus,
                                        approvalStatus:
                                            filterCriteria?.approvalStatus,
                                        technician: 'Outsider',
                                      ),
                                    );
                              },
                              title: Text('Outsider', style: TextThemes.text),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
