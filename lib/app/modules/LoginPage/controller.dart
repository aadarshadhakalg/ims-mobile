import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/loginModel.dart';


enum LoginAuthState {
  InitialState,
  LoadingState,
}

class LoginPageController extends GetxController {

  Rx<LoginAuthState> currentState =
      Rx<LoginAuthState>(LoginAuthState.InitialState);

  var username = ''.obs;
  var password = ''.obs;

  void onUsernameChanged(String val) {
    username.value = val;
  }

  void onPasswordChanged(String val) {
    password.value = val;
  }

  Future<void> onSubmitPress() async {
    currentState.value = LoginAuthState.LoadingState;
    var loginModel = LoginModel(
        username: this.username.value, password: this.password.value);
    try {
      await AuthRepository.instance().login(loginModel);
      Get.offAndToNamed('/dashboard');
    } catch (err) {print(err);
      Get.rawSnackbar(title: 'Login Failed!', message: err.toString());
    } finally {
      currentState.value = LoginAuthState.InitialState;
    }
  }
}
