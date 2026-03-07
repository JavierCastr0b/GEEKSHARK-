import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentQuestion = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _correctCount = 0;
  late final AnimationController _feedbackController;
  late final Animation<double> _feedbackScale;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _feedbackScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  QuizQuestion get _currentQ =>
      widget.lesson.quiz[_currentQuestion];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _currentQ.correctIndex) _correctCount++;
    });
    _feedbackController.forward(from: 0);
  }

  void _nextQuestion() {
    if (_currentQuestion < widget.lesson.quiz.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
      });
      _feedbackController.reset();
    } else {
      _showResult();
    }
  }

  void _showResult() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          lesson: widget.lesson,
          correctCount: _correctCount,
          totalCount: widget.lesson.quiz.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.lesson.quiz.length;
    final progress = (_currentQuestion + 1) / total;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GsIconButton(
                    icon: Icons.close_rounded,
                    onTap: () => _showExitDialog(context),
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        GsProgressBar(
                          progress: progress,
                          height: 8,
                          gradient: AppGradients.cyanGradient,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_currentQuestion + 1}/$total',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Shark + question
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SharkGuide(size: 64, mood: SharkMood.thinking),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.navy700,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              _currentQ.question,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Options
                    ..._currentQ.options.asMap().entries.map((entry) {
                      return _buildOption(entry.key, entry.value);
                    }),

                    // Feedback panel
                    if (_answered) ...[
                      const SizedBox(height: 16),
                      ScaleTransition(
                        scale: _feedbackScale,
                        child: _buildFeedbackPanel(),
                      ),
                    ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            if (_answered)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: GsButton(
                  label: _currentQuestion < widget.lesson.quiz.length - 1
                      ? 'Siguiente pregunta'
                      : 'Ver resultado',
                  onTap: _nextQuestion,
                  backgroundColor: _selectedAnswer == _currentQ.correctIndex
                      ? AppColors.green
                      : AppColors.navy500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, String text) {
    Color bgColor = AppColors.white;
    Color borderColor = AppColors.gray200;
    Color textColor = AppColors.gray800;
    IconData? trailingIcon;

    if (_answered) {
      if (index == _currentQ.correctIndex) {
        bgColor = AppColors.greenBg;
        borderColor = AppColors.green;
        textColor = AppColors.greenDark;
        trailingIcon = Icons.check_circle_rounded;
      } else if (index == _selectedAnswer) {
        bgColor = AppColors.redLight;
        borderColor = AppColors.red;
        textColor = AppColors.red;
        trailingIcon = Icons.cancel_rounded;
      }
    } else if (_selectedAnswer == index) {
      bgColor = AppColors.gray100;
      borderColor = AppColors.navy500;
      textColor = AppColors.navy800;
    }

    return GestureDetector(
      onTap: () => _selectAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy800.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: _answered && index == _currentQ.correctIndex
                    ? AppColors.green
                    : _answered && index == _selectedAnswer
                        ? AppColors.red
                        : AppColors.gray100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _answered &&
                            (index == _currentQ.correctIndex ||
                                index == _selectedAnswer)
                        ? AppColors.white
                        : AppColors.gray500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: index == _currentQ.correctIndex
                    ? AppColors.green
                    : AppColors.red,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackPanel() {
    final isCorrect = _selectedAnswer == _currentQ.correctIndex;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect ? AppColors.greenBg : AppColors.redLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCorrect ? AppColors.green : AppColors.red,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? '✅' : '❌',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? '¡Correcto!' : 'No fue esa',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isCorrect ? AppColors.greenDark : AppColors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentQ.explanation,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isCorrect ? AppColors.greenDark : AppColors.red,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SharkGuide(size: 60, mood: SharkMood.thinking),
            const SizedBox(height: 12),
            Text(
              'Salir del quiz?',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.navy800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Perderás tu progreso en este quiz si sales ahora.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.gray500,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Quedarme',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    child: Text(
                      'Salir',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Quiz Result Screen ───────────────────────────────────────────────────────

class QuizResultScreen extends StatelessWidget {
  final Lesson lesson;
  final int correctCount;
  final int totalCount;

  const QuizResultScreen({
    super.key,
    required this.lesson,
    required this.correctCount,
    required this.totalCount,
  });

  double get score => correctCount / totalCount;
  bool get passed => score >= 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              SharkGuide(
                size: 120,
                mood: passed ? SharkMood.celebration : SharkMood.thinking,
              ),
              const SizedBox(height: 24),
              Text(
                passed ? '¡Excelente trabajo!' : 'Sigue intentando',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navy800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                passed
                    ? 'Completaste el quiz con exito y ganaste XP'
                    : 'Puedes repasar la leccion y volver a intentarlo',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.gray500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Score card
              GsCard(
                gradient: passed ? AppGradients.greenGradient : AppGradients.navyGradient,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Correctas', '$correctCount/$totalCount', '✅'),
                        _buildStatDivider(),
                        _buildStat('Puntuacion', '${(score * 100).toInt()}%', '📊'),
                        _buildStatDivider(),
                        _buildStat('XP ganado', passed ? '+${lesson.xpReward}' : '+${(lesson.xpReward * 0.3).toInt()}', '⭐'),
                      ],
                    ),
                    if (passed) ...[
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🏅', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            'Leccion desbloqueada',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const Spacer(),

              if (passed)
                GsButton(
                  label: 'Siguiente leccion',
                  onTap: () {
                    // Mark as completed and pop back
                    lesson.isCompleted = true;
                    Navigator.of(context)
                      ..pop()
                      ..pop()
                      ..pop();
                  },
                  backgroundColor: AppColors.green,
                  icon: Icons.arrow_forward_rounded,
                )
              else ...[
                GsButton(
                  label: 'Repasar leccion',
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                ),
                const SizedBox(height: 12),
                GsButton.secondary(
                  label: 'Intentar quiz de nuevo',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(lesson: lesson),
                      ),
                    );
                  },
                ),
              ],

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.white.withOpacity(0.2),
    );
  }
}
