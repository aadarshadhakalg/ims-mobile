import 'package:inventory_management_system/app/data/services/service.dart';
import 'package:inventory_management_system/app/modules/LoginPage/page.dart';
import 'package:inventory_management_system/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/routes/pages.dart';
import 'package:inventory_management_system/app/modules/DashBoard/page.dart';

Future<void> initServices() async {
  await GetStorage.init();
  await Get.putAsync<AppConfigService>(() async => AppConfigService().init());
}

Future<void> main() async {
  await initServices();
  runApp(ims());
}

GetMaterialApp ims() {
  var controller = Get.find<AppConfigService>();
  return GetMaterialApp(
    //later we can add splash screen too.
    theme: darkThemeData,
    getPages: AppPages.getPages,
    home: !controller.isLoggedIn.value ? LoginPage(): LayoutPage(),
  );
}
