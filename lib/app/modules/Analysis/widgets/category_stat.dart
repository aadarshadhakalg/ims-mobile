import 'package:flutter/material.dart';
import '../../DashBoard/ui/constants.dart';

class CategoryStatCard extends StatelessWidget {
  const CategoryStatCard({
    Key key,
    @required this.name,
    @required this.stockSold,
    @required this.totalStock,
    @required this.soldAmount,
    @required this.profit,
  }) : super(key: key);

  final String name;
  final int stockSold, totalStock, soldAmount, profit;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$totalStock Stock",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.amber),
              ),
              Text(
                "$stockSold Sold",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.blue),
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs $soldAmount Sales",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.purpleAccent),
              ),
              Text(
                "Rs $soldAmount Profit",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
