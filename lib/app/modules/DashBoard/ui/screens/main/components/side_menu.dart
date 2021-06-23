import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/controllers/MenuController.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key key,
  }) : super(key: key);

  final MenuController _menuController = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Counter",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              _menuController.goTo(Menu.Home);
            },
          ),
          DrawerListTile(
            title: "Products",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              _menuController.goTo(Menu.Products);
            },
          ),
          DrawerListTile(
            title: "Categories",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              _menuController.goTo(Menu.Category);
            },
          ),
          DrawerListTile(
            title: "Analysis",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              _menuController.goTo(Menu.Analysis);
            },
          ),
          DrawerListTile(
            title: "Staff Management",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              _menuController.goTo(Menu.Staff);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              _menuController.goTo(Menu.Setting);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
