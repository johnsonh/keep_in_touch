import 'package:flutter/material.dart';

abstract class URLNavigator {
  Future<dynamic> navigateTo(String routeName);
}

class NavigationManager extends URLNavigator {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Map<String, WidgetBuilder> _routes = new Map();
  // Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  //   '/friends': (BuildContext context) => friendTabFlow,
  //   '/get_in_touch': (BuildContext context) => getInTouchFlow,
  //   '/settings': (BuildContext context) => settingsFlow,
  // }; 

  addRoute(String key, Widget Function(BuildContext) Function() value) {
    _routes.putIfAbsent(key, value);
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _routes; 
  }

  Future onSelectNotification(String payload) async {
    print(payload);
    navigateTo(payload);

    // var builder = routes[payload];

    // Navigator.pushNamed(context, payload);
  }
}