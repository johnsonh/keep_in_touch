import 'package:flutter/material.dart';

import 'nav_view.dart';
import '../services/url_navigator.dart';

class AppView extends StatefulWidget {
  final List<TopLevelFlow> _tabs;
  final URLNavigator navigator;
  const AppView(this._tabs, this.navigator);

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
          appBar: currentTab.provideTopLevelNavViews().getAppBar(),
          body: currentTab.provideTopLevelNavViews().widget,
          bottomNavigationBar: NavView(widget._tabs, widget.navigator, onSwitchTabs),
        )
      );
  }
}
