import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final LearningPath path;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.path,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final _scrollController = ScrollController();
  double _readProgress = 0.0;
  bool _canProceed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    if (max > 0) {
      final progress = _scrollController.offset / max;
      setState(() {
        _readProgress = progress.clamp(0.0, 1.0);
        _canProceed = progress >= 0.7;
      });
    } else {
      setState(() {
        _readProgress = 1.0;
        _canProceed = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildAppBar(context),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildLessonHeader(),
                    const SizedBox(height: 20),
                    _buildContent(),
                    const SizedBox(height: 20),
                    _buildSharkNote(),
                  ]),
                ),
              ),
            ],
          ),
          // Bottom action bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context),
          ),
          // Read progress bar at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                value: _readProgress,
                backgroundColor: AppColors.gray200,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.navy700,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.path.title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.white.withOpacity(0.8),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.cyan.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Text('⭐', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                '+${widget.lesson.xpReward} XP',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cyan,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLessonHeader() {
    return GsCard(
      gradient: widget.path.gradient,
      child: Row(
        children: [
          Text(widget.lesson.emoji, style: const TextStyle(fontSize: 44)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lesson.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.lesson.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.white.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPill(
                      Icons.timer_outlined,
                      '${widget.lesson.durationMinutes} min',
                    ),
                    const SizedBox(width: 8),
                    _buildPill(
                      Icons.quiz_outlined,
                      '${widget.lesson.quiz.length} preguntas',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white.withOpacity(0.7), size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final paragraphs = widget.lesson.content
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((p) => _buildParagraph(p)).toList(),
    );
  }

  Widget _buildParagraph(String text) {
    final isBulletBlock = text.contains('\n•');

    if (isBulletBlock) {
      final lines = text.split('\n');
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lines.map((line) {
            final isBullet = line.trimLeft().startsWith('•');
            if (isBullet) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.cyan,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        line.replaceFirst('•', '').trim(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.gray700,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _buildStyledText(line);
            }
          }).toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _buildStyledText(text),
    );
  }

  Widget _buildStyledText(String text) {
    if (text.startsWith('**') && text.endsWith('**')) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          text.replaceAll('**', ''),
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.navy800,
          ),
        ),
      );
    }

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: AppColors.gray700,
        height: 1.7,
      ),
    );
  }

  Widget _buildSharkNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyan.withOpacity(0.08),
            AppColors.navy500.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.2)),
      ),
      child: const SharkGuide(
        size: 52,
        mood: SharkMood.thinking,
        message: 'Recuerda: el conocimiento financiero es una inversion en ti mismo. Cada leccion que completas te acerca mas a tu libertad financiera.',
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.navy800.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_canProceed) ...[
              Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.gray400, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Lee el contenido para continuar al quiz',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            GsButton(
              label: widget.lesson.quiz.isEmpty
                  ? 'Completar leccion'
                  : 'Ir al quiz  →',
              onTap: _canProceed
                  ? () {
                      if (widget.lesson.quiz.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(lesson: widget.lesson),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  : null,
              backgroundColor: _canProceed ? AppColors.navy500 : AppColors.gray300,
            ),
          ],
        ),
      ),
    );
  }
}
