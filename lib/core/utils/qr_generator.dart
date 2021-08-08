import 'dart:typed_data';
import 'dart:ui';

import 'package:get/get.dart';
import 'QrPrinting.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR {
  GenerateQR._internal();
  static GenerateQR _instance = GenerateQR._internal();
  factory GenerateQR() {
    return _instance;
  }

  final qrCode = new QrCode(4, QrErrorCorrectLevel.L);

  Future<void> generateFromData(String data, String name) async {
    qrCode.addData(data);
    qrCode.make();

    var painter = QrPainter.withQr(qr: qrCode);
    ByteData qrImage =
        await painter.toImageData(1024, format: ImageByteFormat.png);

// Make PDF of QR
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(child: pw.Text(name)),
            pw.SizedBox(height: 20),
            pw.Image(pw.MemoryImage(qrImage.buffer.asUint8List()))
          ]);
        }));

    Get.to(QRPrint(
      qr: await pdf.save(),
    ));

    // return qrCode;
  }
}
