import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/shark_guide.dart';
import '../../core/widgets/gs_card.dart';
import '../learn/lesson_screen.dart';
import '../savings/add_transaction_screen.dart';
import '../savings/savings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track which learning paths are expanded
  late final Map<String, bool> _expanded;

  @override
  void initState() {
    super.initState();
    // First unlocked path starts expanded, rest collapsed
    _expanded = {
      for (int i = 0; i < MockData.learningPaths.length; i++)
        MockData.learningPaths[i].id: i == 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                _buildSharkTip(context),
                const SizedBox(height: 24),
                _buildLearnSection(context),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12
        ? 'Buenos dias'
        : hour < 18
            ? 'Buenas tardes'
            : 'Buenas noches';

    return SliverAppBar(
      expandedHeight: 155,
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
                              '$greeting,',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.white.withOpacity(0.6),
                              ),
                            ),
                            Text(
                              MockData.userName,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.amber.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Text('🔥',
                                style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              '${MockData.userStreak} dias',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.cyan.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text('⭐',
                                style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 4),
                            Text(
                              '${MockData.userXP} XP',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.cyan,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nivel ${MockData.userLevel}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color:
                                        AppColors.white.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  '${MockData.userXP}/500 XP',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color:
                                        AppColors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            GsProgressBar(
                              progress: MockData.userXP / 500,
                              height: 6,
                              foregroundColor: AppColors.cyan,
                              backgroundColor:
                                  AppColors.white.withOpacity(0.15),
                            ),
                          ],
                        ),
                      ),
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

  // ── Stats ──────────────────────────────────────────────────────────
  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GsStatCard(
            label: 'Ahorros',
            value: 'S/. ${MockData.totalSavings.toStringAsFixed(0)}',
            subtitle: 'Este mes',
            icon: Icons.savings_rounded,
            iconColor: AppColors.green,
            iconBg: AppColors.greenBg,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GsStatCard(
            label: 'Gastos',
            value: 'S/. ${MockData.totalExpenses.toStringAsFixed(0)}',
            subtitle: 'Este mes',
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.red,
            iconBg: AppColors.redLight,
          ),
        ),
      ],
    );
  }

  // ── Quick Actions ──────────────────────────────────────────────────
  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'icon': Icons.add_circle_rounded,
        'label': 'Registrar\ngasto',
        'color': AppColors.red,
        'bg': AppColors.redLight,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const AddTransactionScreen()),
            ),
      },
      {
        'icon': Icons.savings_rounded,
        'label': 'Registrar\ningreso',
        'color': AppColors.green,
        'bg': AppColors.greenBg,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) =>
                      const AddTransactionScreen(isIncome: true)),
            ),
      },
      {
        'icon': Icons.school_rounded,
        'label': 'Nueva\nleccion',
        'color': AppColors.navy500,
        'bg': AppColors.gray100,
        'onTap': () {},
      },
      {
        'icon': Icons.receipt_long_rounded,
        'label': 'Impuestos',
        'color': AppColors.purple,
        'bg': AppColors.purpleLight,
        'onTap': () {},
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones rapidas',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.navy800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: actions.map((a) {
            return Expanded(
              child: GestureDetector(
                onTap: a['onTap'] as VoidCallback,
                child: Container(
                  margin: EdgeInsets.only(
                      right: a == actions.last ? 0 : 10),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: a['bg'] as Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          a['icon'] as IconData,
                          color: a['color'] as Color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        a['label'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray700,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Learn Section ──────────────────────────────────────────────────
  Widget _buildLearnSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with streak
        Row(
          children: [
            Expanded(
              child: Text(
                'Aprender',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy800,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppColors.amber.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text(
                    '${MockData.userStreak} dias · ${MockData.userXP} XP',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Collapsible path cards
        ...MockData.learningPaths
            .map((p) => _buildCollapsiblePath(context, p)),
      ],
    );
  }

  Widget _buildCollapsiblePath(BuildContext context, LearningPath path) {
    final isExpanded = _expanded[path.id] ?? false;
    final completedCount =
        path.lessons.where((l) => l.isCompleted).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: path.isLocked ? null : path.gradient,
          color: path.isLocked ? AppColors.white : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy800.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Header row (always visible, tap to toggle) ──
            GestureDetector(
              onTap: path.isLocked
                  ? () => _showLockedDialog(context)
                  : () => setState(
                      () => _expanded[path.id] = !isExpanded),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(path.emoji,
                        style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            path.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: path.isLocked
                                  ? AppColors.gray700
                                  : AppColors.white,
                            ),
                          ),
                          Text(
                            path.isLocked
                                ? 'Bloqueado'
                                : '$completedCount/${path.lessons.length} lecciones',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: path.isLocked
                                  ? AppColors.gray400
                                  : AppColors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (path.isLocked)
                      const Icon(Icons.lock_rounded,
                          color: AppColors.gray300, size: 20)
                    else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
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
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.white.withOpacity(0.8),
                          size: 22,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // ── Progress bar (only when not locked) ──
            if (!path.isLocked && path.lessons.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: GsProgressBar(
                  progress: path.progress,
                  height: 4,
                  backgroundColor: AppColors.white.withOpacity(0.15),
                  gradient: const LinearGradient(
                      colors: [AppColors.cyan, AppColors.green]),
                ),
              ),
            ],

            // ── Collapsible lessons list ──
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded && !path.isLocked
                  ? Padding(
                      padding:
                          const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      child: Column(
                        children: path.lessons
                            .asMap()
                            .entries
                            .map((e) => _buildLessonItem(
                                context, e.value, e.key, path))
                            .toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(
      BuildContext context, Lesson lesson, int index, LearningPath path) {
    return GestureDetector(
      onTap: lesson.isLocked
          ? null
          : () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      LessonScreen(lesson: lesson, path: path),
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
                    '${lesson.durationMinutes} min · +${lesson.xpReward} XP',
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  // ── Savings Summary ────────────────────────────────────────────────
  Widget _buildSavingsSummary(BuildContext context) {
    final goal = MockData.savingsGoals.first;
    return GsCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SavingsScreen()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(goal.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  goal.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy800,
                  ),
                ),
              ),
              GsBadge(
                label: '${(goal.progress * 100).toInt()}%',
                color: AppColors.green,
              ),
            ],
          ),
          const SizedBox(height: 12),
          GsProgressBar(
            progress: goal.progress,
            height: 8,
            gradient: AppGradients.greenGradient,
            showLabel: false,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'S/. ${goal.currentAmount.toStringAsFixed(0)} ahorrados',
                style: GoogleFonts.poppins(
                    fontSize: 12, color: AppColors.gray500),
              ),
              Text(
                'Meta: S/. ${goal.targetAmount.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Shark Tip ──────────────────────────────────────────────────────
  Widget _buildSharkTip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
      ),
      child: const SharkGuide(
        size: 56,
        mood: SharkMood.thinking,
        message:
            'Tip del dia: Intenta ahorrar antes de gastar. Separa tu ahorro apenas recibes tu salario y trata ese dinero como un gasto fijo.',
      ),
    );
  }

}
