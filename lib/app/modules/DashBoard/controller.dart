import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/app/modules/Bill/qr_scan.dart';
import 'package:inventory_management_system/routes/pages.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../../core/values/storage_keys.dart';
import '../../data/repositories/auth_repository.dart';

enum DashboardStates {
  InitialState,
  LogingOutState,
}

class DashboardPageController extends GetxController {
  final AuthRepository _authRepository = AuthRepository.instance();
  Rx<DashboardStates> currentState =
      Rx<DashboardStates>(DashboardStates.InitialState);
  Rx<String> loggedInUser = Rx<String>('User');

  @override
  void onInit() {
    loggedInUser.value = GetStorage().read(StorageConstants.LOGGED_IN_USER);
    final QuickActions quickActions = const QuickActions();
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'new_bill') {
        Get.toNamed(Routes.NEWBILL);
      }
      if (shortcutType == 'qr_scan') {
        Get.toNamed(Routes.NEWBILL);
        Get.to(BillQRScan());
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'new_bill', localizedTitle: 'New Bill', icon: 'icon_main'),
      const ShortcutItem(
          type: 'qr_scan', localizedTitle: 'QR Scan', icon: 'icon_help')
    ]);
    super.onInit();
  }

  Future<void> logoutButtonPressed() async {
    currentState.value = DashboardStates.LogingOutState;
    try {
      await _authRepository.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'e');
    } finally {
      currentState.value = DashboardStates.InitialState;
    }
  }
}
