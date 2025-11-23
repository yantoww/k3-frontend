import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import 'notification_model.dart';

class NotificationRepository {
  final ApiService _api;

  NotificationRepository({ApiService? api}) : _api = api ?? ApiService();

  /// Fetch notifications from backend.
  /// Expected response shape (example):
  /// {
  ///   "data": [
  ///     {"id":1,"title":"Alert","message":"...","date":"2025-11-21","is_read":false},
  ///     ...
  ///   ]
  /// }
  Future<List<NotificationItem>> fetchNotifications() async {
    try {
      final Response resp = await _api.get('/api/notifications');

      // Resp.data should already be a decoded JSON (Map or List) when using Dio
      final dynamic body = resp.data;

      // Support both { "data": [...] } and direct array [...]
      List<dynamic> list = [];
      if (body is Map && body['data'] is List) {
        list = body['data'] as List<dynamic>;
      } else if (body is List) {
        list = body;
      }

      return list.map((e) {
        if (e is Map<String, dynamic>) {
          return NotificationItem.fromJson(e);
        } else {
          return NotificationItem.fromJson(Map<String, dynamic>.from(e as Map));
        }
      }).toList();
    } catch (e) {
      // On error, return empty list (or you can return mock data)
      return [];
    }
  }
}
