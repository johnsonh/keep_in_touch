

import 'package:flutter/material.dart';

import 'nav_view.dart';

class SettingsTabNavViewsProvider extends TopLevelNavViewProvider {
  SettingsTabNavViewsProvider(Widget widget) : super(widget);

  @override
  AppBar getAppBar() {
    return AppBar(title: Text("Settings"));
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: Icon(Icons.settings), title: Text('Settings'));
  }
}