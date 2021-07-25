import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

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
    int totalStock;
    int isActive;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        urlSlug: json["url_slug"],
        subCategoriesId: json["sub_categories_id"],
        productName: json["product_name"],
        brand: json["brand"],
        productMaxPrice: json["product_max_price"],
        productDiscountPrice: json["product_discount_price"],
        productDescription: json["product_description"],
        productLongDescription: json["product_long_description"],
        totalStock: json["total_stock"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "url_slug": urlSlug,
        "sub_categories_id": subCategoriesId,
        "product_name": productName,
        "brand": brand,
        "product_max_price": productMaxPrice,
        "product_discount_price": productDiscountPrice,
        "product_description": productDescription,
        "product_long_description": productLongDescription,
        "total_stock": totalStock,
        "is_active": isActive,
    };
}