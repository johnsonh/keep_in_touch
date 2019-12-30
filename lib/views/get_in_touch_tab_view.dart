import 'package:flutter/material.dart';
import '../domain/friend.dart';

class GetInTouchTabView extends StatelessWidget {
  const GetInTouchTabView(
      this.friends,
      this.didTapSMS,
      this.didTapMessenger,
      this.didTapWhatsapp,
      this.didTapSlack,
      this.didTapWeChat,
      this.didTapLinkedin);

  final Future<List<Friend>> friends;
  final Function(int phoneNumber) didTapSMS;
  final Function didTapMessenger;
  final Function didTapWhatsapp;
  final Function didTapSlack;
  final Function didTapWeChat;
  final Function didTapLinkedin;

  @override
  Widget build(BuildContext context) {
    return buildFriendView(friends);
  }

  Widget buildFriendView(Future<List<Friend>> friendsFuture) {
    return FutureBuilder<List<Friend>>(
      builder: (BuildContext context, AsyncSnapshot<List<Friend>> friendsSnapshot) {
        if (friendsSnapshot.connectionState == ConnectionState.none &&
            friendsSnapshot.hasData == null) {
          return Container();
        }

        if (friendsSnapshot.data == null || friendsSnapshot.data.isEmpty) {
          return Container();
        }
        return ContactFriendView(
            friendsSnapshot.data[0],
            didTapSMS,
            didTapMessenger,
            didTapWhatsapp,
            didTapSlack,
            didTapWeChat,
            didTapLinkedin);
      },
      future: friendsFuture,
    );
  }
}

class ContactFriendView extends StatelessWidget {
  const ContactFriendView(
      this.friend,
      this.didTapSMS,
      this.didTapMessenger,
      this.didTapWhatsapp,
      this.didTapSlack,
      this.didTapWeChat,
      this.didTapLinkedin);

  final Friend friend;
  final Function(int phoneNumber) didTapSMS;
  final Function didTapMessenger;
  final Function didTapWhatsapp;
  final Function didTapSlack;
  final Function didTapWeChat;
  final Function didTapLinkedin;

  static String messageOption1 = 'Hey!! It\'s been a while, how\'ve you been?';
  static String messageOption2 = 'Hello, how have you been';
  static String messageOption3 = 'Hey! How\'s life?';
  static String messageOption4 = 'Ahoy, how goes it';
  static String messageOption5 = 'How is life my dude';
  static String messageOption6 = 'Hey! Sorry I never responded. How\'ve you been?';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SelectableText(friend.name, style: const TextStyle(fontSize: 30)),
        // SelectableText(friend.email, style: TextStyle(fontSize: 30)),
        // SelectableText(friend.phoneNumber.toString(), style: TextStyle(fontSize: 30)),
        const SizedBox(height: 100),
        // couldn't do - IG, hangouts,
        RaisedButton(
          onPressed: () {
            didTapSMS(friend.phoneNumber);
            return;
          },
          child: const Text('Send SMS (if phone # exists)'),
        ),
        RaisedButton(
          onPressed: didTapWeChat,
          child: const Text('Open WeChat'),
        ),
        RaisedButton(
          onPressed: didTapSlack,
          child: const Text('Open Slack'),
        ),
        RaisedButton(
          onPressed: didTapLinkedin,
          child: const Text('Open Linkedin'),
        ),
        RaisedButton(
          onPressed: didTapMessenger,
          child: const Text('Open Messenger'),
        ),
        RaisedButton(
          onPressed: didTapWhatsapp,
          child: const Text('Open Whatsapp'),
        ),
        SelectableText(messageOption1, style: const TextStyle(fontSize: 18)),
        SelectableText(messageOption2, style: const TextStyle(fontSize: 18)),
        SelectableText(messageOption3, style: const TextStyle(fontSize: 18)),
        SelectableText(messageOption4, style: const TextStyle(fontSize: 18)),
        SelectableText(messageOption5, style: const TextStyle(fontSize: 18)),
        SelectableText(messageOption6, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
