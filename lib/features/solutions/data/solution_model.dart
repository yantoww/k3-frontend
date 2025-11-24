class SolutionModel {
  final Assessment assessment;
  final String emergency;
  final String source;
  final String status;

  SolutionModel({
    required this.assessment,
    required this.emergency,
    required this.source,
    required this.status,
  });

  factory SolutionModel.fromJson(Map<String, dynamic> json) {
    return SolutionModel(
      assessment: Assessment.fromJson(json['assessment'] ?? {}),
      emergency: json['emergency']?.toString() ?? '',
      source: json['source']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'assessment': assessment.toJson(),
    'emergency': emergency,
    'source': source,
    'status': status,
  };
}

class Assessment {
  final AssessmentDetails details;
  final String employeeId;
  final String locationArea;
  final String riskLevel;
  final int score;
  final String suggestion;

  Assessment({
    required this.details,
    required this.employeeId,
    required this.locationArea,
    required this.riskLevel,
    required this.score,
    required this.suggestion,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      details: AssessmentDetails.fromJson(json['details'] ?? {}),
      employeeId: json['employee_id']?.toString() ?? '',
      locationArea: json['location_area']?.toString() ?? '',
      riskLevel: json['risk_level']?.toString() ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
      suggestion: json['suggestion']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'details': details.toJson(),
    'employee_id': employeeId,
    'location_area': locationArea,
    'risk_level': riskLevel,
    'score': score,
    'suggestion': suggestion,
  };
}

class AssessmentDetails {
  final double compMultiplier;
  final int probWeight;
  final int sevWeight;

  AssessmentDetails({
    required this.compMultiplier,
    required this.probWeight,
    required this.sevWeight,
  });

  factory AssessmentDetails.fromJson(Map<String, dynamic> json) {
    return AssessmentDetails(
      compMultiplier: (json['comp_multiplier'] as num?)?.toDouble() ?? 0.0,
      probWeight: (json['prob_weight'] as num?)?.toInt() ?? 0,
      sevWeight: (json['sev_weight'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'comp_multiplier': compMultiplier,
    'prob_weight': probWeight,
    'sev_weight': sevWeight,
  };
}
