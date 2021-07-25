import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';

class StaffDetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: 'staff-avatar',
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 100,
                backgroundImage: AssetImage(
                  "assets/images/staff-avatar.jpg",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
