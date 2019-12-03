import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'friends_context.dart';
import 'friend.dart';
import 'nav_view.dart'; // how to get rid of this

class GetInTouchFlow implements TopLevelTabView {
  final FriendsContext friendsContext;

  GetInTouchFlow(this.friendsContext); // DI

  @override
  AppBar getAppBar() {
    return AppBar(title: Text("Get In Touch"));
  }

  @override
  Widget start() {
    Future<List<Friend>> friends = friendsContext.getRandomFriends();
    return buildFriendView(friends);
  }

  Widget buildFriendView(Future<List<Friend>> friendsFuture) {
    return FutureBuilder(
      builder: (context, friendsSnapshot) {
        if (friendsSnapshot.connectionState == ConnectionState.none &&
            friendsSnapshot.hasData == null) {
          return Container();
        }

        if (friendsSnapshot.data == null) return Container(); 
        return ContactFriendView(friendsSnapshot.data[0]);
      },
      future: friendsFuture,
    ); 
  }

  Widget start2(Friend friend) {
    return ContactFriendView(friend);
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: new Icon(Icons.mail), title: new Text('Get In Touch!'));
  }
}

class ContactFriendView extends StatelessWidget {
  final Friend friend;
  final messageOption1 = "Hey!! It's been a while, how've you been?";
  final messageOption2 = "Hello, how have you been";
  final messageOption3 = "Hey! How's life?";
  final messageOption4 = "Ahoy, how goes it";
  final messageOption5 = "How is life my dude";
  final messageOption6 = "Hey! Sorry I never responded. How've you been?";
  
  const ContactFriendView(this.friend);

  @override
  Widget build(BuildContext context) {    
    return Column(
      children: <Widget>[
        SelectableText(friend.name, style: TextStyle(fontSize: 30)),
        // SelectableText(friend.email, style: TextStyle(fontSize: 30)),
        // SelectableText(friend.phoneNumber.toString(), style: TextStyle(fontSize: 30)),
        SizedBox(height: 100),
        // couldn't do - IG, hangouts, 
        RaisedButton(
          onPressed: _launchSMS,
          child: Text('Send SMS (if phone # exists)'),
        ),
        RaisedButton(
          onPressed: _launchWeChat,
          child: Text('Open WeChat'),
        ),
        RaisedButton(
          onPressed: _launchSlack,
          child: Text('Open Slack'),
        ),
        RaisedButton(
          onPressed: _launchLinkedin,
          child: Text('Open Linkedin'),
        ),
        RaisedButton(
          onPressed: _launchFBMessenger,
          child: Text('Open Messenger'),
        ),
        RaisedButton(
          onPressed: _launchWhatsapp,
          child: Text('Open Whatsapp'),
        ),
        SelectableText(messageOption1, style: TextStyle(fontSize: 18)),
        SelectableText(messageOption2, style: TextStyle(fontSize: 18)),
        SelectableText(messageOption3, style: TextStyle(fontSize: 18)),
        SelectableText(messageOption4, style: TextStyle(fontSize: 18)),
        SelectableText(messageOption5, style: TextStyle(fontSize: 18)),
        SelectableText(messageOption6, style: TextStyle(fontSize: 18)),
      ],
    );
  }

  _launchSMS()  async {
    String phoneAsString = friend.phoneNumber.toString();
    if (!_isValidPhoneNumber(phoneAsString)) return; 

    var url = 'sms:' + phoneAsString;
    _launch(url);
  }

  bool _isValidPhoneNumber(String value) {
    Pattern pattern = '\\A[0-9]{10}\\z';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return true;
    else
      return false;
  }

  _launchFBMessenger() async {
    var url = 'fb-messenger://compose';
    _launch(url);
  }

  _launchWhatsapp() async {
    var url = 'whatsapp://send?text=Hi!';
    _launch(url);
  }

  _launchSlack() async {
    var url = 'slack://';
    _launch(url);
  }

  _launchWeChat() async {
    var url = 'weixin://';
    _launch(url);
  }

  _launchLinkedin() async {
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
