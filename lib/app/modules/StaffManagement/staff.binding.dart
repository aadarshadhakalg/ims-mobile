import 'package:get/instance_manager.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/staff.controller.dart';

class SfaffBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<StaffController>(StaffController());
  }
}