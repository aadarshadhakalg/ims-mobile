import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/DashBoard/controller.dart';
import 'package:inventory_management_system/app/modules/LoginPage/controller.dart';
class DashboardPageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<DashboardPageController>(() => DashboardPageController());
  }

}