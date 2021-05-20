import 'package:get/get.dart';

import 'controller.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginPageController>(LoginPageController());
  }
}