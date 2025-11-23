import 'solution_model.dart';

class SolutionRepository {

  Future<List<SolutionModel>> getSolutions() async {
   await Future.delayed(Duration(seconds: 1)); // biar kayak loading

    return [
      SolutionModel(
        id: "1",
        title: "Mitigasi Risiko Keuangan",
        description: "Pantau arus kas dan lakukan diversifikasi aset.",
        category: "Finansial",
        riskLevel: 3,
      ),
      SolutionModel(
        id: "2",
        title: "Pemantauan Aset",
        description: "Gunakan sistem monitoring real-time untuk aset penting.",
        category: "Operasional",
        riskLevel: 4,
      ),
      SolutionModel(
        id: "3",
        title: "Pencegahan Keamanan",
        description: "Lakukan audit keamanan secara berkala.",
        category: "Security",
        riskLevel: 2,
      ),
    ];
  }
}
