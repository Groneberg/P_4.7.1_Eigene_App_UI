import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:developer'; 

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    log("NotificationService: Initialisierung...");
    tz.initializeTimeZones();

    // Android Initialisierungs-Einstellungen
    // Verwendet das Standard-Launcher-Icon
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/Darwin Initialisierungs-Einstellungen
    final DarwinInitializationSettings darwinSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
    log("NotificationService: Initialisierung abgeschlossen.");
  }

  Future<void> requestPermissions() async {
    // Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // iOS/macOS
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    log("Notification Tapped: Payload: ${response.payload}");
    // Navigation etc.
  }

  // Die _onDidReceiveLocalNotification Funktion wird nicht mehr benötigt.

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
    String? payload,
  }) async {
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(
      scheduledDateTime,
      tz.local,
    );

    if (tzScheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      log("Fehler: Kann Benachrichtigung nicht in der Vergangenheit planen.");
      return;
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id_events',
      'Event Reminders',
      channelDescription: 'Benachrichtigungen für anstehende Events',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledTime,
      notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    log("Benachrichtigung geplant: ID $id für $tzScheduledTime");
  }

  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
    log("Benachrichtigung abgebrochen: ID $id");
  }
}