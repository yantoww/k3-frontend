import 'package:flutter/material.dart';
import '../data/solution_model.dart';
import '../../../core/constants/styles.dart';

class SolutionPage extends StatelessWidget {
  final SolutionModel solution;

  const SolutionPage({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    final assessment = solution.assessment;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Evaluasi Risiko"),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Informasi Karyawan", style: AppStyles.title),
                    const SizedBox(height: 8),
                    Text("Employee ID: ${assessment.employeeId}", style: AppStyles.body),
                    Text("Lokasi: ${assessment.locationArea}", style: AppStyles.body),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              color: Colors.indigo.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hasil Penilaian Risiko", style: AppStyles.title),
                    const SizedBox(height: 8),
                    Text("Risk Level: ${assessment.riskLevel}", style: AppStyles.body),
                    Text("Score Risiko: ${assessment.score}", style: AppStyles.body),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rincian Perhitungan", style: AppStyles.title),
                    const SizedBox(height: 8),
                    Text("• Probability: ${assessment.details.probWeight}", style: AppStyles.body),
                    Text("• Severity: ${assessment.details.sevWeight}", style: AppStyles.body),
                    Text("• Competency Multiplier: ${assessment.details.compMultiplier}", style: AppStyles.body),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card(
            //   elevation: 3,
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text("Rekomendasi & Saran", style: AppStyles.title),
            //         const SizedBox(height: 8),
            //         Text(assessment.suggestion, style: AppStyles.body),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),

            Card(
              color: Colors.red.shade50,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Instruksi Darurat", style: AppStyles.title.copyWith(color: Colors.red)),
                    const SizedBox(height: 8),
                    Text(solution.emergency, style: AppStyles.body),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
