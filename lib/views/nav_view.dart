import 'package:flutter/material.dart';

import '../app_nav.dart';

abstract class TopLevelFlow {
  TopLevelNavViews getTopLevelNavViews();
}

// Each top level flow owns its app bar, body, and individual tab item
abstract class TopLevelNavViews {
  final Widget widget;
  AppBar getAppBar();
  BottomNavigationBarItem getNavItem();

  TopLevelNavViews(this.widget);
}

class NavView extends StatefulWidget {
  final List<TopLevelFlow> _tabs;
  final AppNav appNav; 
  final Function(int index) onSwitchTabs;
  const NavView(this._tabs, this.appNav, this.onSwitchTabs);

  @override
  NavViewState createState() => NavViewState();
}

class NavViewState extends State<NavView> {
  var _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    Function(int index) onTap = (index) {
      setState(() {
        _currentTabIndex = index;
        widget.onSwitchTabs(index);
      });
    };

    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: _currentTabIndex,
      // should be providers?
      items: widget._tabs.map((tab) => tab.getTopLevelNavViews().getNavItem()).toList(),
      key: widget.appNav.navigatorKey,
    );
  }
}