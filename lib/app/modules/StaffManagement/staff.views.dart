import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/responsive.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/widgets/staffbox_widget.dart';

class StaffView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Staffs",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add Staff"),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            direction: Axis.horizontal,
            children: [
              for (int i = 0; i < 10; i++)
                Hero(
                  tag: 'staff-avatar',
                  child: StaffBox(
                    id: '1',
                    name: 'Aadarsha Dhakal',
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
