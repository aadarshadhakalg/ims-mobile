import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DashBoard/ui/responsive.dart';

import '../../../core/values/ui_constants.dart';
import 'controller.dart';

class LoginPage extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<LoginPageController>(
          builder: (controller) {
            if (controller.currentState.value == LoginAuthState.InitialState) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    !Responsive.isMobile(context)
                        ? Expanded(
                            flex: 2,
                            child: Image.asset(
                              'assets/images/inventory.jpg',
                              fit: BoxFit.cover,
                              color: Colors.black,
                              filterQuality: FilterQuality.high,
                              colorBlendMode: BlendMode.color,
                            ),
                          )
                        : Container(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              height: 100,
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/logo.jpg'),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            LoginField(
                              onChange: controller.onUsernameChanged,
                              icon: Icons.person,
                              obscure: false,
                              label: 'Username',
                            ),
                            LoginField(
                              onChange: controller.onPasswordChanged,
                              icon: Icons.circle,
                              obscure: true,
                              label: 'Password',
                            ),
                            TextButton(
                              onPressed: () async {
                                await controller.onSubmitPress();
                              },
                              child: Text('Submit'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    Key key,
    @required this.onChange,
    this.icon,
    this.label,
    this.obscure,
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
