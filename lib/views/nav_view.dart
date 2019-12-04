import 'package:flutter/material.dart';

import '../services/navigation_manager.dart';

abstract class TopLevelFlow {
  TopLevelTabView getView();
}

abstract class TopLevelTabView {
  AppBar getAppBar();

  Widget getWidget();

  BottomNavigationBarItem getNavItem();
}

class NavView extends StatefulWidget {
  final List<TopLevelFlow> _tabs;
  final NavigationManager navigationManager; 
  final Function(int index) onSwitchTabs;
  const NavView(this._tabs, this.navigationManager, this.onSwitchTabs);

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
      items: widget._tabs.map((tab) => tab.getView().getNavItem()).toList(),
      key: widget.navigationManager.navigatorKey,
    );
  }
}
