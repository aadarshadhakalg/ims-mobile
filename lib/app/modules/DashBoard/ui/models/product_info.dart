
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductInfo {
  final String image, title, category;
  final int sold, percentage, inStock;
  final Color color;

  ProductInfo({
    this.image,
    this.title,
    this.inStock,
    this.category,
    this.sold,
    this.percentage,
    this.color,
  });
}

List demoProducts = [
  ProductInfo(
    title: "Tuborg",
    sold: 1328,
    image: "assets/images/tuborg.jpg",
    inStock: 328,
    color: primaryColor,
    category: 'Drinks',
    percentage: 35,
  ),
  ProductInfo(
    title: "Bread",
    sold: 1328,
    image: "assets/images/tuborg.jpg",
    inStock: 328,
    color: Colors.orange,
    category: 'Bakery',
    percentage: 35,
  ),
  ProductInfo(
    title: "Laptop",
    sold: 1328,
    image: "assets/images/tuborg.jpg",
    inStock: 328,
    color: Colors.blue,
    category: 'Electronics',
    percentage: 35,
  ),
  ProductInfo(
    title: "Flutter Complete Reference",
    sold: 1328,
    image: "assets/images/tuborg.jpg",
    inStock: 328,
    color: Colors.brown,
    category: 'Books',
    percentage: 35,
  ),
  
];
