import 'dart:io';

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
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/example.pdf';

    final equivalentMessage = Message()
      ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
      ..recipients.add(Address('$email'))
      ..subject = 'Your Purchase Receipt :: ${DateTime.now()}'
      ..text = 'Thank You For Purchasing At IMS'
      ..attachments = [
        FileAttachment(File(path))
          ..location = Location.inline
          ..cid = '<myimg@3.141>'
      ];
    if (Get.find<SettingController>().sendReceiptToEmail.value) {
      await send(equivalentMessage, smtpServer);
    }
  }

  Future<void> sendStaffPassword(String email, String password) async {
    final equivalentMessage = Message()
      ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
      ..recipients.add(Address('$email'))
      ..subject = 'Your Credentials'
      ..text = 'Username: $email \nPassword: $password';
    if (Get.find<SettingController>().sendStaffMail.value) {
      await send(equivalentMessage, smtpServer);
    }
  }
}
