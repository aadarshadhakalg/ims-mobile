import 'dart:convert';
import 'package:meta/meta.dart';

class Productmodel {
  final String urlSlug;
  final int subCategoriesId;
  final String productName;
  final String brand;
  final String productMaxPrice;
  final String productDiscountPrice;
  final String productDescription;
  final String productLongDescription;
  final String createdAt;
  final int totalStock;
  final int isActive;
  Productmodel({
    @required this.urlSlug,
    @required this.subCategoriesId,
    @required this.productName,
    @required this.brand,
    @required this.productMaxPrice,
    @required this.productDiscountPrice,
    @required this.productDescription,
    @required this.productLongDescription,
    @required this.createdAt,
    @required this.totalStock,
    @required this.isActive,
  });

  Productmodel copyWith({
    int subCategoriesId,
    String urlSlug,
    String productName,
    String brand,
    String productMaxPrice,
    String productDiscountPrice,
    String productDescription,
    String productLongDescription,
    String createdAt,
    int totalStock,
    int isActive,
  }) {
    return Productmodel(
      urlSlug: urlSlug ?? this.urlSlug,
      subCategoriesId: subCategoriesId ?? this.subCategoriesId,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      productMaxPrice: productMaxPrice ?? this.productMaxPrice,
      productDiscountPrice: productDiscountPrice ?? this.productDiscountPrice,
      productDescription: productDescription ?? this.productDescription,
      productLongDescription:
          productLongDescription ?? this.productLongDescription,
      createdAt: createdAt ?? this.createdAt,
      totalStock: totalStock ?? this.totalStock,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url_slug': urlSlug,
      'sub_categories_id': subCategoriesId,
      'product_name': productName,
      'brand': brand,
      'product_max_price': productMaxPrice,
      'product_discount_price': productDiscountPrice,
      'product_description': productDescription,
      'product_long_description': productLongDescription,
      'created_at': createdAt,
      'total_stock': totalStock,
      'is_active': isActive,
    };
  }

  factory Productmodel.fromMap(Map<String, dynamic> map) {
    return Productmodel(
      urlSlug: map['url_slug'],
      subCategoriesId: map['sub_categories_id']?.toInt(),
      productName: map['product_name'],
      brand: map['brand'],
      productMaxPrice: map['product_max_price'],
      productDiscountPrice: map['product_discount_price'],
      productDescription: map['product_description'],
      productLongDescription: map['product_long_description'],
      createdAt: map['created_at'],
      totalStock: map['total_stock']?.toInt(),
      isActive: map['is_active']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Productmodel.fromJson(String source) =>
      Productmodel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Productmodel(url_slug: $urlSlug, sub_categories_id: $subCategoriesId, product_name: $productName, brand: $brand, product_max_price: $productMaxPrice, product_discount_price: $productDiscountPrice, product_description: $productDescription, product_long_description: $productLongDescription, created_at: $createdAt, total_stock: $totalStock, is_active: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Productmodel &&
        other.urlSlug == urlSlug &&
        other.subCategoriesId == subCategoriesId &&
        other.productName == productName &&
        other.brand == brand &&
        other.productMaxPrice == productMaxPrice &&
        other.productDiscountPrice == productDiscountPrice &&
        other.productDescription == productDescription &&
        other.productLongDescription == productLongDescription &&
        other.createdAt == createdAt &&
        other.totalStock == totalStock &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return urlSlug.hashCode ^
        subCategoriesId.hashCode ^
        productName.hashCode ^
        brand.hashCode ^
        productMaxPrice.hashCode ^
        productDiscountPrice.hashCode ^
        productDescription.hashCode ^
        productLongDescription.hashCode ^
        createdAt.hashCode ^
        totalStock.hashCode ^
        isActive.hashCode;
  }
}
