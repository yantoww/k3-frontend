import 'package:flutter/material.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/colors.dart';

import '../data/dashboard_repository.dart';
import '../data/dashboard_model.dart';
import 'risk_meter_widget.dart';
import 'risk_trend_chart.dart';

import '../../prediction_ai/data/prediction_repository.dart';
import '../../prediction_ai/data/ai_prediction_model.dart';
import '../../prediction_ai/presentation/risk_factors_widget.dart';

import '../../../core/services/notification_service.dart';

import '../../solutions/presentation/solution_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // DASHBOARD
  late final DashboardRepository _repo;
  late Future<DashboardModel> _future;

  // AI PREDICTION (use the actual model type name)
  late final PredictionRepository _predictionRepo;
  late Future<AiPredictionModel> _predictionFuture;

  @override
  void initState() {
    super.initState();

    // Dashboard
    _repo = DashboardRepository();
    _future = _repo.fetchDashboard();

    // AI Prediction
    _predictionRepo = PredictionRepository();
    _predictionFuture = _predictionRepo.fetchPrediction();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _repo.fetchDashboard();
      _predictionFuture = _predictionRepo.fetchPrediction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Dashboard Risiko')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: FutureBuilder<DashboardModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error memuat data', style: AppStyles.body),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text('Tidak ada data', style: AppStyles.body),
                );
              }

              final model = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// -------------------------
                  /// RISK METER
                  /// -------------------------
                  AppCard(
                    child: Column(
                      children: [
                        RiskMeterWidget(
                          riskPercent: model.riskPercent,
                          size: 160,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// -------------------------
                  /// TEST NOTIFIKASI
                  /// -------------------------
                  ElevatedButton(
                    onPressed: () {
                      Notifikasi.show(
                        title: "Percobaan",
                        body: "Notifikasi berhasil!",
                      );
                    },
                    child: const Text("Test Notifikasi"),
                  ),

                  const SizedBox(height: 20),

                  /// -------------------------
                  /// AI PREDICTION
                  /// -------------------------
                  Text('AI Risk Prediction', style: AppStyles.title),
                  const SizedBox(height: 10),

                  FutureBuilder<AiPredictionModel>(
                    future: _predictionFuture,
                    builder: (context, snapAI) {
                      if (snapAI.connectionState == ConnectionState.waiting) {
                        return AppCard(
                          child: SizedBox(
                            height: 80,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      }

                      if (snapAI.hasError) {
                        return AppCard(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Gagal memuat prediksi AI',
                              style: AppStyles.body,
                            ),
                          ),
                        );
                      }

                      if (!snapAI.hasData) {
                        return AppCard(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Tidak ada data AI',
                              style: AppStyles.body,
                            ),
                          ),
                        );
                      }

                      final prediction = snapAI.data!;

                      return AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Show riskPercent (int) from AiPredictionModel
                            Text(
                              "Skor Risiko: ${prediction.riskPercent}%",
                              style: AppStyles.title,
                            ),
                            const SizedBox(height: 12),
                            RiskFactorsWidget(factors: prediction.factors),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  /// -------------------------
                  /// TREND CHART
                  /// -------------------------
                  Text('Tren Risiko (Harian)', style: AppStyles.title),
                  const SizedBox(height: 8),

                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RiskTrendChart(data: model.dailyTrend, height: 160),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// -------------------------
                  /// BUTTON NAVIGASI SOLUSI
                  /// -------------------------
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SolutionPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lightbulb),
                    label: const Text("Lihat Rekomendasi Solusi"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
