import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'print.dart';
import '../../../core/utils/dio/dio_base.dart';
import '../../../core/utils/mailer.dart';
import '../../../routes/pages.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../DashBoard/ui/responsive.dart';
import '../../data/models/ReceiptModel.dart';

// ignore: must_be_immutable
class ReceiptPage extends StatelessWidget {
  RxList<RxMap<String, dynamic>> data = Get.arguments;
  var finalTotal = 0;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  ReceiptModel receipt;

  Uint8List generatedPdf;

  Future<void> submitReceipt() async {
    List<int> productId = [];
    List<String> productQuantity = [];
    try {
      print(data);
      data.forEach((element) {
        productId.add(element['product'].id);
        productQuantity.add(element['value'].toString());
      });
      String quantityString = productQuantity.join(",");
      var dataToSend = {'product': productId, 'quantity': quantityString};

      var response = await DioSingleton()
          .instance
          .post('/product/createReceipt/', data: dataToSend);
      receipt = new ReceiptModel.fromJson(response.data);
      print(receipt.uniqueToken);
      await generatePdf();
      Mailer.instance.sendReceipt(emailController.text);
    } catch (e) {
      print(e);
    }
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(child: pw.Text("IMS Sem Project")),
            pw.SizedBox(height: 40),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text("Customer : ${nameController.value.text}"),
            ]),
            pw.SizedBox(height: 40),
            pw.Table.fromTextArray(
                headers: [
                  'Product Name',
                  'Product Quantity',
                  'Product Price',
                  'Product Total'
                ],
                cellAlignment: pw.Alignment.center,
                data: [
                  ...[
                    ...data.map((v) {
                      var total =
                          int.parse(v['product'].productMaxPrice) * v['value'];
                      return [
                        v['product'].productName,
                        v['value'].toString(),
                        v['product'].productMaxPrice,
                        total
                      ];
                    })
                  ]
                ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text("Grand Total : Rs. $finalTotal"),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text("Unique UID : ${receipt.uniqueToken}"),
            ]),
          ]);
        }));
    generatedPdf = await pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(children: [
            TextField(
              controller: nameController,
              onChanged: (data) {
                print(nameController.value.text);
              },
              decoration: InputDecoration(
                  labelText: 'Enter Customer Name',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.supervised_user_circle)),
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              onChanged: (data) {
                print(nameController.value.text);
              },
              decoration: InputDecoration(
                  labelText: 'Enter Customer Email',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.supervised_user_circle)),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                cell(context, 0, "Product Name", 3),
                cell(context, 0, "Quantity", 1),
                cell(context, 0, "Price", 1),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var total =
                      int.parse(data[index]['product'].productMaxPrice) *
                          data[index]['value'];
                  finalTotal += total;
                  return Row(
                    children: [
                      cell(context, index, data[index]['product'].productName,
                          3),
                      cell(context, index, data[index]['value'].toString(), 1),
                      cell(context, index, total.toString(), 1),
                    ],
                  );
                },
                itemCount: data.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OpenContainer(
                  closedBuilder:
                      (BuildContext context, void Function() action) {
                    return ElevatedButton(
                      onPressed: () async {
                        await submitReceipt();
                        action.call();
                      },
                      child: Text("Generate Receipt"),
                    );
                  },
                  openBuilder: (BuildContext context,
                      void Function({Object returnValue}) action) {
                    return ReceiptPrint(
                      action: action,
                      receipt: generatedPdf,
                    );
                  },
                ),
                SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.DASHBOARD);
                  },
                  child: Text("Dashboard"),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Expanded cell(BuildContext context, int index, String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: Text(
            text,
            style: TextStyle(fontSize: Responsive.isMobile(context) ? 12 : 20),
          )),
    );
  }
}
