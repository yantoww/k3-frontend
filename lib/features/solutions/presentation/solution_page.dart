import 'package:flutter/material.dart';
import '../data/solution_repository.dart';
import '../data/solution_model.dart';
import 'solution_card.dart';
import '../../../core/constants/styles.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({super.key});

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  late SolutionRepository repo;

  @override
  void initState() {
    super.initState();
    repo = SolutionRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rekomendasi Solusi")),
      body: FutureBuilder<List<SolutionModel>>(
        future: repo.getSolutions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Gagal memuat data", style: AppStyles.body),
            );
          }

          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return Center(child: Text("Tidak ada data"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return SolutionCard(data: data[i]);
            },
          );
        },
      ),
    );
  }
}
