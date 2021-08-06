import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class QRPrint extends StatelessWidget {
  const QRPrint({Key key, this.qr}) : super(key: key);

  final Uint8List qr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('QR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfPreview(
              build: (pdf) {
                return qr;
              },
            ),
          ),
        ],
      ),
    );
  }
}
