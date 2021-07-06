import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/responsive.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/widgets/all_staff.widget.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/widgets/staff_detail.widget.dart';

class StaffView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (context, constraints) {
        if (Responsive.isDesktop(context)) {
          return Row(
            children: [
              AllStaffWidget(),
              StaffDetailWidget(),
            ],
          );
        } else {
          return Column(
            children: [],
          );
        }
      }),
    );
  }
}
