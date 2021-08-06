import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReceiptPrint extends StatelessWidget {
  const ReceiptPrint({Key key, this.action, this.receipt}) : super(key: key);

  final Uint8List receipt;

  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: action,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Receipt'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PdfPreview(
              build: (pdf) {
                return receipt;
              },
            ),
          ),
        ],
      ),
    );
  }
}
