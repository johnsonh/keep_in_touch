import 'package:flutter/material.dart';

import 'nav_view.dart';
import '../services/navigation_manager.dart';

class AppView extends StatefulWidget {
  final List<TopLevelTabView> _tabs;
  final NavigationManager navigationManager; 
  const AppView(this._tabs, this.navigationManager);

  @override
  AppViewState createState() => AppViewState(_tabs[0]);
}

class AppViewState extends State<AppView> {
  TopLevelTabView currentTab;

  AppViewState(this.currentTab);

  @override
  Widget build(BuildContext context) {
    Function(int index) onSwitchTabs = (int index) {
      setState(() {
        currentTab = widget._tabs[index];
      });
    };

    return Scaffold(
      appBar: currentTab.getAppBar(),
      body: currentTab.start(),
      bottomNavigationBar: NavView(widget._tabs, widget.navigationManager, onSwitchTabs),
    );
  }
}