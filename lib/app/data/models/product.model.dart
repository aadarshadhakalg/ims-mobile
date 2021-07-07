// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromMap(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromMap(x)));

String productModelToMap(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductModel {
    ProductModel({
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
    });

    String urlSlug;
    int subCategoriesId;
    String productName;
    String brand;
    String productMaxPrice;
    String productDiscountPrice;
    String productDescription;
    String productLongDescription;
    DateTime createdAt;
    int totalStock;
    int isActive;

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        urlSlug: json["url_slug"],
        subCategoriesId: json["sub_categories_id"],
        productName: json["product_name"],
        brand: json["brand"],
        productMaxPrice: json["product_max_price"],
        productDiscountPrice: json["product_discount_price"],
        productDescription: json["product_description"],
        productLongDescription: json["product_long_description"],
        createdAt:json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        totalStock: json["total_stock"],
        isActive: json["is_active"],
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
        "created_at": createdAt?.toIso8601String(),
        "total_stock": totalStock,
        "is_active": isActive,
    };
}
