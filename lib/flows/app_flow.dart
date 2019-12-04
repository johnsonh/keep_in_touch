import '../app_nav.dart';
import '../views/app_view.dart';
import '../domain/friends_client.dart';
import '../domain/friends_context.dart';
import '../services/notification_service.dart';

import 'friend_tab_flow.dart';
import 'get_in_touch_flow.dart';
import 'settings_tab_flow.dart';

class AppFlow {
  final AppNav appNav;
  final NotificationService notificationService;
  final FriendTabFlow friendTabFlow;
  final GetInTouchFlow getInTouchFlow;
  final SettingsTabFlow settingsFlow;

  final FriendsClient friendsClient;
  final FriendsContext friendsContext;

  AppFlow._(
      this.appNav,
      this.notificationService,
      this.friendTabFlow,
      this.getInTouchFlow,
      this.settingsFlow,
      this.friendsClient,
      this.friendsContext);

  // This should be replaced with DI
  factory AppFlow() {
    var appNav = AppNav();
    var notificationService =
        NotificationService(appNav.onSelectNotification);

    var friendsClient = FriendsClient();
    friendsClient.database;
    var friendsContext = FriendsContext(friendsClient);

    var friendTabFlow = FriendTabFlow(appNav, friendsContext);
    var getInTouchFlow = GetInTouchFlow(friendsContext);
    var settingsFlow = SettingsTabFlow(notificationService);
    return new AppFlow._(appNav, notificationService, friendTabFlow,
        getInTouchFlow, settingsFlow, friendsClient, friendsContext);
  }

  AppView start() {
    appNav.addRoute('/friends', 0);
    appNav.addRoute('/get_in_touch', 1);
    appNav.addRoute('/settings', 2);

    return AppView([friendTabFlow, getInTouchFlow, settingsFlow], appNav);
  }
}
