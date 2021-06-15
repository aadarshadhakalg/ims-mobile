import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/app/data/repositories/auth_repository.dart';
import 'package:inventory_management_system/core/values/storage_keys.dart';

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
  void onInit(){
    loggedInUser.value = GetStorage().read(StorageConstants.LOGGED_IN_USER);
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
