import 'dart:async';

import 'package:flutter/material.dart';
import '../domain/friend.dart';
import 'friends_list_view.dart';

class FriendsTabView extends StatelessWidget {
  FriendsTabView(this.onPressFAB);

  final StreamController<Friend> _controller =
      StreamController<Friend>.broadcast();
  final Function onPressFAB;

  @override
  Widget build(BuildContext context) {
    final FriendsListView friendsListView = FriendsListView(friendStream: _controller.stream);

    final Container bottomRightFAB = Container(
        child: FloatingActionButton.extended(
            icon: Icon(Icons.shuffle),
            label: const Text('NoOp - Press "Get in Touch!" Below', textScaleFactor: 1.2),
            onPressed: onPressFAB
          ),
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(25));

    return Stack(children: <Widget>[friendsListView, bottomRightFAB]);
  }

  void addFriend(Friend friend) {
    _controller.add(friend);
  }
}
