
import 'package:flutter/material.dart';

import 'nav_view.dart';

class GetInTouchTabNavViews extends TopLevelNavViews {

  GetInTouchTabNavViews(Widget widget) : super(widget);

  @override
  AppBar getAppBar() {
    return AppBar(title: Text("Get In Touch"));
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: new Icon(Icons.mail), title: new Text('Get In Touch!'));
  }
}