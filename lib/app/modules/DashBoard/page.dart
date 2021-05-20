import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/themes/text_theme.dart';
import '../../../core/values/ui_constants.dart';
import 'controller.dart';

class DashboardPage extends GetView<DashboardPageController> {

  DashboardPage({Key key}) : super(key: key);

  final controller = Get.find<DashboardPageController>();

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