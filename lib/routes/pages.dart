import 'package:get/get.dart';

import '../app/modules/LoginPage/binding.dart';
import '../app/modules/LoginPage/page.dart';

part './routes.dart';

abstract class AppPages {
  static final getPages = [
      GetPage(name:Routes.LOGIN, page: () => LoginPage(), binding: LoginPageBinding()),
  ];
  
}



