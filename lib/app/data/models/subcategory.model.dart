// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromMap(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromMap(String str) =>
    List<SubCategoryModel>.from(
        json.decode(str).map((x) => SubCategoryModel.fromMap(x)));

String subCategoryModelToMap(List<SubCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SubCategoryModel {
  SubCategoryModel({
    this.id,
    this.categoryId,
    this.title,
    this.urlSlug,
    this.description,
    this.createdAt,
    this.isActive,
  });

  int id;
  int categoryId;
  String title;
  String urlSlug;
  String description;
  DateTime createdAt;
  int isActive;

  factory SubCategoryModel.fromMap(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        urlSlug: json["url_slug"],
        description: json["description"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        isActive: json["is_active"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "url_slug": urlSlug,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}
