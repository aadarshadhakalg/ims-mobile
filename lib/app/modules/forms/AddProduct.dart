import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/ProductModel.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:inventory_management_system/routes/pages.dart';
import '../../data/models/CategoryModel.dart';

class AddProduct extends StatelessWidget {
  // const AddCategoryForm({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  var arguments = Get.arguments;



  Future<dynamic> updateData(Map<String,dynamic> d) async {
    try{
      var response = await DioSingleton().instance.put('/product/productdetail/${arguments[1]}'
                  , data: d
          );

      return response;
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> sendData(Map<String,dynamic> d) async {
    try{
      var response = await DioSingleton().instance.post('/product/addproduct/'
                  , data: d
          );

      return response;
    }catch(e){
      print(e);
    }
  }

  Future<ProductModel> fetchProduct() async{
    print(arguments);
    ProductModel product = ProductModel.fromJson(
       {
      "url_slug": "",
      "sub_categories_id": 1,
      "product_name": "",
      "brand": "",
      "product_max_price": "",
      "product_discount_price": "",
      "product_description": "",
      "product_long_description": "",
      "created_at": "2021-07-20T15:02:10.312944Z",
      "total_stock": 0,
      "is_active": 0
    }
    );
if(arguments[0] == 'update'){
    try{
      var response = await DioSingleton().instance.get('/product/productlist/${arguments[1]}/');
      product =  ProductModel.fromJson(response.data['results']);
    }catch(e){
      print(e);
    }
}
   return product;
  }

  Future<List<CategoryModel>> fetchCategory() async{
    List<CategoryModel> categories = [];
    try{
      var response = await DioSingleton().instance.get('/product/categorylist/');
      for(var e in response.data['results']){
        categories.add(new CategoryModel.fromJSON(e));
      }
    }catch(e){
      print(e);
    }
    return categories;
  }
  
  Future<List<CategoryModel>> fetchSubCategory() async{
    List<CategoryModel> subcategories = [];
    try{
      var response = await DioSingleton().instance.get('/product/subcategorylist/');
      for(var e in response.data['results']){
        subcategories.add(new CategoryModel.fromJSON(e));
      }
    }catch(e){
      print(e);
    }
    return subcategories;
  }

  Padding categoryChoiceChip(List<CategoryModel> data,String name) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderChoiceChip(
            name: name,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2)
            ),
            
            options:[ 
                ...data.map((d) {
                return FormBuilderFieldOption(
                    value: d.id, child: Text('${d.title}'));
                })
             ]),
              );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          builder:(context, snap){ 
            if(snap.hasData){
              return form(snap.data);
            }else if(snap.hasError){
              return Center(child: Text("Error fetching category of slug: ${arguments[1]}"));
            }else{
              return Center(child: CircularProgressIndicator());
            }
      },
      future: fetchProduct()
    );
    }
    
      Widget form(ProductModel data) {
        return FormBuilder(
              child: Scaffold(
          appBar: AppBar(
            title: arguments[0] == "add" ?Text("Add Product"): Text("Update Product"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: ListView(
                  children: [
                    Text("Category"),
                    FutureBuilder(builder: (context,dataSnap){
                      if(dataSnap.hasData){
                        return categoryChoiceChip(dataSnap.data,'categories_id');
                      }else if(dataSnap.hasError){
                        return Center(child: Text("Error fetching subcategories list"));
                      }
                      else{
                        return 
                        Center(
                          child: SizedBox(width:80, height:80,
                           child:CircularProgressIndicator()
                           ),
                        );
                      }
                    },
                    future: fetchCategory(),
                    ),
                    Text("Sub Category"),
                    FutureBuilder(builder: (context,dataSnap){
                      if(dataSnap.hasData){
                        return categoryChoiceChip(dataSnap.data,'sub_categories_id');
                      }else if(dataSnap.hasError){
                        return Center(child: Text("Error fetching subcategories list"));
                      }
                      else{
                        return Center(
                          child: SizedBox(width:80, height:80,
                           child:CircularProgressIndicator()
                           ),
                        );
                      }
                    },
                    future: fetchSubCategory(),
                    ),
                    InputText(name:'product_name',title:'Product Name',value:data.productName),
                    InputText(name:'url_slug',title:'Barcode Scanned Value',value:data.urlSlug),
                    InputText(name:'brand',title:'Brand',value:data.brand),
                    InputText(name:'product_max_price',title:'Product Price',value:data.productMaxPrice),
                    InputText(name:'product_discount_price',title:'Product Discount Price',value:data.productDiscountPrice),
                    InputText(name:'product_description',title:'Product Description',value:data.productDescription),
                    InputText(name:'product_long_description',title:'Product Long Description',value:data.productLongDescription),
                    InputText(name:'total_stock',title:'Total stock',value:data.totalStock.toString()),
                    FormBuilderSwitch(name: 'is_active', initialValue: (data.isActive == 1) ? true: false , title: Text("Make it active?",
                      style: TextStyle(
                          fontSize: 30
                      ),)),
                    TextButton(onPressed: () async{
                      _formKey.currentState.save();
                      Map<String,dynamic> formData = {..._formKey.currentState.value};
                      formData['is_active'] = formData['is_active'] == true? 1: 0;
                      print(formData);
                      var response;
                      if(arguments[0] == "add"){
                        response = await sendData(formData);
                      }else if(arguments[0] == "update") {
                        response = await updateData(formData);
                      }
                    if(response != null){
                        Get.toNamed(Routes.DASHBOARD); 
                    }
                    },child: Text("Submit", style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),),style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),),
                  ],
                ),
              ),
            ),
          ),
      ),
        );
      }
    
    
      Padding InputText({String name,String title,String value}) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: FormBuilderTextField(name: name,
            initialValue: value,
            decoration: InputDecoration(
                labelText: title,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),),
          ),
        );
      }
    
}