import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_card.dart';

import '../data/notification_repository.dart';
import '../data/notification_model.dart';
import 'alert_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final NotificationRepository _repo;
  late Future<List<NotificationItem>> _future;

  @override
  void initState() {
    super.initState();
    _repo = NotificationRepository();
    _future = _repo.fetchNotifications();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _repo.fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Notifikasi"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<NotificationItem>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text("Gagal memuat notifikasi"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Tidak ada notifikasi"));
            }

            final items = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return AppCard(
                  child: AlertWidget(item: items[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
