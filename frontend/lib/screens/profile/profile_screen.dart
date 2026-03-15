import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import 'achievements_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                _buildStatsRow(),
                const SizedBox(height: 20),
                _buildLearningProgress(context),
                const SizedBox(height: 20),
                _buildAchievementsPreview(context),
                const SizedBox(height: 20),
                _buildMenuSection(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
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
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.settings_outlined,
                        color: AppColors.white),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ),
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppGradients.cyanGradient,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.3),
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          MockData.userName.substring(0, 1).toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.navy700,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '${MockData.userLevel}',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  MockData.userName,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  MockData.userEmail,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeaderBadge('🔥 ${MockData.userStreak} dias', AppColors.amber),
                    const SizedBox(width: 8),
                    _buildHeaderBadge('⭐ ${MockData.userXP} XP', AppColors.cyan),
                  ],
                ),
              ],
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            '${MockData.userXP}',
            'XP Total',
            Icons.star_rounded,
            AppColors.amber,
            AppColors.amberLight,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            '${MockData.userStreak}',
            'Racha dias',
            Icons.local_fire_department_rounded,
            AppColors.orange,
            AppColors.orangeLight,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            '${MockData.achievements.where((a) => a.isUnlocked).length}',
            'Logros',
            Icons.emoji_events_rounded,
            AppColors.purple,
            AppColors.purpleLight,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
      String value, String label, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy800.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.navy800,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningProgress(BuildContext context) {
    return GsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progreso de aprendizaje',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.navy800,
            ),
          ),
          const SizedBox(height: 14),
          ...MockData.learningPaths.map((path) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(path.emoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          path.title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: path.isLocked
                                ? AppColors.gray300
                                : AppColors.gray700,
                          ),
                        ),
                      ),
                      if (path.isLocked)
                        const Icon(Icons.lock_outline_rounded,
                            color: AppColors.gray300, size: 14)
                      else
                        Text(
                          '${(path.progress * 100).toInt()}%',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy500,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  GsProgressBar(
                    progress: path.isLocked ? 0 : path.progress,
                    height: 6,
                    foregroundColor: AppColors.cyan,
                    backgroundColor: path.isLocked
                        ? AppColors.gray100
                        : AppColors.gray100,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAchievementsPreview(BuildContext context) {
    final unlocked = MockData.achievements.where((a) => a.isUnlocked).toList();

    return GsCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AchievementsScreen()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Logros',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Ver todos',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.cyan, size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ...unlocked.take(4).map((a) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: a.color.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: a.color.withOpacity(0.3), width: 2),
                        ),
                        child: Center(
                          child: Text(a.emoji,
                              style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 52,
                        child: Text(
                          a.title,
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // Remaining count
              if (MockData.achievements.length > 4)
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '+${MockData.achievements.length - 4}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final sections = [
      {
        'title': 'Cuenta',
        'items': [
          {
            'icon': Icons.person_outline_rounded,
            'label': 'Editar perfil',
            'color': AppColors.navy500,
            'onTap': () {},
          },
          {
            'icon': Icons.notifications_outlined,
            'label': 'Notificaciones',
            'color': AppColors.amber,
            'onTap': () {},
          },
          {
            'icon': Icons.privacy_tip_outlined,
            'label': 'Privacidad',
            'color': AppColors.purple,
            'onTap': () {},
          },
        ],
      },
      {
        'title': 'App',
        'items': [
          {
            'icon': Icons.help_outline_rounded,
            'label': 'Ayuda y soporte',
            'color': AppColors.cyan,
            'onTap': () {},
          },
          {
            'icon': Icons.star_border_rounded,
            'label': 'Calificar la app',
            'color': AppColors.amber,
            'onTap': () {},
          },
          {
            'icon': Icons.settings_outlined,
            'label': 'Configuracion',
            'color': AppColors.gray500,
            'onTap': () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
          },
        ],
      },
      {
        'title': 'Sesion',
        'items': [
          {
            'icon': Icons.logout_rounded,
            'label': 'Cerrar sesion',
            'color': AppColors.red,
            'onTap': () {},
          },
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  section['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray400,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              GsCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: (section['items'] as List)
                      .asMap()
                      .entries
                      .map((entry) {
                    final item = entry.value as Map;
                    final isLast =
                        entry.key == (section['items'] as List).length - 1;
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          leading: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: item['color'] as Color,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item['label'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: item['color'] == AppColors.red
                                  ? AppColors.red
                                  : AppColors.gray800,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.gray300,
                            size: 20,
                          ),
                          onTap: item['onTap'] as VoidCallback,
                        ),
                        if (!isLast)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(height: 1),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
