import 'package:flutter/material.dart'; // how to get rid of this

import 'friend.dart';
import 'nav_view.dart';
import 'friend_tab_view.dart';
import 'friends_context.dart';
import 'navigation_manager.dart'; // URLManager we out here

class FriendTabFlow implements TopLevelTabView {
  final URLNavigator navigator; 
  final FriendsContext friendsContext;

  final FriendTabView friendsListView = FriendTabView();

  FriendTabFlow(this.navigator, this.friendsContext);

  @override
  AppBar getAppBar() {
    Function onTapAdd = () {
      final friend = Friend('Greenpeace', null, null);
      friendsContext.saveFriend(friend);
      friendsListView.addFriend(friend);
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
    var friendsFuture = friendsContext.getAllFriends();

    var bottomRightFAB = Container(
        child: FloatingActionButton.extended(
          icon: Icon(Icons.shuffle),
          label: Text("NoOp - Press 'Get in Touch!' Below", textScaleFactor: 1.2),
          onPressed: () {
            print("Choose random friends");
            // navigator.navigateTo('/get_in_touch');
          }
        ),
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(25)
      );

    return Stack(children: <Widget>[friendsListView.populate(friendsFuture), bottomRightFAB]);
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(icon: new Icon(Icons.people), title: new Text('Friends'));
  }
}