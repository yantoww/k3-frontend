import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../data/solution_model.dart';

class SolutionCard extends StatelessWidget {
  final SolutionModel data;
  final VoidCallback? onTap;

  const SolutionCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: AppStyles.title,
              ),
              const SizedBox(height: 6),

              Text(
                data.description,
                style: AppStyles.body,
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Chip(
                    label: Text("Kategori: ${data.category}"),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text("Risk Level: ${data.riskLevel}"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
