import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  Rx<bool> sendStaffMail = Rx<bool>(null);
  Rx<bool> sendReceiptToEmail = Rx<bool>(null);
  GetStorage box = GetStorage();

  @override
  void onInit() async {
    await box.writeIfNull('sendStaffMail', true);
    await box.writeIfNull('sendReceiptToEmail', true);

    sendStaffMail.value = await box.read('sendStaffMail');
    sendReceiptToEmail.value = await box.read('sendReceiptToEmail');
    super.onInit();
  }

  void toggleStaffMail() {
    sendStaffMail.value = !sendStaffMail.value;
    box.write('sendStaffMail', sendStaffMail.value);
  }

  void toggleReceiptEmail() {
    sendReceiptToEmail.value = !sendReceiptToEmail.value;
    box.write('sendReceiptToEmail', sendReceiptToEmail.value);
  }
}
