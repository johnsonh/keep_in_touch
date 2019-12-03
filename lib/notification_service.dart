import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final NotificationDetails platformChannelSpecifics;

  NotificationService._(
      this.flutterLocalNotificationsPlugin, this.platformChannelSpecifics);

  factory NotificationService(
      Future Function(String payload) onSelectNotification) {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    return new NotificationService._(
        flutterLocalNotificationsPlugin, platformChannelSpecifics);
  }

  Future showNotificationWithDefaultSound() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: '/get_in_touch',
    );
  }

  Future scheduleNotification() async {
    var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 3));
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: 'scheduled notification payload');
  }

  Future scheduleNotificationEveryMin() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'repeating title',
      'repeating body',
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
      payload: 'every minute payload');
  }

  Future scheduleNotificationDaily() async {
    var time = new Time(19, 0, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Keep in touch with a friend!',
        'Daily notification shown at approximately ${time.hour}:${time.minute}:${time.second}',
        time,
        platformChannelSpecifics,
        payload: 'daily notification at X time');
  }

  Future<List<PendingNotification>> getScheduledNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests()
      .then((results) => results.map((n) => PendingNotification(n.id, n.title, n.body, n.payload)).toList());
  }
}

class PendingNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  const PendingNotification(
      this.id, this.title, this.body, this.payload);
}
