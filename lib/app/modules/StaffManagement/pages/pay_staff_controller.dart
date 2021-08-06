import 'package:get/get.dart';
import '../../../data/models/payroll_model.dart';
import '../../../data/models/staff.model.dart';
import '../../../data/repositories/payroll_repository.dart';

class PayrollController extends GetxController {
  Rx<Staff> selectedStaff = Rx<Staff>(null);
  Rx<PayrollModel> allPayments = Rx<PayrollModel>(null);

  @override
  void onInit() async {
    await getPayments();
    super.onInit();
  }

  Future<void> getPayments() async {
    var res = await PayrollRepository().listPayments();

    res.fold((l) {
      allPayments.value = l;
    }, (r) {
      Get.rawSnackbar(title: 'Error', message: 'Error listing payments.');
    });
  }

  Future<bool> payStaff(Staff staff) async {
    var res = await PayrollRepository().payStaff(staff.id.toString());

    res.fold((l) async {
      await getPayments();
      return true;
    }, (r) {
      Get.rawSnackbar(
          title: 'Already Done',
          message: 'Payment Already Done For This Month');
      return false;
    });

    return false;
  }
}
