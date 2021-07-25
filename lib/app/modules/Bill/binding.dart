import 'package:get/get.dart';
import 'controller.dart';

class BillPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<BillPageController>(BillPageController());
  }
}