import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_card.dart';

class SavingsGoalsScreen extends StatefulWidget {
  const SavingsGoalsScreen({super.key});

  @override
  State<SavingsGoalsScreen> createState() => _SavingsGoalsScreenState();
}

class _SavingsGoalsScreenState extends State<SavingsGoalsScreen> {
  final _titleController = TextEditingController();
  final _targetController = TextEditingController();
  final _currentController = TextEditingController();
  DateTime _deadline = DateTime.now().add(const Duration(days: 90));
  String _selectedEmoji = '🎯';

  final _emojis = ['🎯', '💻', '✈️', '🏠', '🚗', '📱', '🎓', '🛡️', '💍', '🌴'];

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    _currentController.dispose();
    super.dispose();
  }

  void _addGoal() {
    if (_titleController.text.isEmpty || _targetController.text.isEmpty) return;

    final target = double.tryParse(_targetController.text) ?? 0;
    final current = double.tryParse(_currentController.text) ?? 0;

    final colors = [AppColors.green, AppColors.cyan, AppColors.purple, AppColors.amber, AppColors.orange];
    final color = colors[MockData.savingsGoals.length % colors.length];

    MockData.savingsGoals.add(SavingsGoal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      targetAmount: target,
      currentAmount: current,
      deadline: _deadline,
      color: color,
      emoji: _selectedEmoji,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: AppColors.navy700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nueva meta de ahorro',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji picker
            _buildLabel('Elige un icono'),
            const SizedBox(height: 10),
            SizedBox(
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _emojis.length,
                itemBuilder: (_, i) {
                  final e = _emojis[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedEmoji = e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _selectedEmoji == e
                            ? AppColors.navy500
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _selectedEmoji == e
                              ? AppColors.navy500
                              : AppColors.gray200,
                        ),
                      ),
                      child: Center(
                        child: Text(e, style: const TextStyle(fontSize: 22)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            _buildLabel('Nombre de la meta'),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.gray800),
              decoration: InputDecoration(
                hintText: 'Ej: Laptop nueva, Viaje a Cusco...',
                prefixIcon: Text(
                  _selectedEmoji,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 52),
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Monto objetivo (S/.)'),
            const SizedBox(height: 8),
            TextField(
              controller: _targetController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.gray800),
              decoration: InputDecoration(
                hintText: 'Ej: 2500',
                prefixIcon: const Icon(Icons.flag_outlined, color: AppColors.gray400, size: 20),
                prefixText: 'S/. ',
                prefixStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.gray500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Ya tengo ahorrado (S/.) — opcional'),
            const SizedBox(height: 8),
            TextField(
              controller: _currentController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.gray800),
              decoration: InputDecoration(
                hintText: '0',
                prefixIcon: const Icon(Icons.savings_outlined, color: AppColors.gray400, size: 20),
                prefixText: 'S/. ',
                prefixStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.gray500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Fecha objetivo'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, color: AppColors.gray400, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _formatDate(_deadline),
                      style: GoogleFonts.poppins(fontSize: 14, color: AppColors.gray700),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.gray300),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Preview
            if (_titleController.text.isNotEmpty ||
                _targetController.text.isNotEmpty) ...[
              _buildLabel('Vista previa'),
              const SizedBox(height: 8),
              _buildPreview(),
              const SizedBox(height: 20),
            ],

            GsButton(
              label: 'Crear meta de ahorro',
              onTap: _addGoal,
              icon: Icons.add_rounded,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    final target = double.tryParse(_targetController.text) ?? 0;
    final current = double.tryParse(_currentController.text) ?? 0;
    final progress = target > 0 ? current / target : 0.0;

    return GsCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(_selectedEmoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titleController.text.isEmpty ? 'Mi meta' : _titleController.text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy800,
                  ),
                ),
                const SizedBox(height: 6),
                GsProgressBar(
                  progress: progress.clamp(0.0, 1.0),
                  height: 6,
                  foregroundColor: AppColors.green,
                  backgroundColor: AppColors.greenBg,
                ),
                const SizedBox(height: 4),
                Text(
                  target > 0
                      ? 'S/. ${current.toStringAsFixed(0)} / S/. ${target.toStringAsFixed(0)}'
                      : 'Ingresa el monto objetivo',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.gray700,
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (_, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.navy500),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  String _formatDate(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]}, ${date.year}';
  }
}
