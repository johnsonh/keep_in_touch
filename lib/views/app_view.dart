import 'package:flutter/material.dart';

import 'nav_view.dart';
import '../services/navigation_manager.dart';

class AppView extends StatefulWidget {
  final List<TopLevelFlow> _tabs;
  final NavigationManager navigationManager;
  const AppView(this._tabs, this.navigationManager);

  @override
  AppViewState createState() => AppViewState(_tabs[0]);
}

class AppViewState extends State<AppView> {
  TopLevelFlow currentTab;

  AppViewState(this.currentTab);

  @override
  Widget build(BuildContext context) {
    Function(int index) onSwitchTabs = (int index) {
      setState(() {
        currentTab = widget._tabs[index];
      });
    };

    return MaterialApp(
        title: 'Flutter Intro App',
        home: Scaffold(
          appBar: currentTab.getView().getAppBar(),
          body: currentTab.getView().getWidget(),
          bottomNavigationBar: NavView(widget._tabs, widget.navigationManager, onSwitchTabs),
        )
      );
  }
}
