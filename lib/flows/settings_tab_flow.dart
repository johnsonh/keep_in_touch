import '../views/settings_tab_nav_views.dart';
import '../views/settings_tab_view.dart';
import '../views/nav_view.dart'; // how to get rid of this
import '../services/notification_service.dart';

class SettingsTabFlow implements TopLevelFlow {
  final NotificationService notificationService;
  final SettingsTabView settingsTabView; 
  final SettingsTabNavViews settingsTabNavViews;

  SettingsTabFlow._(this.notificationService, this.settingsTabView, this.settingsTabNavViews);

  factory SettingsTabFlow(NotificationService notificationService) {
    Function onShowTestNotification = notificationService.showNotificationWithDefaultSound;
    Function onScheduleNotification = notificationService.scheduleNotification;
    Function onScheduleNotificationEveryMinute = notificationService.scheduleNotificationEveryMin;
    Function onScheduleNotificationDaily = notificationService.scheduleNotificationDaily;
    Future<List<Notification>> getScheduledNotifications = notificationService.getScheduledNotifications()
      .then((notifications) => notifications.map((pending) => Notification(pending.id, pending.title, pending.body, pending.payload)).toList()); 

    var settingsTabView = SettingsTabView(
      onShowTestNotification, 
      onScheduleNotification, 
      onScheduleNotificationEveryMinute, 
      onScheduleNotificationDaily, 
      getScheduledNotifications
    ); 
    
    var settingsTabNavViews = SettingsTabNavViews(settingsTabView);

    return new SettingsTabFlow._(notificationService, settingsTabView, settingsTabNavViews);
  }

  @override
  TopLevelNavViews getTopLevelNavViews() {
    return settingsTabNavViews;
  }
}
