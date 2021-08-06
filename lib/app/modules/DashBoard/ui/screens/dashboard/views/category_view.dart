import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/CategoryModel.dart';
import '../../../../../../../core/utils/dio/dio_base.dart';
import '../../../../../../../routes/pages.dart';
import '../../../constants.dart';
import '../../../responsive.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Wrap(
            runSpacing: 20,
            spacing: 20,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.spaceBetween,
            children: [
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
              addButton(
                context,
                "Add Products",
                () {
                  Get.toNamed(Routes.ADDPRODUCT, arguments: ["add", ""]);
                },
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
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
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADDCATEGORY,
                          arguments: ["update", "${snap.data[index].urlSlug}"]);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.category),
                        title: Text(snap.data[index].title),
                        subtitle: Text(snap.data[index].description),
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
        future: fetchCategories());
  }

  Future<List<CategoryModel>> fetchCategories() async {
    List<CategoryModel> categories = [];
    try {
      var response =
          await DioSingleton().instance.get('/product/categorylist/');
      for (var e in response.data['results']) {
        categories.add(new CategoryModel.fromJSON(e));
      }
    } catch (e) {
      print(e);
    }
    return categories;
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
