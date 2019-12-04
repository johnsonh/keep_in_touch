import 'dart:async';

import 'package:flutter/material.dart';
import '../domain/friend.dart';
import '../services/navigation_manager.dart';
import 'friends_list_view.dart';

class FriendsTabView extends StatelessWidget {
  final StreamController<Friend> _controller = StreamController<Friend>.broadcast();
  final URLNavigator navigator;

  FriendsTabView(this.navigator);

  @override
  Widget build(BuildContext context) {
    var friendsListView = FriendsListView(friendStream: _controller.stream);

    var bottomRightFAB = Container(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.shuffle),
          label: Text("NoOp - Press 'Get in Touch!' Below", textScaleFactor: 1.2),
          onPressed: () {
            print("Choose random friends");
            navigator.navigateTo('/get_in_touch');
          }
        ),
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(25)
      );

    return Stack(children: <Widget>[friendsListView, bottomRightFAB]);
  }

  addFriend(Friend friend) {
    _controller.add(friend);
  }
}
