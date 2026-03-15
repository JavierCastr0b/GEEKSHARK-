import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';
import 'lesson_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStreakCard(),
                const SizedBox(height: 20),
                _buildSectionTitle('Rutas de Aprendizaje'),
                const SizedBox(height: 12),
                ...MockData.learningPaths.map((p) => _buildPathCard(context, p)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: false,
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.navy700,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.navyDeepGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aprender',
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              'Domina tus finanzas paso a paso',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SharkGuide(size: 60, mood: SharkMood.happy),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard() {
    return GsCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A1038), Color(0xFF0B1628)],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Racha actual',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.white.withOpacity(0.6),
                ),
              ),
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 6),
                  Text(
                    '${MockData.userStreak} dias',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.amber,
                    ),
                  ),
                ],
              ),
              Text(
                'Sigue aprendiendo hoy',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total XP',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.white.withOpacity(0.6),
                ),
              ),
              Row(
                children: [
                  const Text('⭐', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 4),
                  Text(
                    '${MockData.userXP}',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.cyan,
                    ),
                  ),
                ],
              ),
              Text(
                'Nivel ${MockData.userLevel}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          // Mini week view
          const SizedBox(width: 16),
          Column(
            children: [
              Row(
                children: List.generate(7, (i) {
                  final active = i < MockData.userStreak;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active ? AppColors.amber : AppColors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                'Esta semana',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: AppColors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.navy800,
      ),
    );
  }

  Widget _buildPathCard(BuildContext context, LearningPath path) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GsCard(
        gradient: path.isLocked ? null : path.gradient,
        color: path.isLocked ? AppColors.white : null,
        onTap: path.isLocked
            ? () => _showLockedDialog(context)
            : () => _showPathDetail(context, path),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(path.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        path.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: path.isLocked ? AppColors.gray700 : AppColors.white,
                        ),
                      ),
                      Text(
                        path.description,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: path.isLocked
                              ? AppColors.gray400
                              : AppColors.white.withOpacity(0.6),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (path.isLocked)
                  const Icon(Icons.lock_rounded, color: AppColors.gray300, size: 22)
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${path.totalXP} XP',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),

            if (!path.isLocked) ...[
              const SizedBox(height: 16),
              // Lessons list
              ...path.lessons.asMap().entries.map((entry) {
                final i = entry.key;
                final lesson = entry.value;
                return _buildLessonItem(context, lesson, i, path);
              }),
            ] else ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline_rounded, color: AppColors.gray400, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Completa la ruta anterior para desbloquear',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, Lesson lesson, int index, LearningPath path) {
    return GestureDetector(
      onTap: lesson.isLocked
          ? null
          : () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LessonScreen(lesson: lesson, path: path),
                ),
              ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: lesson.isCompleted
              ? AppColors.white.withOpacity(0.15)
              : AppColors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: lesson.isCompleted
                ? AppColors.green.withOpacity(0.4)
                : AppColors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: lesson.isCompleted
                    ? AppColors.green
                    : lesson.isLocked
                        ? AppColors.white.withOpacity(0.1)
                        : AppColors.cyan.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                lesson.isCompleted
                    ? Icons.check_rounded
                    : lesson.isLocked
                        ? Icons.lock_rounded
                        : Icons.play_arrow_rounded,
                color: lesson.isCompleted
                    ? AppColors.white
                    : lesson.isLocked
                        ? AppColors.white.withOpacity(0.3)
                        : AppColors.cyan,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(lesson.emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: lesson.isLocked
                          ? AppColors.white.withOpacity(0.35)
                          : AppColors.white,
                    ),
                  ),
                  Text(
                    '${lesson.durationMinutes} min • +${lesson.xpReward} XP',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            if (lesson.isCompleted)
              const Text('⭐', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void _showLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔒', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              'Ruta bloqueada',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.navy800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Completa las lecciones de la ruta anterior para desbloquear esta.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.gray500,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Entendido',
                style: GoogleFonts.poppins(
                  color: AppColors.cyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPathDetail(BuildContext context, LearningPath path) {
    // Already shows inline
  }
}
