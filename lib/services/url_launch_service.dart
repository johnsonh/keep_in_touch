import 'package:url_launcher/url_launcher.dart';

class UrlLaunchService {

  bool isValidPhoneNumber(String value) {
    Pattern pattern = "^\d{10}\$";
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(value))
      return true;
    else
      return false;
  }

  launchSMS(int phoneNumber) async {
    String phoneAsString = phoneNumber.toString();
    if (!isValidPhoneNumber(phoneAsString)) {
      print("Not a legit phone number: " + phoneAsString);
      return; 
    }

    var url = 'sms:' + phoneAsString;
    _launch(url);
  }

  launchFBMessenger() async {
    var url = 'fb-messenger://compose';
    _launch(url);
  }

  launchWhatsapp() async {
    var url = 'whatsapp://send?text=Hi!';
    _launch(url);
  }

  launchSlack() async {
    var url = 'slack://';
    _launch(url);
  }

  launchWeChat() async {
    var url = 'weixin://';
    _launch(url);
  }

  launchLinkedin() async {
    var url = 'linkedin://profile';
    _launch(url);
  }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
