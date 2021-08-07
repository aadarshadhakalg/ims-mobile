import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:inventory_management_system/app/modules/Analysis/widgets/category_stat.dart';
import 'package:inventory_management_system/app/modules/Analysis/widgets/stat_card.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/responsive.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            FutureBuilder<Response<Map>>(
              future: DioSingleton().instance.get<Map>(
                  'https://voidash.pythonanywhere.com/product/totalStock/'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatCard(
                      heading: 'Total Stock',
                      value: '${snapshot.data.data['total_stock']}',
                    ),
                    StatCard(
                      heading: 'Total Sold',
                      value: '${snapshot.data.data['stock_sold']}',
                    ),
                  ],
                );
              },
            ),
            FutureBuilder<Response<Map>>(
              future: DioSingleton().instance.get<Map>(
                  'https://voidash.pythonanywhere.com/product/totalProfit/'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatCard(
                      heading: 'Total Sold Amount',
                      value: 'Rs ${snapshot.data.data['sold_amount']}',
                    ),
                    StatCard(
                      heading: 'Total Profit',
                      value: 'Rs ${snapshot.data.data['profit']}',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              width: Responsive.isDesktop(context)
                  ? ((g.Get.width - 300) / 3) * 2
                  : g.Get.width,
              child: Center(child: Text('Products')),
            ),
            Container(
              width: Responsive.isDesktop(context)
                  ? (g.Get.width - 300) / 3
                  : g.Get.width,
              child: Column(
                children: [
                  Text('Stats By Categories'),
                  FutureBuilder<Response<Map>>(
                    future: DioSingleton().instance.get<Map>(
                        'https://voidash.pythonanywhere.com/product/totalStockAndProfitBySubCategory/'),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.data['count'],
                        itemBuilder: (context, index) {
                          return CategoryStatCard(
                            name: snapshot.data.data['results'][index]
                                ['subcategory_name'],
                            stockSold: snapshot.data.data['results'][index]
                                ['stock_sold'],
                            soldAmount: snapshot.data.data['results'][index]
                                ['sold_amount'],
                            profit: snapshot.data.data['results'][index]
                                ['profit'],
                            totalStock: snapshot.data.data['results'][index]
                                ['total_stock'],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
