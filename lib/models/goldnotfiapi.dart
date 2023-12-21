// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:cron/cron.dart';

// class GoldNotificationApi {
//   static final _notifications = FlutterLocalNotificationsPlugin();
//   //to direct to specific page when message clicked
//   static final onNotifications = BehaviorSubject<String?>();
// //for simple notification
//   static Future _notificationDetails() async {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'channel id', 'channel name', 'channel description',
//             importance: Importance.max),
//         iOS: IOSNotificationDetails());
//   }

// //you have to call this first
//   static Future init({bool initScheduled = false}) async {
//     final android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     final ios = IOSInitializationSettings();
//     final settings = InitializationSettings(android: android, iOS: ios);

//     //WHEN APP IS CLOSED
//     final details = await _notifications.getNotificationAppLaunchDetails();
//     if (details != null && details.didNotificationLaunchApp) {
//       onNotifications.add(details.payload);
//     }

//     await _notifications.initialize(
//       settings,
//       onSelectNotification: (payload) async {
//         onNotifications.add(payload);
//       },
//     );
//     if (initScheduled) {
//       tz.initializeTimeZones();
//       final locationName = await FlutterNativeTimezone.getLocalTimezone();
//       tz.setLocalLocation(tz.getLocation(locationName));
//     }
//   }

// //for simple notification
//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async =>
//       _notifications.show(id, title, body, await _notificationDetails(),
//           payload: payload);

// //for scheduled notification
//   static void showScheduledNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     required DateTime scheduledDate,
//   }) async =>
//       _notifications.zonedSchedule(
//           id,
//           title,
//           body,
//           tz.TZDateTime.from(scheduledDate, tz.local),
//           await _notificationDetails(),
//           payload: payload,
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime);

// //for scheduled notification on DAILY BASIS

//   static void showDailyBasisNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     required DateTime scheduledDate,
//   }) async =>
//       _notifications.zonedSchedule(id, title, body,
//           _scheduleDaily(const Time(7,1)), await _notificationDetails(),
//           payload: payload,
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime,
//           matchDateTimeComponents: DateTimeComponents.time);

//   static tz.TZDateTime _scheduleDaily(Time time) {
//     final now = tz.TZDateTime.now(tz.local);
//     final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
//         time.hour, time.minute, time.second);

//     return scheduledDate.isBefore(now)
//         ? scheduledDate.add(const Duration(days: 1))
//         : scheduledDate;
//   }

// // //for scheduled notification on DAILY BASIS

// //   static void showintervalDailyBasisNotification({
// //     int id = 0,
// //     String? title,
// //     String? body,
// //     String? payload,
// //     required DateTime scheduledDate,
// //   }) async =>
// //       _notifications.zonedSchedule(id, title, body,
// //           _scheduleIntervalDaily(const Time(7,1)), await _notificationDetails(),
// //           payload: payload,
// //           androidAllowWhileIdle: true,
// //           uiLocalNotificationDateInterpretation:
// //               UILocalNotificationDateInterpretation.absoluteTime,
// //           matchDateTimeComponents: DateTimeComponents.time);

// //   static tz.TZDateTime _scheduleIntervalDaily(Time time) {
// //     final now = tz.TZDateTime.utc(2022,3,24);
// //     final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
// //         time.hour, time.minute, time.second);

// //     return scheduledDate.isBefore(now)
// //         ? scheduledDate.add(const Duration(days: 1))
// //         : scheduledDate;
// //   }



// //for scheduled notification on WEEKLY DAYS
//   static void showWeeklyDaysNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     required DateTime scheduledDate,
//   }) async =>
//       _notifications.zonedSchedule(
//           id,
//           title,
//           body,
//           _scheduleWeekly(const Time(6),
//               days: [DateTime.wednesday, DateTime.friday]),
//           await _notificationDetails(),
//           payload: payload,
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime,
//           matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

//   static tz.TZDateTime _scheduleWeeklyDaily(Time time) {
//     final now = tz.TZDateTime.now(tz.local);
//     final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
//         time.hour, time.minute, time.second);

//     return scheduledDate.isBefore(now)
//         ? scheduledDate.add(const Duration(days: 1))
//         : scheduledDate;
//   }

//   static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
//     tz.TZDateTime scheduledDate = _scheduleWeeklyDaily(time);

//     while (days.contains(scheduledDate.weekday)) {
//       scheduledDate = scheduledDate.add(Duration(days: 1));
//     }
//     return scheduledDate;
//   }

// //EDITED FOR WEEKLY DAYS(RIGHT ONE)
//   static void editedShowScheduledNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     final scheduledDates = _editedscheduleWeekly(Time(8, 1),
//         days: [DateTime.monday, DateTime.thursday]);

//     for (int i = 0; i < scheduledDates.length; i++) {
//       final scheduledDate = scheduledDates[i];

//       _notifications.zonedSchedule(
//         id + i, // choose for each notification an index that is unique
//         title,
//         body,
//         scheduledDate,
//         await _notificationDetails(),
//         payload: payload,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//       );
//     }
//   }

//   static List<tz.TZDateTime> _editedscheduleWeekly(Time time,
//       {required List<int> days}) {
//     return days.map((day) {
//       tz.TZDateTime scheduledDate = _scheduleDaily(time);

//       while (day != scheduledDate.weekday) {
//         scheduledDate = scheduledDate.add(Duration(days: 1));
//       }
//       return scheduledDate;
//     }).toList();
//   }
// }