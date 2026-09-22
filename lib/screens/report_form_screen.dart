import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});
  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _location = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose(); _description.dispose(); _location.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await context.read<AppProvider>().addReport(
        title: _title.text, description: _description.text, location: _location.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signalement enregistré sur cet appareil.')));
      Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Impossible d’enregistrer le signalement. Réessayez.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nouveau signalement')),
    body: Form(
      key: _formKey,
      child: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Décrivez le problème rencontré. Les informations restent enregistrées localement sur cet appareil.', style: TextStyle(color: Colors.black54, height: 1.4)),
        const SizedBox(height: 22),
        const Text('Titre', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(controller: _title, maxLength: 70, decoration: const InputDecoration(hintText: 'Ex. Poubelle pleine'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Veuillez saisir un titre.' : null),
        const SizedBox(height: 12),
        const Text('Lieu', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(controller: _location, maxLength: 100, decoration: const InputDecoration(hintText: 'Quartier, rue ou repère'), validator: (v) => (v == null || v.trim().isEmpty) ? 'Veuillez préciser le lieu.' : null),
        const SizedBox(height: 12),
        const Text('Description', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextFormField(controller: _description, minLines: 4, maxLines: 6, maxLength: 500, decoration: const InputDecoration(hintText: 'Décrivez brièvement la situation…'), validator: (v) => (v == null || v.trim().length < 8) ? 'Ajoutez au moins 8 caractères.' : null),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: _saving ? null : _submit,
          icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check_circle_outline),
          label: Text(_saving ? 'Enregistrement…' : 'Enregistrer le signalement'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
        ),
      ]),
    ),
  );
}
