
import 'package:flutter/material.dart';
import 'package:keep_in_touch/views/get_in_touch_tab_view.dart';

import 'nav_view.dart';

class GetInTouchTabNavViewsProvider extends TopLevelNavViewProvider {
  final GetInTouchTabView Function() start;

  GetInTouchTabNavViewsProvider(Widget widget, this.start) : super(widget);

  @override
  get widget {
    return start();
  }

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