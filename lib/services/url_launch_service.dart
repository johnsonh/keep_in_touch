import 'package:url_launcher/url_launcher.dart';

class UrlLaunchService {
  bool isValidPhoneNumber(String value) {
    const Pattern pattern = '^\d{10}\$';
    final RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value))
      return true;
    else
      return false;
  }

  Future<void> launchSMS(int phoneNumber) async {
    final String phoneAsString = phoneNumber.toString();
    if (!isValidPhoneNumber(phoneAsString)) {
      print('Not a legit phone number: ' + phoneAsString);
      return;
    }

    final String url = 'sms:' + phoneAsString;
    _launch(url);
  }

  Future<void> launchFBMessenger() async {
    const String url = 'fb-messenger://compose';
    _launch(url);
  }

  Future<void> launchWhatsapp() async {
    const String url = 'whatsapp://send?text=Hi!';
    _launch(url);
  }

  Future<void> launchSlack() async {
    const String url = 'slack://';
    _launch(url);
  }

  Future<void> launchWeChat() async {
    const String url = 'weixin://';
    _launch(url);
  }

  Future<void> launchLinkedin() async {
    const String url = 'linkedin://profile';
    _launch(url);
  }

  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
