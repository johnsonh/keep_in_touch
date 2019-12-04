
import 'package:flutter/material.dart';

import 'friends_tab_view.dart';
import 'nav_view.dart';

class FriendsTopTabView implements TopLevelTabView {
  final Function onTapAdd; 

  FriendsTopTabView(FriendsTabView friendsTabView, this.onTapAdd) : super(friendsTabView);

  // @override
  // // TODO: implement widget
  // Widget get widget => null;

  @override
  AppBar getAppBar() {
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
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(icon: new Icon(Icons.people), title: new Text('Friends'));
  }
}