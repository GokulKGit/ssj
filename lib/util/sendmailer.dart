import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

sendMail({subject, userMail}) async {
  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = 'srishanmugajewellery23@gmail.com';
  String password = 'aloi bjpq alsv dzxg';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Sri Shanmuga Jewellery!')
    ..recipients.add(userMail.toString())
    ..ccRecipients.addAll([userMail])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = '$subject'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = """<h1>Welcome To Sri Shanmuga Jewellery!</h1>
        \n<p>Hey! have a nice day!!!</p><img src="https://www.srishanmugajewellery.com/wp-content/uploads/2023/07/NS-_-PNG-1.png" height="100"/>""";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

sendSchemeMail({subject, userMail, userName, schemeName, amount}) async {
  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = 'srishanmugajewellery23@gmail.com';
  String password = 'aloi bjpq alsv dzxg';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Sri Shanmuga Jewellery!')
    ..recipients.add(userMail.toString())
    ..ccRecipients.addAll([userMail])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = '$subject'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = """<h1>New Gold Scheme Added Successfully</h1>
        \n<p>User Name     : $userName </p>
        \n<p>Scheme Name   : $schemeName</p>
        \n<p>Scheme Amount : $amount</p>
        \n<p>Date          : ${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}</p>
        \n<p>Thank You!!!</p>
        <img src="https://www.srishanmugajewellery.com/wp-content/uploads/2023/07/NS-_-PNG-1.png" height="100"/>""";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
