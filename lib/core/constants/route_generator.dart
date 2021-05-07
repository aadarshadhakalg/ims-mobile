import 'package:flutter/material.dart';
import 'package:inventory_management_system/features/global/views/home_page.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return errorRoute();
    }
  }

  static Route errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Material(
        child: Scaffold(
          body: Center(
            child: Text('Route Not Found'),
          ),
        ),
      ),
    );
  }
}
