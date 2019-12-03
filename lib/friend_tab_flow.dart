import 'package:flutter/material.dart'; // how to get rid of this

import 'nav_view.dart';
import 'friend_tab_view.dart';
import 'friend_context.dart';

class FriendTabFlow implements TopLevelTabView {
  final friendsListView = FriendTabView();
  final friendsContext = FriendsContext();

  @override
  AppBar getAppBar() {
    Function onTapAdd = () { 
      friendsListView.addFriend("Jessica Siefkes");
      print("add a friend"); 
    }; // analytics could be here 

    return AppBar(
      title: const Text("Friends"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person_add),
          tooltip: 'Add friend',
          onPressed: onTapAdd
        )
      ]
    );
  }

  @override
  Widget start() {
    var friends = friendsContext.getAllFriends(); 
    friends.forEach((f) => friendsListView.addFriend(f.name));

    var bottomLeftFAB = Container(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.shuffle),
          label: Text("NoOp - Press 'Get in Touch!' Below", textScaleFactor: 1.2),
          onPressed: () {
            print("Choose random friends");
          }
        ),
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(25)
      );

    return Stack(children: <Widget>[friendsListView, bottomLeftFAB]);
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(icon: new Icon(Icons.people), title: new Text('Friends'));
  }
}