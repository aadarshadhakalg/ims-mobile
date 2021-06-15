import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/models/sale_model.dart';

import '../../../constants.dart';

class RecentSales extends StatelessWidget {
  const RecentSales({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Sales",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Customer Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Bill Amount"),
                ),
              ],
              rows: List.generate(
                demoRecentSales.length,
                (index) => recentSaleDataRow(demoRecentSales[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentSaleDataRow(RecentSalesModel saleInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              saleInfo.photo,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(saleInfo.name),
            ),
          ],
        ),
      ),
      DataCell(Text(saleInfo.date)),
      DataCell(Text('Rs ${saleInfo.billAmount}')),
    ],
  );
}
