import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/DashBoard/controller.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/controllers/MenuController.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/responsive.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/main/components/side_menu.dart';

import 'ui/screens/dashboard/dashboard_screen.dart';

class LayoutPage extends StatelessWidget {
  final DashboardPageController _dashboardPageController =
      DashboardPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Get.find<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Obx(() {
          if (_dashboardPageController.currentState.value ==
              DashboardStates.InitialState) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(),
                  ),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: DashboardScreen(),
                ),
              ],
            );
          } else if (_dashboardPageController.currentState.value ==
              DashboardStates.LogingOutState) {
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const Text('Logging Out'),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
