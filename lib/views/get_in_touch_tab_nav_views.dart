import 'package:flutter/material.dart';
import 'package:keep_in_touch/views/get_in_touch_tab_view.dart';

import 'nav_view.dart';

class GetInTouchTabNavViewsProvider extends TopLevelNavViewProvider {
  GetInTouchTabNavViewsProvider(Widget widget, this.start) : super(widget);

  final GetInTouchTabView Function() start;

  @override
  Widget get widget {
    return start();
  }

  @override
  AppBar getAppBar() {
    return AppBar(title: const Text('Get In Touch'));
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: Icon(Icons.mail), title: const Text('Get In Touch!'));
  }
}
