import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/shark_guide.dart';
import '../../core/widgets/gs_card.dart';
import '../learn/learn_screen.dart';
import '../savings/savings_screen.dart';
import '../savings/add_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                _buildStatsRow(context),
                const SizedBox(height: 20),
                _buildContinueLearning(context),
                const SizedBox(height: 20),
                _buildQuickActions(context),
                const SizedBox(height: 20),
                _buildSavingsSummary(context),
                const SizedBox(height: 20),
                _buildSharkTip(context),
                const SizedBox(height: 20),
                _buildRecentActivity(context),
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
      expandedHeight: 200,
      pinned: true,
      stretch: true,
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
                      // Streak badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.amber.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Text('🔥', style: TextStyle(fontSize: 14)),
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
                      // Notifications
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
                  // XP Bar
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.cyan.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Text('⭐', style: TextStyle(fontSize: 12)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nivel ${MockData.userLevel}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.white.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  '${MockData.userXP}/500 XP',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            GsProgressBar(
                              progress: MockData.userXP / 500,
                              height: 6,
                              foregroundColor: AppColors.cyan,
                              backgroundColor: AppColors.white.withOpacity(0.15),
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
        collapseMode: CollapseMode.parallax,
      ),
      title: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Geek',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: 'Shark',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.cyan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildContinueLearning(BuildContext context) {
    final path = MockData.learningPaths.first;
    final nextLesson = path.lessons.firstWhere(
      (l) => !l.isCompleted,
      orElse: () => path.lessons.last,
    );

    return GsCard(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LearnScreen()),
      ),
      gradient: AppGradients.navyGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cyan.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'CONTINUAR',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cyan,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${path.lessons.where((l) => l.isCompleted).length}/${path.lessons.length} lecciones',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(nextLesson.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nextLesson.title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      nextLesson.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.white.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.navy900,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GsProgressBar(
            progress: path.progress,
            height: 6,
            backgroundColor: AppColors.white.withOpacity(0.1),
            gradient: const LinearGradient(colors: [AppColors.cyan, AppColors.green]),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'icon': Icons.add_circle_rounded,
        'label': 'Registrar\ngasto',
        'color': AppColors.red,
        'bg': AppColors.redLight,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
            ),
      },
      {
        'icon': Icons.savings_rounded,
        'label': 'Registrar\ningreso',
        'color': AppColors.green,
        'bg': AppColors.greenBg,
        'onTap': () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const AddTransactionScreen(isIncome: true)),
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
                    right: a == actions.last ? 0 : 10,
                  ),
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
                  fontSize: 12,
                  color: AppColors.gray500,
                ),
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
        message: 'Tip del dia: Intenta ahorrar antes de gastar. Separa tu ahorro apenas recibes tu salario y trata ese dinero como un gasto fijo.',
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final recent = MockData.transactions.reversed.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Actividad reciente',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.navy800,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SavingsScreen()),
              ),
              child: Text(
                'Ver todo',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.cyan,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...recent.map((t) => _buildTransactionItem(t)),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
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
          Text(t.categoryEmoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.title,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray800,
                  ),
                ),
                Text(
                  t.category,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${t.isIncome ? '+' : '-'} S/. ${t.amount.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: t.isIncome ? AppColors.green : AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
