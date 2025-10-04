import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const BmiHomePage(),
    );
  }
}

class BmiHomePage extends StatefulWidget {
  const BmiHomePage({super.key});

  @override
  State<BmiHomePage> createState() => _BmiHomePageState();
}

class _BmiHomePageState extends State<BmiHomePage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController(); // kg
  final _heightController = TextEditingController(); // cm

  double? _bmi;
  String _category = '';
  Color _resultColor = Colors.grey.shade300;
  bool _showResult = false;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final weight = double.parse(_weightController.text.trim());
    final heightCm = double.parse(_heightController.text.trim());
    final heightM = heightCm / 100.0;

    if (heightM <= 0) return; // safety

    final bmi = weight / (heightM * heightM);

    final interpretation = _interpretBmi(bmi);

    setState(() {
      _bmi = bmi;
      _category = interpretation['label'] as String;
      _resultColor = interpretation['color'] as Color;
      _showResult = true;
    });
  }

  Map<String, Object> _interpretBmi(double bmi) {
    if (bmi < 18.5) {
      return {
        'label': 'Underweight',
        'color': Colors.lightBlue.shade400,
        'advice': 'Consider a nutritious, calorie-dense diet and consult a dietitian.'
      };
    } else if (bmi < 25) {
      return {
        'label': 'Normal',
        'color': Colors.green.shade400,
        'advice': 'Great! Keep a balanced diet and regular exercise.'
      };
    } else if (bmi < 30) {
      return {
        'label': 'Overweight',
        'color': Colors.orange.shade400,
        'advice': 'Focus on cardio and controlled diet; consult a professional if concerned.'
      };
    } else {
      return {
        'label': 'Obese',
        'color': Colors.redAccent.shade200,
        'advice': 'Seek medical advice and consider a structured weight-loss plan.'
      };
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _weightController.clear();
    _heightController.clear();
    setState(() {
      _bmi = null;
      _category = '';
      _showResult = false;
      _resultColor = Colors.grey.shade300;
    });
  }

  String? _numberValidator(String? value, {required String fieldName, double? min, double? max}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    final v = double.tryParse(value.trim());
    if (v == null) return 'Enter a valid number';
    if (v <= 0) return '$fieldName must be greater than zero';
    if (min != null && v < min) return '$fieldName seems too small';
    if (max != null && v > max) return '$fieldName seems too large';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.monitor_weight, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Text('BMI Calculator', style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 10,
                    color: Colors.white.withOpacity(0.08),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _weightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Weight (kg)',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.scale, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.04),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              ),
                              validator: (v) => _numberValidator(v, fieldName: 'Weight', min: 10, max: 500),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _heightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Height (cm)',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.height, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.04),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              ),
                              validator: (v) => _numberValidator(v, fieldName: 'Height', min: 50, max: 300),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _calculateBmi,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: const Text('Calculate BMI', style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                OutlinedButton(
                                  onPressed: _reset,
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.white24),
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text('Reset'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 350),
                              opacity: _showResult ? 1.0 : 0.0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: _showResult ? _resultColor.withOpacity(0.18) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _showResult && _bmi != null
                                    ? Column(
                                        children: [
                                          Text('Your BMI', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70)),
                                          const SizedBox(height: 6),
                                          Text(
                                            _bmi!.toStringAsFixed(1),
                                            style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(_category, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70)),
                                          const SizedBox(height: 8),
                                          Text(
                                            (_interpretBmi(_bmi!)['advice'] as String),
                                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Tip: Use kg and cm. BMI = weight(kg) ÷ (height(m) × height(m))',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.white60),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
