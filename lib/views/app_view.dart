import 'package:flutter/material.dart';

import '../services/url_navigator.dart';
import 'nav_view.dart';

class AppView extends StatefulWidget {
  const AppView(this._tabs, this.navigator);

  final List<TopLevelFlow> _tabs;
  final URLNavigator navigator;

  @override
  AppViewState createState() => AppViewState(_tabs[0]);
}

class AppViewState extends State<AppView> {
  AppViewState(this.currentTab);

  TopLevelFlow currentTab;

  @override
  Widget build(BuildContext context) {
    final Function(int index) onSwitchTabs = (int index) {
      setState(() {
        currentTab = widget._tabs[index];
      });
    };

    return MaterialApp(
        title: 'Flutter Intro App',
        home: Scaffold(
          appBar: currentTab.provideTopLevelNavViews().getAppBar(),
          body: currentTab.provideTopLevelNavViews().widget,
          bottomNavigationBar:
              NavView(widget._tabs, widget.navigator, onSwitchTabs),
        ));
  }
}
