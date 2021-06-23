/*
TODO
create splash page remove dependecy injection from controller page
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management_system/app/data/services/service.dart';
import 'package:inventory_management_system/app/modules/LoginPage/binding.dart';
import 'package:inventory_management_system/core/themes/app_theme.dart';

import 'routes/pages.dart';



Future<void> initServices() async{
  await GetStorage.init();
  await Get.putAsync<AppConfigService>(() async => AppConfigService().init());
}

Future<void> main() async{
  await initServices();
  runApp(ims());
}


GetMaterialApp ims(){ 
    var controller = Get.find<AppConfigService>();
    return GetMaterialApp(
      theme: darkThemeData,
      getPages: AppPages.getPages,
      initialBinding: LoginPageBinding(),
      initialRoute: !controller.isLoggedIn.value ? Routes.LOGIN : Routes.DASHBOARD,
    );
}




