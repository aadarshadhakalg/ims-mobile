import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/repositories/auth_repository.dart';

enum DashboardStates {
  InitialState,
  LogingOutState,
}

class DashboardPageController extends GetxController {
  final AuthRepository _authRepository = AuthRepository.instance();
  Rx<DashboardStates> currentState =
      Rx<DashboardStates>(DashboardStates.InitialState);

 Future<void> logoutButtonPressed() async {
    currentState.value = DashboardStates.LogingOutState;
    try {
      await _authRepository.logout();
      Get.offAll('/login');
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'e');
    } finally {
      currentState.value = DashboardStates.InitialState;
    }
  }
}
