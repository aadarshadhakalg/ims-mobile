
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/ProductModel.dart';
import 'package:inventory_management_system/app/modules/Bill/controller.dart';
import '../DashBoard/ui/responsive.dart';


class BillPage extends GetView<BillPageController> {

  Widget build(BuildContext context){
          return Scaffold(
            appBar: AppBar(
              title: Text('Generate Bill'),
            ),
            body: Column(
              children:[searchArea(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: GridView.count(
                        crossAxisCount: Responsive.isMobile(context)?1:2,
                        crossAxisSpacing: 10,
                        childAspectRatio: Responsive.isMobile(context)?4:2,
                        children: [
                          searchBox() ,
                          addedItemBox(),
                        ]
                      ),
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
                          style: ButtonStyle(
                            
                          ),
                          onPressed: (){
                        },
                         child: Text("Generate Receipt"))
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
                height:100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                          Expanded(
                            child: TextField(
                              onChanged: controller.startSearch,
                              decoration: InputDecoration(
                                labelText: 'Enter Product Slug',
                                border: OutlineInputBorder(
                                ),
                                suffixIcon: Icon(Icons.search)
                              ),
                            ),
                          ),
                          SizedBox(
                            width:20
                          ),
                    ElevatedButton(
                      child: Container(
                        height:58,
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

  Container addedItemBox() {
    return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                          ),
                          child: 
                          Obx( () => ListView(
                          children: [
                            Container(
                              height:30,
                              color: Colors.green,
                              child:Center(child: Text("Added Items"))
                            ),
                              ...[...controller.addedProducts.map((e) {
                                return itemTile(element:e['product'], isAlreadyAdded: true, valueAdded: e['value']);
                              },
                              )]
                               ],
                                                ),
                        ));

  }

  Container searchBox() {
    return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                          ),
                          child: 
                          Obx( () => ListView(
                          children: [
                            Container(
                              height:30,
                              color: Colors.green,
                              child:Center(child: Text("Items to Add"))
                            ),
                              ...[...controller.results.map((element) {
                                return itemTile(element:element, isAlreadyAdded: false);
                              },
                              )]
                               ],
                                                ),
                        ));
  }

  InkWell itemTile({ProductModel element, bool isAlreadyAdded, int valueAdded}) {
    return InkWell(
                                  onTap:() {
                                    if(!isAlreadyAdded) {
                                      controller.addProduct(element);
                                    }

                                    if(isAlreadyAdded) {
                                      controller.removeProduct(element);
                                    }
                                  },
                                  child: Card(
                                    color:Colors.blue.shade800,
                                    elevation: 5,
                                    child: ListTile(

                                      subtitle:Text('${element.brand}') ,
                                      title: Text('${element.productName}'),

                                      leading: Container(
                                        width:80,
                                        child: Row(children: [
                                         Icon(Icons.price_check),
                                         Text(element.productMaxPrice)
                                        ],),
                                      ),
                                      trailing: Container(
                                        width:40,
                                        child: Row(children: [
                                         !isAlreadyAdded?Icon(Icons.add):Icon(Icons.delete),
                                         if(isAlreadyAdded) Text(valueAdded.toString())
                                        ],),
                                      ),
                                      ),
                                  ),
                                );
  } 
}