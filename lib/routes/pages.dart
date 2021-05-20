<<<<<<< HEAD
import 'package:inventory_management_system/app/modules/DashBoard/binding.dart';
import 'package:inventory_management_system/app/modules/DashBoard/page.dart';
import 'package:inventory_management_system/app/modules/LoginPage/binding.dart';
import 'package:inventory_management_system/app/modules/LoginPage/page.dart';
=======
>>>>>>> c438e861d6aa52438c92487a6cb6b0f3229d4a14
import 'package:get/get.dart';

import '../app/modules/LoginPage/binding.dart';
import '../app/modules/LoginPage/page.dart';

part './routes.dart';

abstract class AppPages {
  static final getPages = [
      GetPage(name:Routes.LOGIN, page: () => LoginPage(), binding: LoginPageBinding()),
      GetPage(name:Routes.DASHBOARD, page: () => DashboardPage(), binding: DashboardPageBinding()),
  ];
  
}



