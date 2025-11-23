import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class Notifikasi {
  static final FlutterLocalNotificationsPlugin _notifikasiPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // === ANDROID SETTINGS ===
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    // Init plugin
    await _notifikasiPlugin.initialize(initSettings);

    // Android 13+ WAJIB: Request permission
    await Permission.notification.request();

    // Buat notification channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'Default Notifications',
      importance: Importance.max,
    );

    final android = _notifikasiPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.createNotificationChannel(channel);

    debugPrint("Notifikasi berhasil diinisialisasi");
  }

  // Test notifikasi
  static Future<void> show({
    required String title,
    required String body,
  }) async {
    const androidDetail = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const detail = NotificationDetails(android: androidDetail);

    await _notifikasiPlugin.show(
      0,
      title,
      body,
      detail,
    );
  }
}
