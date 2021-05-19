import 'package:inventory_management_system/app/modules/LoginPage/controller.dart';
import 'package:inventory_management_system/core/values/ui_constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
class LoginPage extends GetView<LoginPageController> {
  var controller = Get.put(LoginPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body : SafeArea(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                         Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgT5LXSUO0XbAj3fV9y6jHe1xPCNe38B0wd8eU4KLbF2-LnZwb-yBRkuWjS38j2vz-NTU&usqp=CAU')),
                         LoginField(onChange: this.controller.onUsernameChanged, 
                         icon: Icons.person,
                         obscure: false,
                         label: 'Username',
                         ),
                         LoginField(onChange: this.controller.onPasswordChanged, 
                         icon: Icons.password_rounded,
                         obscure: true,
                         label: 'Password',
                         ),
                         TextButton(onPressed:this.controller.onSubmitPress ,
                          child: Text('Submit'))
                    ]
                  ) 
            ),
       )
    );
  }

}

class LoginField extends StatelessWidget {
  const LoginField({
    Key key,
    @required this.onChange, this.icon, this.label, this.obscure,
  }) : super(key: key);

  final IconData icon; 
  final String label;
  final Function(String) onChange;
  final bool obscure;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UIConstants.defaultPadding),
       child: TextField(
       onChanged: onChange,
       obscureText: obscure,
       decoration: InputDecoration(
         labelText: label,
         icon: Icon(icon),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(20)
         ) 
       ),
                        ),
    );
  }
}