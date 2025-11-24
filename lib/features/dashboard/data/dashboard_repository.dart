import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import 'dashboard_model.dart';

class DashboardRepository {
  final ApiService _api;

  DashboardRepository({ApiService? api}) : _api = api ?? ApiService();

  Future<DashboardModel> fetchDashboard() async {
    try {
      final Response resp = await _api.post(
        '/api/calculate',
        {
          "employee_id": "E123",
          "location_area": "Warehouse 1",
          "prob_input": "medium",
          "sev_input": "high",
          "comp_input": "low"
        },
      );

      if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300 && resp.data != null) {
        final Map<String, dynamic> data = Map<String, dynamic>.from(resp.data);

        final int riskScore = (data['score'] as num?)?.toInt() ?? 0;


        return DashboardModel(riskScore: riskScore);
      } else {
        print('Unexpected response: ${resp.statusCode}, ${resp.data}');
        return DashboardModel(riskScore: 0,);
      }
    } catch (e, stacktrace) {
      print('Error fetching dashboard: $e');
      print(stacktrace);
      return DashboardModel(riskScore: 0, );
    }
  }
}



