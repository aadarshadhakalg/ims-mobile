import 'package:inventory_management_system/app/modules/DashBoard/controller.dart';
import 'package:inventory_management_system/core/themes/text_theme.dart';
import 'package:inventory_management_system/core/values/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardPageController> {

  DashboardPage({Key key}) : super(key: key);

  var controller = Get.put(DashboardPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(this.controller.testApiString.value,
              style: CustomTextStyle.title_style)),
              SizedBox(height:20),
              InkWell(
                child: Container(
                  margin: EdgeInsets.all(UIConstants.defaultPadding),
                  child: Text('click here to test')
                ),
                onTap:this.controller.performTest, 
              )
            ]
          ) 
        )
      )
    );
  }
}