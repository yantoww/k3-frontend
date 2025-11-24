import 'package:risk_advisor_management/features/solutions/data/risk_request_model.dart';

import '../../../core/services/api_service.dart';
import 'solution_model.dart';

class SolutionRepository {
  final ApiService api;

  SolutionRepository(this.api);

  Future<SolutionModel> submitRisk(RiskRequestModel req) async {
    try {
      print(" Sending Request to /api/ai/safety-advice:");
      print(req.toJson()); // Debug request body

      final res = await api.post('/api/ai/safety-advice', req.toJson());

      print(" Response Status Code: ${res.statusCode}");
      print(" Raw Response:");
      print(res.data); // Debug response JSON

      if (res.data == null) {
        throw Exception(" Empty response from server");
      }

      final body = res.data;

      if (body['data'] == null) {
        print(" data' field not found, using full JSON instead.");
        return SolutionModel.fromJson(body);
      }

      return SolutionModel.fromJson(body['data']);
    } catch (e, stack) {
      print(" ERROR DURING API CALL:");
      print(e);
      print(stack);

      throw Exception("Error sending risk request: $e");
    }
  }
}
