import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/responsive.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    Key key,
    @required this.heading,
    @required this.value,
  }) : super(key: key);

  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$heading',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12 : 20.0,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Text(
                '$value',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 30 : 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
