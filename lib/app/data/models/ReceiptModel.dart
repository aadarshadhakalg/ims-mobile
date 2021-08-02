class ReceiptModel {
  int id;
  String quantity;
  int purchasePrice;
  int discountAmount;
  int totalItems;
  String createdAt;
  String uniqueToken;
  bool redeemed;

  ReceiptModel(
      {this.id,
      this.quantity,
      this.purchasePrice,
      this.discountAmount,
      this.totalItems,
      this.createdAt,
      this.uniqueToken,
      this.redeemed});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    purchasePrice = json['purchase_price'];
    discountAmount = json['discount_amount'];
    totalItems = json['total_items'];
    createdAt = json['created_at'];
    uniqueToken = json['unique_token'];
    redeemed = json['redeemed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['purchase_price'] = this.purchasePrice;
    data['discount_amount'] = this.discountAmount;
    data['total_items'] = this.totalItems;
    data['created_at'] = this.createdAt;
    data['unique_token'] = this.uniqueToken;
    data['redeemed'] = this.redeemed;
    return data;
  }
}