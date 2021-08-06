import 'package:get/get.dart';
import 'add_staff_controller.dart';

class AddStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddStaffController>(AddStaffController());
  }
}
