class DashboardModel {
  final int riskScore;

  DashboardModel({required this.riskScore});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      riskScore: (json['score'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'score': riskScore,
    // 'daily_trend': dailyTrend.map((e) => e.toJson()).toList(),
  };
}


