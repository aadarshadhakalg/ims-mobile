import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/ProductModel.dart';
import 'controller.dart';
import '../DashBoard/ui/responsive.dart';

class BillPage extends GetView<BillPageController> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Bill'),
      ),
      body: Column(
        children: [
          searchArea(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: Get.width,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: [
                  searchBox(context),
                  addedItemBox(context),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: controller.generateReceipt,
                    child: Text("Generate Receipt"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding searchArea() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                onChanged: controller.startSearch,
                decoration: InputDecoration(
                    labelText: 'Enter Product Slug',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              child: Container(
                height: 58,
                child: Icon(Icons.qr_code),
              ),
              onPressed: () {
                //stub implment : Adarsha
              },
            )
          ],
        ),
      ),
    );
  }

  Widget addedItemBox(BuildContext context) {
    return Container(
        height:
            Responsive.isMobile(context) ? Get.height / 2.5 : Get.height / 1.5,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        width: Responsive.isMobile(context) ? Get.width : Get.width / 2.5,
        child: Obx(
          () => ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Container(
                  height: 30,
                  color: Colors.green,
                  child: Center(child: Text("Added Items"))),
              ...[
                ...controller.addedProducts.map(
                  (e) {
                    return itemTile(
                        element: e['product'],
                        isAlreadyAdded: true,
                        valueAdded: e['value']);
                  },
                )
              ]
            ],
          ),
        ));
  }

  Container searchBox(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        width: Responsive.isMobile(context) ? Get.width : Get.width / 2.5,
        height:
            Responsive.isMobile(context) ? Get.height / 2.5 : Get.height / 1.5,
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              Container(
                  height: 30,
                  color: Colors.red,
                  child: Center(child: Text("Items to Add"))),
              ...[
                if (controller.results.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(child: Text('No Items')),
                  )
                else
                  ...controller.results.map(
                    (element) {
                      return itemTile(element: element, isAlreadyAdded: false);
                    },
                  )
              ]
            ],
          ),
        ));
  }

  InkWell itemTile(
      {ProductModel element, bool isAlreadyAdded, int valueAdded}) {
    return InkWell(
      onTap: () {
        if (!isAlreadyAdded) {
          controller.addProduct(element);
        }

        if (isAlreadyAdded) {
          controller.removeProduct(element);
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
}
