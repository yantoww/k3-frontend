class TrendModel {
  final num avg_score;
  final String date;

  TrendModel({required this.avg_score, required this.date});

  factory TrendModel.fromJson(Map<String, dynamic> json) {
    return TrendModel(
      avg_score: json['avg_score'] as num ?? 0,
      date: json['date'].toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'avg_score': avg_score, 'date': date};
}
