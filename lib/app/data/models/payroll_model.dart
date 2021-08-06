// To parse this JSON data, do
//
//     final payrollModel = payrollModelFromMap(jsonString);

import 'dart:convert';

PayrollModel payrollModelFromMap(String str) =>
    PayrollModel.fromMap(json.decode(str));

String payrollModelToMap(PayrollModel data) => json.encode(data.toMap());

class PayrollModel {
  PayrollModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  String previous;
  List<Payments> results;

  factory PayrollModel.fromMap(Map<String, dynamic> json) => PayrollModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Payments>.from(
            json["results"].map((x) => Payments.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Payments {
  Payments({
    this.staff,
    this.paidMoney,
    this.paidAt,
  });

  int staff;
  int paidMoney;
  DateTime paidAt;

  factory Payments.fromMap(Map<String, dynamic> json) => Payments(
        staff: json["staff"],
        paidMoney: json["paid_money"],
        paidAt: DateTime.parse(json["paid_at"]),
      );

  Map<String, dynamic> toMap() => {
        "staff": staff,
        "paid_money": paidMoney,
        "paid_at": paidAt.toIso8601String(),
      };
}
