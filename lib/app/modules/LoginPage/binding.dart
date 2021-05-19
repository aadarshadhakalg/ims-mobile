import 'package:inventory_management_system/app/modules/LoginPage/controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController());
  }
}