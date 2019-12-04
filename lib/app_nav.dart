import 'package:flutter/material.dart';

import 'services/url_navigator.dart';

class AppNav extends URLNavigator {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    final BottomNavigationBar navigationBar = navigatorKey.currentWidget;
    navigationBar.onTap(_routes[routeName]); // first section of route name
    return null; 
  }

  Map<String, int> _routes = new Map();
  addRoute(String key, int value) {
    _routes.putIfAbsent(key, () => value);

    // complex navigation logic beyond the top level tab should have data/handling registered here per module
    // and then handled above in navigateTo
  }

  Future onSelectNotification(String payload) async {
    print(payload);
    navigateTo(payload);
  }
}