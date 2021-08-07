import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/staff.model.dart';
import '../DashBoard/ui/constants.dart';
import '../DashBoard/ui/responsive.dart';
import 'pages/pay_staff_controller.dart';
import 'staff.controller.dart';
import 'widgets/staffbox_widget.dart';

class StaffView extends StatelessWidget {
  final StaffController _staffController = Get.put(StaffController());
  final PayrollController _payrollController = Get.put(PayrollController());

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
                onPressed: () {
                  Get.toNamed('/add-staff');
                },
                icon: Icon(Icons.add),
                label: Text("Add Staff"),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          GetX<StaffController>(
            builder: (StaffController controller) {
              if (controller.allStaffs.value == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    direction: Axis.horizontal,
                    children: [
                      for (Staff staff in controller.allStaffs.value.results)
                        StaffBox(
                          staff: staff,
                        )
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
