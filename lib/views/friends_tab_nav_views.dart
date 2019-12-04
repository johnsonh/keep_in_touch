import 'package:flutter/material.dart';

import 'friends_tab_view.dart';
import 'nav_view.dart';

class FriendsTabNavViewsProvider extends TopLevelNavViewProvider {
  FriendsTabNavViewsProvider(Widget widget, this.onTapAdd, this.start)
      : super(widget);

  final Function onTapAdd;
  final FriendsTabView Function() start;

  @override
  Widget get widget {
    return start();
  }

  @override
  AppBar getAppBar() {
    return AppBar(title: const Text('Friends'), actions: <Widget>[
      IconButton(
          icon: const Icon(Icons.person_add),
          tooltip: 'Add friend',
          onPressed: onTapAdd)
    ]);
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: Icon(Icons.people), title: const Text('Friends'));
  }
}
