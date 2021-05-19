import 'package:inventory_management_system/app/modules/LoginPage/binding.dart';
import 'package:inventory_management_system/app/modules/LoginPage/page.dart';
import 'package:get/get.dart';

part './routes.dart';

abstract class AppPages {
  static final getPages = [
      GetPage(name:Routes.LOGIN, page: () => LoginPage(), binding: LoginPageBinding()),
  ];
  
}



