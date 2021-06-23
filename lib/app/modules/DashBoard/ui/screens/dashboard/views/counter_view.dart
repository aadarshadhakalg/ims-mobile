import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/components/category_details.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/components/recent_sales.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/screens/dashboard/components/top_sales.dart';

import '../../../responsive.dart';

class CounterView extends StatelessWidget {
  const CounterView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              TopSales(),
              SizedBox(height: defaultPadding),
              RecentSales(),
              if (Responsive.isMobile(context))
                SizedBox(height: defaultPadding),
              if (Responsive.isMobile(context)) CategoryDetails(),
            ],
          ),
        ),
        if (!Responsive.isMobile(context))
          SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: CategoryDetails(),
          ),
      ],
    );
  }
}
