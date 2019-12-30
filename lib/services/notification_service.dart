import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  
  factory NotificationService(Future<void> Function(String payload) onSelectNotification) {
    const AndroidInitializationSettings initializationSettingsAndroid = 
      AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    final IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    return NotificationService._(flutterLocalNotificationsPlugin, platformChannelSpecifics);
  }

  NotificationService._(
      this.flutterLocalNotificationsPlugin, this.platformChannelSpecifics);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final NotificationDetails platformChannelSpecifics;

  Future<void> showNotificationWithDefaultSound() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: '/get_in_touch',
    );
  }

  Future<void> scheduleNotification() async {
    final DateTime scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 3));
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: '/friends');
  }

  Future<void> scheduleNotificationEveryMin() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics,
        payload: '/settings');
  }

  Future<void> scheduleNotificationDaily() async {
    final Time time = Time(19, 0, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Keep in touch with a friend!',
        'Daily notification shown at approximately ${time.hour}:${time.minute}:${time.second}',
        time,
        platformChannelSpecifics,
        payload: 'daily notification at X time');
  }

  Future<List<PendingNotification>> getScheduledNotifications() async {
    return await flutterLocalNotificationsPlugin
        .pendingNotificationRequests()
        .then((List<PendingNotificationRequest> results) => results
            .map((PendingNotificationRequest n) => PendingNotification(n.id, n.title, n.body, n.payload))
            .toList());
  }
}

class PendingNotification {
  const PendingNotification(this.id, this.title, this.body, this.payload);

  final int id;
  final String title;
  final String body;
  final String payload;
}
