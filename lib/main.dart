import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:toktok_quote/controller/favorites_provider.dart';
import 'package:toktok_quote/homepage.dart';
import 'package:toktok_quote/services/purchase_service.dart';
import 'package:toktok_quote/showsaved.dart';

// ── Background message handler (must be top-level function) ───────────────────
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
      apiKey: "AIzaSyDLfPGfqwSBiyogHWxEoIzFtamqW7XWo-Y",
      appId: "1:629751083785:android:7306c254f2e54c6cd5d9d8",
      messagingSenderId: "629751083785",
      projectId: "toktokquote",
    )
        : null,
  );
  debugPrint('Background message received: ${message.messageId}');
}

// ── Local Notifications setup ─────────────────────────────────────────────────
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'إشعارات كلام تكاتك',
  description: 'تُستخدم لعرض الإشعارات',
  importance: Importance.high,
  playSound: true,
);

final navigatorKey = GlobalKey<NavigatorState>();

// ── Main ──────────────────────────────────────────────────────────────────────
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
      apiKey: "AIzaSyDLfPGfqwSBiyogHWxEoIzFtamqW7XWo-Y",
      appId: "1:629751083785:android:7306c254f2e54c6cd5d9d8",
      messagingSenderId: "629751083785",
      projectId: "toktokquote",
    )
        : null,
  );

  // FCM background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // RevenueCat init ← new
  await PurchaseService.init();

  // Ads init
  await MobileAds.instance.initialize();

  // Provider init
  final appProvider = AppProvider();
  await appProvider.loadFavorites();
  await appProvider.fetchQuotes();
  await appProvider.checkPremiumStatus(); // ← new

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appProvider),
      ],
      child: const MyApp(),
    ),
  );
}

// ── Local Notifications Init ──────────────────────────────────────────────────
Future<void> _initLocalNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosSettings =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap while app is open/background
      debugPrint('Notification tapped: ${response.payload}');
      navigatorKey.currentState?.pushNamed('/saved');
    },
  );

  // Create high-importance channel for Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation;
  AndroidFlutterLocalNotificationsPlugin()
      .createNotificationChannel(_channel);
}

// ── FCM Init ──────────────────────────────────────────────────────────────────
Future<void> _initFCM() async {
  final messaging = FirebaseMessaging.instance;

  // 1. Request permission (iOS + Android 13+)
  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  debugPrint('FCM permission: ${settings.authorizationStatus}');

  // 2. Subscribe to topic so all users receive broadcast notifications
  await messaging.subscribeToTopic('randomQuotes');

  // 3. Get & print FCM token (useful for testing in Firebase console)
  final token = await messaging.getToken();
  debugPrint('FCM Token: $token');

  // 4. Foreground messages — show local notification manually
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data['route'],
      );
    }
  });

  // 5. App opened from background via notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Notification opened app: ${message.messageId}');
    navigatorKey.currentState?.pushNamed('/saved');
  });

  // 6. App launched from terminated state via notification tap
  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    debugPrint('App launched from notification: ${initialMessage.messageId}');
    // Small delay to ensure navigator is ready
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState?.pushNamed('/saved');
    });
  }
}

/// Run ONCE then DELETE — removes duplicate docs keeping the first occurrence
// Future<void> deleteDuplicateQuotes() async {
//   const chunkSize = 500;
//
//   print('🔍 Fetching all documents...');
//
//   // 1. Fetch all documents ordered by id (keeps the original first)
//   final snapshot = await FirebaseFirestore.instance
//       .collection('onlineQuotes')
//       .orderBy('id')
//       .get();
//
//   final docs = snapshot.docs;
//   print('📄 Total docs fetched: ${docs.length}');
//
//   // 2. Find duplicates — track seen texts, collect duplicate doc refs
//   final Set<String> seenTexts = {};
//   final List<DocumentReference> duplicatesToDelete = [];
//
//   for (final doc in docs) {
//     final text = doc['text'] as String? ?? '';
//
//     if (seenTexts.contains(text)) {
//       // Already seen this text → mark as duplicate
//       duplicatesToDelete.add(doc.reference);
//     } else {
//       // First occurrence → keep it
//       seenTexts.add(text);
//     }
//   }
//
//   print('🗑️ Duplicates found: ${duplicatesToDelete.length}');
//
//   if (duplicatesToDelete.isEmpty) {
//     print('✅ No duplicates found — collection is clean');
//     return;
//   }
//
//   // 3. Delete in batches of 500
//   for (var i = 0; i < duplicatesToDelete.length; i += chunkSize) {
//     final batch = FirebaseFirestore.instance.batch();
//     final chunk = duplicatesToDelete.sublist(
//       i,
//       (i + chunkSize).clamp(0, duplicatesToDelete.length),
//     );
//
//     for (final docRef in chunk) {
//       batch.delete(docRef);
//     }
//
//     await batch.commit();
//     print(
//       '🗑️ Deleted chunk ${i ~/ chunkSize + 1} '
//           '— ${chunk.length} docs (${i + chunk.length}/${duplicatesToDelete.length})',
//     );
//   }
//
//   print('✅ Done — ${duplicatesToDelete.length} duplicate(s) deleted');
//   print('📄 Remaining docs: ${docs.length - duplicatesToDelete.length}');
// }
/// Run this ONCE to add category + isPremium to existing documents
// Future<void> updateExistingQuotes(String category) async {
//   const chunkSize = 500;
//
//   // 1. Fetch all existing documents
//   final snapshot = await FirebaseFirestore.instance
//       .collection('onlineQuotes')
//       .orderBy('id')
//       .get();
//
//   final docs = snapshot.docs;
//   print('Total docs found: ${docs.length}');
//
//   // 2. Process in chunks of 500 (Firestore batch limit)
//   for (var i = 0; i < docs.length; i += chunkSize) {
//     final batch = FirebaseFirestore.instance.batch();
//     final chunk = docs.sublist(i, (i + chunkSize).clamp(0, docs.length));
//
//     for (var j = 0; j < chunk.length; j++) {
//       final docRef = chunk[j].reference;
//
//       batch.update(docRef, {
//         'category': category,
//         'isPremium': false,
//       });
//     }
//
//     await batch.commit();
//     print('Updated chunk ${i ~/ chunkSize + 1} — docs ${i + 1} to ${i + chunk.length}');
//   }
//
//   print('✅ All documents updated successfully');
// }

// ── App ───────────────────────────────────────────────────────────────────────
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'كلام تكاتك',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'AE')],
      locale: const Locale('ar', 'AE'),
      home: const MyHomePage(),
      getPages: [
        GetPage(name: '/saved', page: () => const ShowSaved()),
      ],
    );
  }
}