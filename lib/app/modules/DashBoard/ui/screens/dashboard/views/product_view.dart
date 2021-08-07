import 'package:flutter/material.dart';
import '../../../../../../data/models/ProductModel.dart';
import '../../../../../../../core/utils/dio/dio_base.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'package:get/get.dart';

import '../../../../../../../routes/pages.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();

  static Future<List<ProductModel>> fetchCategories() async {
    List<ProductModel> products = [];
    try {
      var response = await DioSingleton().instance.get('/product/productlist/');

      print(response.data['results']);
      for (var e in response.data['results']) {
        products.add(new ProductModel.fromJson(e));
      }
    } catch (e) {
      print(e);
    }
    return products;
  }
}

class _ProductViewState extends State<ProductView> {
  void refreshProduct() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Wrap(
            runSpacing: 2,
            spacing: 20,
            children: [
              addButton(
                context,
                "Add Products",
                () {
                  Get.toNamed(Routes.ADDPRODUCT,
                      arguments: ["add", "", refreshProduct]);
                },
              ),
              addButton(
                context,
                "Add Category",
                () {
                  Get.toNamed(Routes.ADDCATEGORY, arguments: ["add", ""]);
                },
              ),
              addButton(
                context,
                "Add SubCategory",
                () {
                  Get.toNamed(Routes.ADDSUBCATEGORY, arguments: ["add", ""]);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          listCategories()
        ],
      ),
    );
  }

  Widget listCategories() {
    return FutureBuilder(
        builder: (context, snap) {
          if (snap.hasData) {
            return Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADDPRODUCT, arguments: [
                        "update",
                        "${snap.data[index].urlSlug}",
                        refreshProduct
                      ]);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.category),
                        title: Text(snap.data[index].productName),
                        subtitle: Text(snap.data[index].productDescription),
                        trailing: snap.data[index].isActive == 0
                            ? Icon(Icons.event_busy)
                            : Icon(Icons.event_available),
                      ),
                    ),
                  );
                },
                itemCount: snap.data.length,
              ),
            );
          } else if (snap.hasError) {
            return Center(
              child: Text("error fetching categories. Try again later"),
            );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 100,
                height: 100,
              ),
            );
          }
        },
        future: ProductView.fetchCategories());
  }

  ElevatedButton addButton(
      BuildContext context, String value, Function() press) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal:
              defaultPadding * (Responsive.isMobile(context) ? 1.5 : 3.5),
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
      onPressed: press,
      icon: Icon(Icons.add),
      label: Text(value),
    );
  }
}
