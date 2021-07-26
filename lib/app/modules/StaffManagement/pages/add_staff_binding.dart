import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/pages/add_staff_controller.dart';

class AddStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddStaffController>(AddStaffController());
  }
}
