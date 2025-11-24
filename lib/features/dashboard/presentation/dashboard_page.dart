import 'package:flutter/material.dart';
import 'package:risk_advisor_management/features/dashboard/data/trend_model.dart';
import 'package:risk_advisor_management/features/dashboard/data/trend_repository.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/colors.dart';

import '../data/dashboard_repository.dart';
import '../data/dashboard_model.dart';
import 'risk_meter_widget.dart';
import 'risk_trend_chart.dart';

import '../../../core/services/notification_service.dart';
import '../../solutions/presentation/solution_page.dart';
import '../../solutions/presentation/risk_form_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardRepository _repo;
  late Future<DashboardModel> _future;

  late final TrendRepository _trendRepository;
  late Future<List<TrendModel>> _trendFuture;

  @override
  void initState() {
    super.initState();

    // Dashboard
    _repo = DashboardRepository();
    _future = _repo.fetchDashboard();

    _trendRepository = TrendRepository();
    _trendFuture = _trendRepository.fetchDailyTrend();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _repo.fetchDashboard();
      _trendFuture = _trendRepository.fetchDailyTrend();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard Risiko'),
        backgroundColor: Colors.indigoAccent,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
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
                  /// SKOR RISIKO
                  /// -------------------------
                  AppCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        Text("Skor Risiko", style: AppStyles.title),
                        const SizedBox(height: 12),
                        // Use the RiskMeterWidget
                        RiskMeterWidget(
                          riskPercent: model.riskScore,
                          size: 160,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// -------------------------
                  /// TEST NOTIFIKASI
                  /// -------------------------
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Notifikasi.show(
                  //       title: "Percobaan",
                  //       body: "Notifikasi berhasil!",
                  //     );
                  //   },
                  //   child: const Text("Test Notifikasi"),
                  // ),

                  // const SizedBox(height: 20),

                  /// -------------------------
                  /// AI PREDICTION
                  /// -------------------------
                  // Text('AI Risk Prediction', style: AppStyles.title),
                  // const SizedBox(height: 10),

                  // FutureBuilder<AiPredictionModel>(
                  //   future: _predictionFuture,
                  //   builder: (context, snapAI) {
                  //     if (snapAI.connectionState == ConnectionState.waiting) {
                  //       return AppCard(
                  //         child: SizedBox(
                  //           height: 80,
                  //           child: Center(
                  //             child: CircularProgressIndicator(
                  //               color: AppColors.primary,
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //
                  //     if (snapAI.hasError) {
                  //       return AppCard(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(12),
                  //           child: Text(
                  //             'Gagal memuat prediksi AI',
                  //             style: AppStyles.body,
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //
                  //     if (!snapAI.hasData) {
                  //       return AppCard(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(12),
                  //           child: Text(
                  //             'Tidak ada data AI',
                  //             style: AppStyles.body,
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //
                  //     final prediction = snapAI.data!;
                  //
                  //     return AppCard(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "Skor Risiko AI: ${prediction.riskPercent}", // bisa ganti menjadi prediction.score jika backend menyediakan
                  //             style: AppStyles.title,
                  //           ),
                  //           const SizedBox(height: 12),
                  //           RiskFactorsWidget(factors: prediction.factors),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  FutureBuilder<List<TrendModel>>(
                    future: _trendFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AppCard(
                          child: SizedBox(
                            height: 160,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return AppCard(
                          child: SizedBox(
                            height: 160,
                            child: Center(
                              child: Text(
                                'Gagal memuat trend',
                                style: AppStyles.body,
                              ),
                            ),
                          ),
                        );
                      }

                      final trendData = snapshot.data!;
                      return AppCard(
                        child: Column(
                          children: [
                            Text(
                              "Tingkat Resiko Minggu Ini",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RiskTrendChart(data: trendData, height: 160),
                          ],
                        ),
                      );
                    },
                  ),

                  /// -------------------------
                  /// BUTTON NAVIGASI SOLUSI
                  /// -------------------------
                  ///
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RiskFormPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lightbulb_outline, size: 22),
                    label: const Text("Lihat Rekomendasi Solusi"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
