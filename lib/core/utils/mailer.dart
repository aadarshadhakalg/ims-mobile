import 'dart:io';

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
    final equivalentMessage = Message()
      ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
      ..recipients.add(Address('$email'))
      ..subject = 'Your Purchase Receipt :: ${DateTime.now()}'
      ..text = 'Thank You For Purchasing At IMS'
      ..attachments = [
        FileAttachment(File('example.pdf'))
          ..location = Location.inline
          ..cid = '<myimg@3.141>'
      ];
    await send(equivalentMessage, smtpServer);
  }

  Future<void> sendStaffPassword(String email, String password) async {
    final equivalentMessage = Message()
      ..from = Address('ims@aadarshadhakal.com.np', 'IMS')
      ..recipients.add(Address('$email'))
      ..subject = 'Your Credentials'
      ..text = 'Username: $email \nPassword: $password';
    await send(equivalentMessage, smtpServer);
  }
}
