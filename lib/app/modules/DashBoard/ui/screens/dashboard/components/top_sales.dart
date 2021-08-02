import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'package:get/utils.dart';
import 'package:inventory_management_system/app/modules/DashBoard/repository.dart';
import 'package:inventory_management_system/routes/pages.dart';
import '../../../models/product_info.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'product_info_card.dart';

class TopSales extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Sellers",
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
                Get.toNamed(Routes.NEWBILL);
              },
              icon: Icon(Icons.add),
              label: Text("New Bill"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: ProductInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: ProductInfoCardGridView(),
          desktop: ProductInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class ProductInfoCardGridView extends StatelessWidget {
  const ProductInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder:(context,snap){
        if(snap.hasData){
       return GridView.builder(
        // scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snap.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => ProductInfoCard(info: snap.data[index]),
      );
        }else{
          return Container(child: CircularProgressIndicator());
        }
      },
      future: DashboardRepository.fetchPopularProducts(),
    );
  }
}
