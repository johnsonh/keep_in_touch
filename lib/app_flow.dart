import 'package:flutter/material.dart';
import 'package:keep_in_touch/friends_context.dart';

import 'friend_tab_flow.dart';
import 'friends_client.dart';
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
  final NavigationManager navigationManager;
  final NotificationService notificationService;
  final FriendTabFlow friendTabFlow;
  final GetInTouchFlow getInTouchFlow;
  final SettingsFlow settingsFlow;

  final FriendsClient friendsClient;
  final FriendsContext friendsContext; 

  AppFlow._(this.navigationManager, this.notificationService, this.friendTabFlow, this.getInTouchFlow, this.settingsFlow, this.friendsClient, this.friendsContext);

  // This should be replaced with DI
  factory AppFlow() {
    var navigationManager = NavigationManager();
    var notificationService = NotificationService(navigationManager.onSelectNotification);

    var friendsClient = FriendsClient();
    friendsClient.database; 
    var friendsContext = FriendsContext(friendsClient);

    var friendTabFlow = FriendTabFlow(navigationManager, friendsContext);
    var getInTouchFlow = GetInTouchFlow(friendsContext);
    var settingsFlow = SettingsFlow(notificationService);
    return new AppFlow._(navigationManager, notificationService, friendTabFlow, getInTouchFlow, settingsFlow, friendsClient, friendsContext);
  }

  Widget start() {
    navigationManager.addRoute('/friends', 0);
    navigationManager.addRoute('/get_in_touch', 1);
    navigationManager.addRoute('/settings', 2);

    return MaterialApp(
        title: 'Flutter Intro App',
        home: AppView([
          friendTabFlow,
          getInTouchFlow,
          settingsFlow
        ], navigationManager),
        // routes: navigationManager.getRoutes(),
      );
  }
}

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
      body: currentTab.start(), // should be DI'd, to allow for opening from diff tabs
      bottomNavigationBar: NavView(widget._tabs, widget.navigationManager, onSwitchTabs),
    );
  }
}