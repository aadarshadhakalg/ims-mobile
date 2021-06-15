import 'package:flutter/material.dart';

import '../../../constants.dart';

class CategoryInfoCard extends StatelessWidget {
  const CategoryInfoCard({
    Key key,
    @required this.name,
    @required this.photo,
    @required this.noOfSoldProducts,
    @required this.noOfSubCategories,
  }) : super(key: key);

  final String name, photo;
  final int noOfSubCategories, noOfSoldProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(photo),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$noOfSubCategories Sub Categories",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Text('$noOfSoldProducts Sold')
        ],
      ),
    );
  }
}
