import 'package:flutter/material.dart';
import '../domain/friend.dart';

class GetInTouchTabView extends StatelessWidget{
  final Future<List<Friend>> friends;
  final Function(int phoneNumber) didTapSMS;
  final Function didTapMessenger;
  final Function didTapWhatsapp;
  final Function didTapSlack;
  final Function didTapWeChat;
  final Function didTapLinkedin;

  GetInTouchTabView(this.friends, this.didTapSMS, this.didTapMessenger, this.didTapWhatsapp, this.didTapSlack, this.didTapWeChat, this.didTapLinkedin);

  @override
  Widget build(BuildContext context) {
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
        return ContactFriendView(friendsSnapshot.data[0], didTapSMS, didTapMessenger, didTapWhatsapp, didTapSlack, didTapWeChat, didTapLinkedin);
      },
      future: friendsFuture,
    ); 
  }
}

class ContactFriendView extends StatelessWidget {
  final Friend friend;
  final Function(int phoneNumber) didTapSMS;
  final Function didTapMessenger;
  final Function didTapWhatsapp;
  final Function didTapSlack;
  final Function didTapWeChat;
  final Function didTapLinkedin;

  final messageOption1 = "Hey!! It's been a while, how've you been?";
  final messageOption2 = "Hello, how have you been";
  final messageOption3 = "Hey! How's life?";
  final messageOption4 = "Ahoy, how goes it";
  final messageOption5 = "How is life my dude";
  final messageOption6 = "Hey! Sorry I never responded. How've you been?";
  
  const ContactFriendView(this.friend, this.didTapSMS, this.didTapMessenger, this.didTapWhatsapp, this.didTapSlack, this.didTapWeChat, this.didTapLinkedin);

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
          onPressed: () { 
            didTapSMS(friend.phoneNumber); 
            return;  
          },
          child: Text('Send SMS (if phone # exists)'),
        ),
        RaisedButton(
          onPressed: didTapWeChat,
          child: Text('Open WeChat'),
        ),
        RaisedButton(
          onPressed: didTapSlack,
          child: Text('Open Slack'),
        ),
        RaisedButton(
          onPressed: didTapLinkedin,
          child: Text('Open Linkedin'),
        ),
        RaisedButton(
          onPressed: didTapMessenger,
          child: Text('Open Messenger'),
        ),
        RaisedButton(
          onPressed: didTapWhatsapp,
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
}
