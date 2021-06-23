class RecentSalesModel {
  final String photo, name, date;
  final double billAmount;

  RecentSalesModel({this.photo, this.name, this.date, this.billAmount});
}

List demoRecentSales = [
  RecentSalesModel(
    photo: "assets/images/profile_pic.png",
    name: "Test Costumer",
    date: "01-03-2021",
    billAmount: 200.00,
  ),
];
