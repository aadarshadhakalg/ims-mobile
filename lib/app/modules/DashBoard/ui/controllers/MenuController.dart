import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Menu{
  Home,Products,Category,Setting,Staff,Analysis
}

class MenuController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Rx<Menu> selectedMenuItem = Rx<Menu>(null);


  void goTo(Menu page){
    selectedMenuItem.value = page;
  }


  void controlMenu() {
    if (!_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openDrawer();
    }
  }
}
