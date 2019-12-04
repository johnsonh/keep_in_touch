import 'package:flutter/material.dart';

class SettingsTabView extends StatelessWidget {
  final Function onShowTestNotification;
  final Function onScheduleNotification;
  final Function onScheduleNotificationEveryMinute;
  final Function onScheduleNotificationDaily;
  final Future<List<Notification>> getScheduledNotifications; 

  SettingsTabView(this.onShowTestNotification, this.onScheduleNotification, this.onScheduleNotificationEveryMinute, this.onScheduleNotificationDaily, this.getScheduledNotifications);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text("Settings flow", textScaleFactor: 3.0),
      RaisedButton(
        onPressed: onShowTestNotification,
        child: Text('Test notification'),
      ),
      RaisedButton(
        onPressed: onScheduleNotification,
        child: Text('Schedule notification'),
      ),
      RaisedButton(
        onPressed: onScheduleNotificationEveryMinute,
        child: Text('Schedule notification every minute'),
      ),
      RaisedButton(
        onPressed: onScheduleNotificationDaily,
        child: Text('Schedule daily notification'),
      ),
      displayScheduledNotifications()
    ]);
  }

  Widget displayScheduledNotifications() {
    return FutureBuilder(
      builder: (context, resultsSnapshot) {
        if (resultsSnapshot.connectionState == ConnectionState.none &&
            resultsSnapshot.hasData == null) {
          return Container();
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: (resultsSnapshot.data == null ? 0 : resultsSnapshot.data.length),
          itemBuilder: (context, index) {
            Notification notification = resultsSnapshot.data[index];
            return Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: " + notification.id.toString()),
                    Text("Title: " + notification.title),
                    Text("Body: " + notification.body),
                    Text("Payload: " + notification.payload),
                  ],
                )
              );
          },
        );
      },
      future: getScheduledNotifications,
    );
  }
}

class Notification {
  final int id;
  final String title;
  final String body;
  final String payload;

  const Notification(this.id, this.title, this.body, this.payload);
}
