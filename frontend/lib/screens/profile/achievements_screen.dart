import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unlocked = MockData.achievements.where((a) => a.isUnlocked).toList();
    final locked = MockData.achievements.where((a) => !a.isUnlocked).toList();

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.navy700,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white),
              onPressed: () => Navigator.pop(context),
            ),
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppGradients.navyDeepGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Logros',
                                style: GoogleFonts.poppins(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                '${unlocked.length} de ${MockData.achievements.length} desbloqueados',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppColors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text('🏆', style: TextStyle(fontSize: 44)),
                      ],
                    ),
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
            ),
            title: Text(
              'Logros',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar
                  GsCard(
                    gradient: AppGradients.navyGradient,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progreso total',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.white.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              '${unlocked.length}/${MockData.achievements.length}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.amber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GsProgressBar(
                          progress: unlocked.length / MockData.achievements.length,
                          height: 8,
                          gradient: AppGradients.amberGradient,
                          backgroundColor: AppColors.white.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (unlocked.isNotEmpty) ...[
                    Text(
                      'Desbloqueados (${unlocked.length})',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAchievementGrid(unlocked, isUnlocked: true),
                    const SizedBox(height: 24),
                  ],

                  Text(
                    'Por desbloquear (${locked.length})',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAchievementGrid(locked, isUnlocked: false),

                  const SizedBox(height: 24),
                  _buildSharkMotivation(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementGrid(List<Achievement> achievements,
      {required bool isUnlocked}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length,
      itemBuilder: (_, i) {
        final a = achievements[i];
        return _buildAchievementCard(a, isUnlocked: isUnlocked);
      },
    );
  }

  Widget _buildAchievementCard(Achievement achievement,
      {required bool isUnlocked}) {
    return GsCard(
      padding: const EdgeInsets.all(10),
      color: isUnlocked ? AppColors.white : AppColors.gray50,
      border: isUnlocked
          ? Border.all(color: achievement.color.withOpacity(0.3), width: 1.5)
          : Border.all(color: AppColors.gray200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge circle
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? achievement.color.withOpacity(0.12)
                  : AppColors.gray100,
              shape: BoxShape.circle,
              border: isUnlocked
                  ? Border.all(
                      color: achievement.color.withOpacity(0.4), width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                achievement.emoji,
                style: TextStyle(
                  fontSize: 22,
                  color: isUnlocked ? null : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            achievement.title,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isUnlocked ? AppColors.navy800 : AppColors.gray300,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isUnlocked && achievement.unlockedAt != null) ...[
            const SizedBox(height: 2),
            Text(
              _formatDate(achievement.unlockedAt!),
              style: GoogleFonts.poppins(
                fontSize: 9,
                color: AppColors.gray400,
              ),
            ),
          ] else if (!isUnlocked) ...[
            const SizedBox(height: 4),
            const Icon(Icons.lock_rounded, color: AppColors.gray300, size: 14),
          ],
        ],
      ),
    );
  }

  Widget _buildSharkMotivation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
      ),
      child: const SharkGuide(
        size: 52,
        mood: SharkMood.celebration,
        message: '¡Cada logro desbloqueado es un paso mas hacia tu libertad financiera! Sigue aprendiendo y los logros vendran solos.',
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
