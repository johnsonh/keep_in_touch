import 'package:flutter/material.dart';

import 'nav_view.dart';

class FriendsTabNavViews extends TopLevelNavViews {
  final Function onTapAdd; 

  FriendsTabNavViews(Widget widget, this.onTapAdd) : super(widget);

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