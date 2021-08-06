import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/ProductModel.dart';
import 'package:inventory_management_system/app/modules/Bill/controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BillQRScan extends StatefulWidget {
  const BillQRScan({Key key}) : super(key: key);

  @override
  _BillQRScanState createState() => _BillQRScanState();
}

class _BillQRScanState extends State<BillQRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final BillPageController _billPageController = Get.find<BillPageController>();
  Barcode result;
  QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          height: Get.height / 3,
          child: GetX(
            builder: (BillPageController bcontroller) {
              return ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                      height: 30,
                      color: Colors.green,
                      child: Center(child: Text("Added Items"))),
                  Divider(),
                  if (_billPageController.addedProducts.isEmpty)
                    Text('No Items'),
                  ...[
                    ..._billPageController.addedProducts.map(
                      (e) {
                        return itemTile(
                            element: e['product'],
                            isAlreadyAdded: true,
                            valueAdded: e['value']);
                      },
                    )
                  ]
                ],
              );
            },
          ),
        );
      },
    );
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      var res = await _billPageController.startQRSearch(scanData.code);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(res ? 'Item Added' : 'Item Not Found'),
              content: Text('Do you want to scan another?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    'NO',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    controller.resumeCamera();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            );
          });
    });
  }

  InkWell itemTile(
      {ProductModel element, bool isAlreadyAdded, int valueAdded}) {
    return InkWell(
      onTap: () {
        if (!isAlreadyAdded) {
          _billPageController.addProduct(element);
        }

        if (isAlreadyAdded) {
          _billPageController.removeProduct(element);
        }
      },
      child: Card(
        color: Colors.blue.shade800,
        elevation: 5,
        child: ListTile(
          subtitle: Text('${element.brand}'),
          title: Text('${element.productName}'),
          leading: Container(
            width: 80,
            child: Row(
              children: [
                Icon(Icons.price_check),
                Text(element.productMaxPrice)
              ],
            ),
          ),
          trailing: Container(
            width: 40,
            child: Row(
              children: [
                !isAlreadyAdded ? Icon(Icons.add) : Icon(Icons.delete),
                if (isAlreadyAdded) Text(valueAdded.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
