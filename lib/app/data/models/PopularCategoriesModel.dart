class PopularCategoriesModel {
  String category;
  int subcategories;
  int product;
  int total;
  int sold;

  PopularCategoriesModel(
      {this.category, this.subcategories, this.product, this.total, this.sold});

  PopularCategoriesModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subcategories = json['subcategories'];
    product = json['product'];
    total = json['total'];
    sold = json['sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['subcategories'] = this.subcategories;
    data['product'] = this.product;
    data['total'] = this.total;
    data['sold'] = this.sold;
    return data;
  }
}
