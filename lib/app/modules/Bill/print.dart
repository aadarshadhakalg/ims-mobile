import 'dart:io';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReceiptPrint extends StatelessWidget {
  const ReceiptPrint({Key key, this.action}) : super(key: key);

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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     IconButton(
          //       onPressed: () {
          //         action.call();
          //       },
          //       icon: Icon(Icons.arrow_back),
          //     ),
          //     Spacer(),
          //     Text(
          //       'Receipt',
          //       style: TextStyle(
          //         fontSize: 25.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Spacer(),
          //     CircleAvatar(
          //       backgroundColor: Colors.blue,
          //       child: IconButton(
          //         focusColor: Colors.blue,
          //         icon: Icon(
          //           Icons.print,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {},
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: PdfPreview(
              build: (pdf) {
                return File('example.pdf').readAsBytes();
              },
            ),
          ),
        ],
      ),
    );
  }
}
