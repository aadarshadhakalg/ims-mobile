import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/static/about.dart';
import 'package:inventory_management_system/app/modules/Setting/setting_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<SettingController>(builder: (SettingController controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: Text('Send Login Credentials to Staff Email'),
                value: controller.sendStaffMail.value,
                onChanged: (val) {
                  controller.toggleStaffMail();
                },
              ),
              SwitchListTile(
                title: Text('Send Receipt to Customers Email'),
                value: controller.sendReceiptToEmail.value,
                onChanged: (val) {
                  controller.toggleReceiptEmail();
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              Divider(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.red,
                child: Center(
                  child: Text('About IMS'),
                ),
              ),
              Text('data'),
              Divider(),
              ...member
                  .map(
                    (e) => ListTile(
                      title: Text('${e['name']}'),
                      trailing: IconButton(
                        onPressed: () async {
                          await canLaunch('${e['fb']}')
                              ? await launch('${e['fb']}')
                              : print('Couldnt ');
                        },
                        icon: Icon(Icons.facebook_rounded),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      }),
    );
  }
}
