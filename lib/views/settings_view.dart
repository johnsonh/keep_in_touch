

import 'package:flutter/material.dart';

class SettingsView {
  // Widget start() {
  //   return Column(children: <Widget>[
  //     Text("Settings flow", textScaleFactor: 3.0),
  //     RaisedButton(
  //       onPressed: notificationService.showNotificationWithDefaultSound,
  //       child: Text('Test notification'),
  //     ),
  //     RaisedButton(
  //       onPressed: notificationService.scheduleNotification,
  //       child: Text('Schedule notification'),
  //     ),
  //     RaisedButton(
  //       onPressed: notificationService.scheduleNotificationEveryMin,
  //       child: Text('Schedule notification every minute'),
  //     ),
  //     RaisedButton(
  //       onPressed: notificationService.scheduleNotificationDaily,
  //       child: Text('Schedule daily notification'),
  //     ),
  //     displayScheduledNotifications()
  //   ]);
  // }

  // Widget displayScheduledNotifications() {
  //   return FutureBuilder(
  //     builder: (context, resultsSnapshot) {
  //       if (resultsSnapshot.connectionState == ConnectionState.none &&
  //           resultsSnapshot.hasData == null) {
  //         return Container();
  //       }

  //       return ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: (resultsSnapshot.data == null ? 0 : resultsSnapshot.data.length),
  //         itemBuilder: (context, index) {
  //           PendingNotification notification = resultsSnapshot.data[index];
  //           return Container(
  //               margin: const EdgeInsets.all(20.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text("ID: " + notification.id.toString()),
  //                   Text("Title: " + notification.title),
  //                   Text("Body: " + notification.body),
  //                   Text("Payload: " + notification.payload),
  //                 ],
  //               )
  //             );
  //         },
  //       );
  //     },
  //     future: notificationService.getScheduledNotifications(),
  //   );
  // }
}