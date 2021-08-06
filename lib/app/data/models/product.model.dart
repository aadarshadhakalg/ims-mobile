// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  ProductModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  String previous;
  List<Result> results;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.urlSlug,
    this.subCategoriesId,
    this.productName,
    this.brand,
    this.productMaxPrice,
    this.productDiscountPrice,
    this.productDescription,
    this.productLongDescription,
    this.createdAt,
    this.totalStock,
    this.isActive,
    this.id,
  });

  String urlSlug;
  int subCategoriesId;
  String productName;
  String brand;
  int productMaxPrice;
  int productDiscountPrice;
  String productDescription;
  String productLongDescription;
  DateTime createdAt;
  int totalStock;
  int isActive;
  int id;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        urlSlug: json["url_slug"],
        subCategoriesId: json["sub_categories_id"],
        productName: json["product_name"],
        brand: json["brand"],
        productMaxPrice: json["product_max_price"],
        productDiscountPrice: json["product_discount_price"],
        productDescription: json["product_description"],
        productLongDescription: json["product_long_description"],
        createdAt: DateTime.parse(json["created_at"]),
        totalStock: json["total_stock"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "url_slug": urlSlug,
        "sub_categories_id": subCategoriesId,
        "product_name": productName,
        "brand": brand,
        "product_max_price": productMaxPrice,
        "product_discount_price": productDiscountPrice,
        "product_description": productDescription,
        "product_long_description": productLongDescription,
        "created_at": createdAt.toIso8601String(),
        "total_stock": totalStock,
        "is_active": isActive,
        "id": id,
      };
}
