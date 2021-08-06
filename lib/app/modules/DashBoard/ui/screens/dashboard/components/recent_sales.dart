import 'package:flutter/material.dart';
import '../../../../../../data/models/ReceiptModel.dart';
import '../../../../repository.dart';

import '../../../constants.dart';

class RecentSales extends StatelessWidget {
  const RecentSales({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snap) {
          if (snap.hasData) {
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Sales Token"),
                        ),
                        DataColumn(
                          label: Text("Date"),
                        ),
                        DataColumn(
                          label: Text("Bill Amount"),
                        ),
                        DataColumn(
                          label: Text("Token Redeemed"),
                        ),
                      ],
                      rows: List.generate(
                        snap.data.length,
                        (index) => recentSaleDataRow(snap.data[index]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snap.hasError) {
            return Container(child: Text("Couldn't fetch data"));
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        future: DashboardRepository.fetchReceipts());
  }
}

DataRow recentSaleDataRow(ReceiptModel saleInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.asset(
              "assets/images/sales.png",
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(saleInfo.uniqueToken),
            ),
          ],
        ),
      ),
      DataCell(Text(DateTime.parse(saleInfo.createdAt).toLocal().toString())),
      DataCell(Text('Rs ${saleInfo.purchasePrice}')),
      DataCell(Icon(saleInfo.redeemed
          ? Icons.check_circle_outline
          : Icons.circle_outlined)),
    ],
  );
}
