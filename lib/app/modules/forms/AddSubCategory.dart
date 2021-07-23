import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:inventory_management_system/core/utils/dio/dio_base.dart';
import '../../data/models/CategoryModel.dart';
import 'package:get/get.dart';


class AddSubCategoryForm extends StatelessWidget {
  // const AddCategoryForm({Key key}) : super(key: key);


  Future<dynamic> sendData(Map<String,dynamic> d) async {
    try{
      var response = await DioSingleton().instance.post('/product/addsubcategory/'
                  , data: d
          );

      return response;
    }catch(e){
      print(e);
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
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
   

  @override
  Widget build(BuildContext context) {
    fetchCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Sub-Categories"),
      ),
      body: form(),
    );
  }

 Widget form() {
    return FutureBuilder(
          builder:(context,snap){
            if(!snap.hasData){
              return SafeArea(child: 
                Center(child: 
                SizedBox(child: CircularProgressIndicator(),width:80, height:80)
                )
              );
            }else if(snap.hasError){
              return SafeArea(child: 
                Center(child: 
                Text("No internet Connection. Couldn't make request")
                )
              );
            }
            else{
         return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              children: [
                categoryChoiceChip(snap.data),
                inputText(name:'title',title:'Sub Category Name'),
                inputText(name:'description',title:'Category Description'),
                inputText(name:'url_slug',title:'Category Slug'),
                FormBuilderSwitch(name: 'is_active', initialValue: false, title: Text("Make it active?",
                  style: TextStyle(
                      fontSize: 30
                  ),)),
                TextButton(onPressed: () async{
                  _formKey.currentState.save();

                  Map<String,dynamic> formData = {..._formKey.currentState.value};
                  formData['is_active'] = formData['is_active'] == true? 1: 0;
                  print(formData);
                var response = await sendData(formData);
                if(response != null){
                  Get.back();
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
      );
            }
          },
          future: fetchCategory(),
    );
  }

  Padding categoryChoiceChip(List<CategoryModel> data) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderChoiceChip(
            name: 'category_id',
            decoration: InputDecoration(
                labelText: 'Select many options',
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

  Padding inputText({String name,String title}) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: FormBuilderTextField(name: name,decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),),
      ),
    );
  }
}
