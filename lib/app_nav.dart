import 'package:flutter/material.dart';

import 'services/url_navigator.dart';

class AppNav extends URLNavigator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> navigateTo(String routeName) {
    final BottomNavigationBar navigationBar = navigatorKey.currentWidget;
    navigationBar.onTap(_routes[routeName]); // first section of route name
    return null;
  }

  final Map<String, int> _routes = <String, int>{};

  void addRoute(String key, int value) {
    _routes.putIfAbsent(key, () => value);

    // complex navigation logic beyond the top level tab should have data/handling registered here per module
    // and then handled above in navigateTo
  }

  Future<void> onSelectNotification(String payload) async {
    print(payload);
    navigateTo(payload);
  }
}
