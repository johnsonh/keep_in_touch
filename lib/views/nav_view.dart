import 'package:flutter/material.dart';

import '../app_nav.dart';

abstract class TopLevelFlow {
  TopLevelNavViewProvider provideTopLevelNavViews();
}

// Each top level flow owns its app bar, body, and individual tab item
abstract class TopLevelNavViewProvider {
  TopLevelNavViewProvider(this.widget);

  final Widget widget;
  AppBar getAppBar();
  BottomNavigationBarItem getNavItem();
}

class NavView extends StatefulWidget {
  const NavView(this._tabs, this.appNav, this.onSwitchTabs);

  final List<TopLevelFlow> _tabs;
  final AppNav appNav;
  final Function(int index) onSwitchTabs;

  @override
  NavViewState createState() => NavViewState();
}

class NavViewState extends State<NavView> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Function(int index) onTap = (int index) {
      setState(() {
        _currentTabIndex = index;
        widget.onSwitchTabs(index);
      });
    };

    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: _currentTabIndex,
      items: widget._tabs
          .map((TopLevelFlow tab) => tab.provideTopLevelNavViews().getNavItem())
          .toList(),
      key: widget.appNav.navigatorKey,
    );
  }
}
