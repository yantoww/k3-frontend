import 'package:flutter/material.dart';
import 'features/notifications/presentation/notification_page.dart';
import 'features/dashboard/presentation/dashboard_page.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi notifikasi
  await Notifikasi.init();

  FlutterError.onError = (details) {
    print(" ERROR TERDETEKSI:");
    print(details.exception);
    print(details.stack);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(), // ⬅ Page utama
    );
  }
}
