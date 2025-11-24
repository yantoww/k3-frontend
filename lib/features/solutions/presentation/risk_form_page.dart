import 'package:flutter/material.dart';
import 'package:risk_advisor_management/core/constants/colors.dart';
import 'package:risk_advisor_management/core/widgets/loading_dialog.dart';
import '../data/risk_request_model.dart';
import '../data/solution_repository.dart';
import '../../../core/services/api_service.dart';
import 'solution_page.dart';

class RiskFormPage extends StatefulWidget {
  const RiskFormPage({super.key});

  @override
  State<RiskFormPage> createState() => _RiskFormPageState();
}

class _RiskFormPageState extends State<RiskFormPage> {
  final employeeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  String? probInput;
  String? sevInput;
  String? compInput;

  late SolutionRepository repo;

  @override
  void initState() {
    super.initState();
    repo = SolutionRepository(ApiService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Input Data Risiko"),
        backgroundColor: Colors.indigoAccent,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Isi Data Risiko",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: employeeCtrl,
                  decoration: InputDecoration(
                    labelText: "Employee ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: locationCtrl,
                  decoration: InputDecoration(
                    labelText: "Lokasi Area",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text("Probability"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: probInput,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  items: ["Low", "Medium", "High"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => probInput = value),
                ),

                const SizedBox(height: 16),
                const Text("Severity"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: sevInput,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  items: ["Low", "Medium", "High"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => sevInput = value),
                ),

                const SizedBox(height: 16),
                const Text("Competency"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: compInput,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  items: ["Low", "Medium", "High"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) => setState(() => compInput = value),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.indigoAccent,
                    ),
                    onPressed: () async {
                      if (probInput == null ||
                          sevInput == null ||
                          compInput == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Form belum lengkap!")),
                        );
                        return;
                      }

                      LoadingDialog.show(
                        context,
                        message: "AI sedang menghitung risiko...",
                      );

                      try {
                        final req = RiskRequestModel(
                          employeeId: employeeCtrl.text,
                          locationArea: locationCtrl.text,
                          probInput: probInput!.toLowerCase(),
                          sevInput: sevInput!.toLowerCase(),
                          compInput: compInput!.toLowerCase(),
                        );

                        final result = await repo.submitRisk(req);

                        if (!mounted) return;

                        LoadingDialog.hide(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SolutionPage(solution: result),
                          ),
                        );
                      } catch (e) {
                        LoadingDialog.hide(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Gagal memproses data: $e")),
                        );
                      }
                    },
                    child: const Text(
                      "Lihat Rekomendasi Solusi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
