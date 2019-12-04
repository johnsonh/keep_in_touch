import 'package:flutter/material.dart';

// TODO: Change all references of NavigationManager to URLNavigator wherever possible
abstract class URLNavigator {
  Future<dynamic> navigateTo(String routeName);
}

class NavigationManager extends URLNavigator {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    final BottomNavigationBar navigationBar = navigatorKey.currentWidget;
    navigationBar.onTap(_routes[routeName]); // first section of route name
    return null; 
  }

  Map<String, int> _routes = new Map();
  addRoute(String key, int value) {
    _routes.putIfAbsent(key, () => value);
  }

  Future onSelectNotification(String payload) async {
    print(payload);
    navigateTo(payload);

    // var builder = routes[payload];

    // Navigator.pushNamed(context, payload);
  }
}