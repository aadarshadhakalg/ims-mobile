import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/controllers/MenuController.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/analysis_view.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/category_view.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/counter_view.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/product_view.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/setting_view.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/views/staff_view.dart';

import '../../constants.dart';
import 'components/header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            GetX(builder: (MenuController controller) {
              if (controller.selectedMenuItem.value == Menu.Category) {
                return CategoryView();
              } else if (controller.selectedMenuItem.value == Menu.Products) {
                return ProductView();
              } else if (controller.selectedMenuItem.value == Menu.Analysis) {
                return AnalysisView();
              } else if (controller.selectedMenuItem.value == Menu.Setting) {
                return SettingView();
              } else if (controller.selectedMenuItem.value == Menu.Staff) {
                return StaffView();
              } else {
                return CounterView();
              }
            }),
          ],
        ),
      ),
    );
  }
}
