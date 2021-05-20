import 'package:get/instance_manager.dart';

import 'controller.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<DashboardPageController>(DashboardPageController());
  }

}