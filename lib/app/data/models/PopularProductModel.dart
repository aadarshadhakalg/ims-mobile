class PopularProductModel {
  String product;
  int totalStock;
  int originalStock;

  PopularProductModel({this.product, this.totalStock, this.originalStock});

  PopularProductModel.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    totalStock = json['total_stock'];
    originalStock = json['original_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['total_stock'] = this.totalStock;
    data['original_stock'] = this.originalStock;
    return data;
  }
}
