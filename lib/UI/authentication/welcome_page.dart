import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Components/screen_size.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDeviceSize(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: deviceHeight,
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // Expanded(
                  //   child: TabBarView(
                  //     controller: tabController,
                  //     children: [
                  //       Container(
                  //         child: const Center(
                  //           child: Icon(Icons.abc),
                  //         ),
                  //       ),
                  //       Container(
                  //         child: const Center(
                  //           child: Icon(Icons.access_alarms_rounded),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
