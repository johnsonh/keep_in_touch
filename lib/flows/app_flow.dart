import '../views/app_view.dart';
import '../domain/friends_client.dart';
import '../domain/friends_context.dart';
import '../services/navigation_manager.dart';
import '../services/notification_service.dart';

import 'friend_tab_flow.dart';
import 'get_in_touch_flow.dart';
import 'settings_flow.dart';

class AppFlow {
  final NavigationManager navigationManager;
  final NotificationService notificationService;
  final FriendTabFlow friendTabFlow;
  final GetInTouchFlow getInTouchFlow;
  final SettingsFlow settingsFlow;

  final FriendsClient friendsClient;
  final FriendsContext friendsContext;

  AppFlow._(
      this.navigationManager,
      this.notificationService,
      this.friendTabFlow,
      this.getInTouchFlow,
      this.settingsFlow,
      this.friendsClient,
      this.friendsContext);

  // This should be replaced with DI
  factory AppFlow() {
    var navigationManager = NavigationManager();
    var notificationService =
        NotificationService(navigationManager.onSelectNotification);

    var friendsClient = FriendsClient();
    friendsClient.database;
    var friendsContext = FriendsContext(friendsClient);

    var friendTabFlow = FriendTabFlow(navigationManager, friendsContext);
    var getInTouchFlow = GetInTouchFlow(friendsContext);
    var settingsFlow = SettingsFlow(notificationService);
    return new AppFlow._(navigationManager, notificationService, friendTabFlow,
        getInTouchFlow, settingsFlow, friendsClient, friendsContext);
  }

  AppView start() {
    navigationManager.addRoute('/friends', 0);
    navigationManager.addRoute('/get_in_touch', 1);
    navigationManager.addRoute('/settings', 2);

    return AppView([friendTabFlow, getInTouchFlow, settingsFlow], navigationManager);
  }
}
