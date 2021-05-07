import 'package:flutter/material.dart';
import 'package:inventory_management_system/core/constants/route_generator.dart';
import 'package:inventory_management_system/features/global/views/home_page.dart';


void main() => runApp(IMS());

class IMS extends StatelessWidget {

  /*
    TODO: Let's use GetX statemanagement for easyness. Let's develop it ASAP, and let's not bother about 
    writing tests and anything. Use, dio as http client to interact with api.

  */


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: HomePage.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}