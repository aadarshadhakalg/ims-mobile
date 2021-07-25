import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:inventory_management_system/app/data/models/CategoryModel.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/routes/pages.dart';

class AddCategoryForm extends StatelessWidget {

  // const AddCategoryForm({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();
  var arguments = Get.arguments;

  Future<CategoryModel> fetchCategory() async{
    CategoryModel category = CategoryModel.fromJSON({
       "id": 1,
      "title": "",
      "url_slug": "",
      "description": "",
      "is_active": 0
    });
      if(arguments[0] == "update"){
      try{
        var response = await DioSingleton().instance.get('/product/categorydetail/${arguments[1]}');
          category = new CategoryModel.fromJSON(response.data);
      }catch(e){
        print(e);
      }
    }
    return category;
  }

  Future<dynamic> updateData(Map<String,dynamic> d) async {
    try{
      var response = await DioSingleton().instance.put('/product/categoryupdate/${arguments[1]}/'
                  , data: d
          );

      return response;
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> sendData(Map<String,dynamic> d) async {
    try{
      var response = await DioSingleton().instance.post('/product/addcategory/'
                  , data: d
          );

      return response;
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return FutureBuilder(
          builder:(context, snap){ 
            
            if(snap.hasData){
          return Scaffold(
        appBar: AppBar(
          title: arguments[0] == "add" ? Text("Add Categories"): Text("Update Categories"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: ListView(
                children: [
                  InputText(name:'title',title:'Category Name',value:snap.data.title),
                  InputText(name:'description',title:'Category Description',value:snap.data.description),
                  InputText(name:'url_slug',title:'Category Slug',value:snap.data.urlSlug),
                  FormBuilderSwitch(name: 'is_active', initialValue:snap.data.isActive == 1? true: false, title: Text("Make it active?",
                  style: TextStyle(
                    fontSize: 30
                  ),)),
                  TextButton(onPressed: () async{
                    _formKey.currentState.save();
                     Map<String,dynamic> postData = {..._formKey.currentState.value};
                     postData['is_active'] = postData['is_active'] == true? 1: 0;
                     print(postData);
                    // print(_formKey.currentState.value);
                    var response;
                    if(arguments[0] == "add"){
                       response = await sendData(postData);
                    }else{
                      response = await updateData(postData);
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
      );
            }else if(snap.hasError){
              return Center(child: Text("Error fetching category of slug: ${arguments[1]}"));
            }else{
              return Center(child: CircularProgressIndicator());
            }
      },
      future: fetchCategory()
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
