import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/repository.dart';

import '../../../constants.dart';
import 'category_info_card.dart';
import 'chart.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap){
        if(snap.hasData){
          print(snap.data);
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
              "Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Chart(data:snap.data),
            Container(
              width:double.infinity,
              height:300,
              child: ListView.builder(itemBuilder: (context, index){
                return CategoryInfoCard(
                photo: "assets/images/tuborg.jpg",
                name: snap.data['categories'][index].category,
                noOfSoldProducts: snap.data['categories'][index].sold,
                noOfSubCategories: snap.data['categories'][index].subcategories,
              );
              },
              itemCount: snap.data['categories'].length,
              ),
            ),
          ],
        ),
      );
        }else{
          return Container(child: Center(child: CircularProgressIndicator()),);
        }
      },
      future: DashboardRepository.fetchPopularCategories(),
    );
  }
}
