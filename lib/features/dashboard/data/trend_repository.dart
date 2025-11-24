import 'package:risk_advisor_management/core/services/api_service.dart';
import 'trend_model.dart';

class TrendRepository {
  final ApiService _api;

  TrendRepository({ApiService? api}) : _api = api ?? ApiService();

  Future<List<TrendModel>> fetchDailyTrend() async {
    try {
      final response = await _api.get('/api/trend/daily');

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> list = response.data as List<dynamic>;
        return list.map((e) => TrendModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        return _mock();
      }
    } catch (e) {
      return _mock();
    }
  }

  List<TrendModel> _mock() {
    return List.generate(
      7,
          (i) => TrendModel(avg_score: 0, date: 'D${i+1}'),
    );
  }
}
