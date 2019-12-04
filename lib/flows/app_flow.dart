import 'package:keep_in_touch/services/url_launch_service.dart';

import '../app_nav.dart';
import '../domain/friends_client.dart';
import '../domain/friends_context.dart';
import '../services/notification_service.dart';
import '../views/app_view.dart';
import '../views/nav_view.dart';

import 'friend_tab_flow.dart';
import 'get_in_touch_flow.dart';
import 'settings_tab_flow.dart';

class AppFlow {
  // This should be replaced with DI
  factory AppFlow() {
    final AppNav appNav = AppNav();
    final NotificationService notificationService = NotificationService(appNav.onSelectNotification);
    final UrlLaunchService urlLaunchService = UrlLaunchService();

    final FriendsClient friendsClient = FriendsClient();
    final FriendsContext friendsContext = FriendsContext(friendsClient);

    final FriendTabFlow friendTabFlow = FriendTabFlow(appNav, friendsContext);
    final GetInTouchFlow getInTouchFlow = GetInTouchFlow(friendsContext, urlLaunchService);
    final SettingsTabFlow settingsFlow = SettingsTabFlow(notificationService);
    return AppFlow._(
        appNav,
        notificationService,
        urlLaunchService,
        friendTabFlow,
        getInTouchFlow,
        settingsFlow,
        friendsClient,
        friendsContext);
  }

  AppFlow._(
      this.appNav,
      this.notificationService,
      this.urlLaunchService,
      this.friendTabFlow,
      this.getInTouchFlow,
      this.settingsFlow,
      this.friendsClient,
      this.friendsContext);

  final AppNav appNav;
  final NotificationService notificationService;
  final UrlLaunchService urlLaunchService;

  final FriendTabFlow friendTabFlow;
  final GetInTouchFlow getInTouchFlow;
  final SettingsTabFlow settingsFlow;

  final FriendsClient friendsClient;
  final FriendsContext friendsContext;

  AppView start() {
    appNav.addRoute('/friends', 0);
    appNav.addRoute('/get_in_touch', 1);
    appNav.addRoute('/settings', 2);

    return AppView(<TopLevelFlow>[friendTabFlow, getInTouchFlow, settingsFlow], appNav);
  }
}
