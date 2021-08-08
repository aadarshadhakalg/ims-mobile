import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../app/modules/Setting/setting_controller.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Mailer {
  SmtpServer smtpServer;
  Mailer._internal() {
    smtpServer = SmtpServer('mail.aadarshadhakal.com.np',
        name: 'Inventory Management',
        username: 'ims@aadarshadhakal.com.np',
        password: '7mw~LeRIeAhZ');
  }
  static Mailer _instance;
  static Mailer get instance => _instance ??= Mailer._internal();

  Future<void> sendReceipt(String email) async {
    try {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/example.pdf';

      final equivalentMessage = Message()
        ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
        ..recipients.add(Address('$email'))
        ..subject = 'Your Purchase Receipt :: ${DateTime.now()}'
        ..text = 'Thank You For Purchasing At IMS'
        ..attachments = [
          FileAttachment(File(path))
            ..fileName = 'receipt.pdf'
            ..location = Location.inline
            ..cid = '<myimg@3.141>'
        ];
      if (Get.find<SettingController>().sendReceiptToEmail.value) {
        await send(equivalentMessage, smtpServer);
      }
    } catch (e) {
      Get.dialog(AlertDialog(
        title: Text('Email Not Sent'),
        content: Text(
            'Sorry! Email sending feature is not available in web version of IMS!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ));
    }
  }

  Future<void> sendStaffPassword(
      String name, String email, String username, String password) async {
    final equivalentMessage = Message()
      ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
      ..recipients.add(Address('$email'))
      ..subject = 'Welcome to IMS'
      ..text = '''Dear $name,
This is your staff login credentials. Please download our app from this link.          
-> https://github.com/aadarshadhakalg/ims-mobile/releases/download/0.0.2/app-release.apk

Please don't share your credentials with others!
Username: $username \nPassword: $password''';
    if (Get.find<SettingController>().sendStaffMail.value) {
      await send(equivalentMessage, smtpServer);
    }
  }
}
