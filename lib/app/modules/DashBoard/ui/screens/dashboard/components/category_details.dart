import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'category_info_card.dart';
import 'chart.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({
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
            "Categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          CategoryInfoCard(
            photo: "assets/images/tuborg.jpg",
            name: "Drinks",
            noOfSoldProducts: 1000,
            noOfSubCategories: 10,
          ),
          CategoryInfoCard(
            photo: "assets/images/tuborg.jpg",
            name: "Bakery",
            noOfSoldProducts: 189,
            noOfSubCategories: 4,
          ),
          CategoryInfoCard(
            photo: "assets/images/tuborg.jpg",
            name: "Electronics",
            noOfSoldProducts: 79,
            noOfSubCategories: 8,
          ),
          CategoryInfoCard(
            photo: "assets/images/tuborg.jpg",
            name: "Furniture",
            noOfSoldProducts: 257,
            noOfSubCategories: 7,
          ),
        ],
      ),
    );
  }
}
