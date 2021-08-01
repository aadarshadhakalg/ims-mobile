
import 'package:flutter/cupertino.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../DashBoard/ui/responsive.dart';
import 'dart:io';

class ReceiptPage extends StatelessWidget {

    RxList<RxMap<String,dynamic>> data = Get.arguments;
    var finalTotal = 0;
    final textController = TextEditingController();

    void generatePdf() async{

      final pdf = pw.Document();
    pdf.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return 
      pw.Column(children: [ 
      pw.Center(child:pw.Text("IMS Sem Project")),
      pw.SizedBox(height: 40),
      pw.Row(
         mainAxisAlignment: pw.MainAxisAlignment.start,
      children:[
      pw.Text("Customer : ${textController.value.text}"),
      ] ),
      pw.SizedBox(height: 40),
      pw.Table.fromTextArray(
        headers: ['Product Name', 'Product Quantity','Product Price','Product Total'],
        cellAlignment: pw.Alignment.center,
        data: [
          ...[...data.map((v){
               var total =int.parse(v['product'].productMaxPrice)*v['value'];
            return [v['product'].productName,v['value'].toString(),v['product'].productMaxPrice,total];
          })]
        ]),
      pw.Row(
         mainAxisAlignment: pw.MainAxisAlignment.start,
      children:[
      pw.Text("Grand Total : Rs. $finalTotal"),
      ] ),
        ]);
    }));  
    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
    }
   
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Receipt'),
          ),
          body: SafeArea(
            child: Padding(
              padding:EdgeInsets.all(12.0),
              child: Column(
                children:[ 
                  TextField(
                  controller:textController,
                  onChanged: (data){
                    print(textController.value.text);
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Customer Name',
                    border: OutlineInputBorder(
                    ),
                    suffixIcon: Icon(Icons.supervised_user_circle)
                  ),
                ),
                  SizedBox(height:30),
                     Row(children: [
                      cell(context,0, "Product Name",3),
                      cell(context,0,"Quantity",1),
                      cell(context,0,"Price",1),
                    ],),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context,index){
                    var total =int.parse(data[index]['product'].productMaxPrice)*data[index]['value'];
                    finalTotal += total;
                    return Row(children: [
                      cell(context,index, data[index]['product'].productName,3),
                      cell(context,index,data[index]['value'].toString(),1),
                      cell(context,index,total.toString(),1),
                    ],
                    );
                              },
                              itemCount: data.length,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child: ElevatedButton(onPressed: generatePdf, child: Text("Generate Receipt"))),
                    SizedBox(width: 50),
                    ElevatedButton(onPressed:(){} ,child: Text("Dashboard")),
                  ],)
                ]
              ),
            ),
          ) ,
        );
    }

    Expanded cell(BuildContext context,int index, String text,int flex) {
      return Expanded(
        flex:flex,
        child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue)
                ), 
                child: Text(text,style: TextStyle(
                  fontSize: Responsive.isMobile(context)? 12 :20
                ),)),
      );
    }

}