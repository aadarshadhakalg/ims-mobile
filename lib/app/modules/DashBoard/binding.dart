import 'package:get/instance_manager.dart';
import 'ui/controllers/MenuController.dart';

import 'controller.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<DashboardPageController>(DashboardPageController());
    Get.put<MenuController>(MenuController());
  }

}