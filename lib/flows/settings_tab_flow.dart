import '../services/notification_service.dart';
import '../views/nav_view.dart';
import '../views/settings_tab_nav_views.dart';
import '../views/settings_tab_view.dart';

class SettingsTabFlow implements TopLevelFlow {
  factory SettingsTabFlow(NotificationService notificationService) {
    final Function onShowTestNotification =
        notificationService.showNotificationWithDefaultSound;
    final Function onScheduleNotification = notificationService.scheduleNotification;
    final Function onScheduleNotificationEveryMinute =
        notificationService.scheduleNotificationEveryMin;
    final Function onScheduleNotificationDaily =
        notificationService.scheduleNotificationDaily;
    final Future<List<Notification>> getScheduledNotifications = notificationService
        .getScheduledNotifications()
        .then((List<PendingNotification> notifications) => notifications
            .map((PendingNotification pending) => Notification(
                pending.id, pending.title, pending.body, pending.payload))
            .toList());

    final SettingsTabView settingsTabView = SettingsTabView(
        onShowTestNotification,
        onScheduleNotification,
        onScheduleNotificationEveryMinute,
        onScheduleNotificationDaily,
        getScheduledNotifications);

    final SettingsTabNavViewsProvider settingsTabNavViews = SettingsTabNavViewsProvider(settingsTabView);

    return SettingsTabFlow._(notificationService, settingsTabView, settingsTabNavViews);
  }

  SettingsTabFlow._(this.notificationService, this.settingsTabView,
      this.settingsTabNavViewsProvider);

  final NotificationService notificationService;
  final SettingsTabView settingsTabView;
  final SettingsTabNavViewsProvider settingsTabNavViewsProvider;

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return settingsTabNavViewsProvider;
  }
}
