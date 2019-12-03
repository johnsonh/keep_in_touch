import 'package:flutter/material.dart';

import 'friend_tab_flow.dart';
import 'get_in_touch_flow.dart';
import 'nav_view.dart';
import 'navigation_manager.dart';
import 'notification_service.dart';
import 'settings_flow.dart';

class Tab {
  final String title;
  final BottomNavigationBarItem navItem;

  Tab(this.title, this.navItem);
}

class AppFlow {
  final navigationManager;
  final notificationService;
  final friendTabFlow;
  final getInTouchFlow;
  final settingsFlow;

  AppFlow._(this.navigationManager, this.notificationService, this.friendTabFlow, this.getInTouchFlow, this.settingsFlow);

  factory AppFlow() {
    var navigationManager = NavigationManager();
    var notificationService = NotificationService(navigationManager.onSelectNotification);
    var friendTabFlow = FriendTabFlow();
    var getInTouchFlow = GetInTouchFlow();
    var settingsFlow = SettingsFlow(notificationService);
    return new AppFlow._(navigationManager, notificationService, friendTabFlow, getInTouchFlow, settingsFlow);
  }

  Widget start() {
    return MaterialApp(
        title: 'Flutter Intro App1',
        home: AppView([
            friendTabFlow,
            getInTouchFlow,
            settingsFlow
          ])
      );
  }
}

class AppView extends StatefulWidget {
  final List<TopLevelTabView> _tabs;
  const AppView(this._tabs);

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
          body: currentTab.start(), // should be DI'd, to allow for opening from diff tabs
          bottomNavigationBar: NavView(widget._tabs, onSwitchTabs)
        );
  }
}