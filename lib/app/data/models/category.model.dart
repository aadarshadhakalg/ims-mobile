// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromMap(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromMap(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromMap(x)));

String categoryModelToMap(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CategoryModel {
    CategoryModel({
        this.id,
        this.title,
        this.urlSlug,
        this.description,
        this.isActive,
    });

    int id;
    String title;
    String urlSlug;
    String description;
    int isActive;

    factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        urlSlug: json["url_slug"],
        description: json["description"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "url_slug": urlSlug,
        "description": description,
        "is_active": isActive,
    };
}
