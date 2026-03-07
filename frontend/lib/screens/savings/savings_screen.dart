import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';
import 'add_transaction_screen.dart';
import 'savings_goals_screen.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _selectedCategory = 'Todos';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          _buildAppBar(context),
        ],
        body: Column(
          children: [
            // Tab bar
            Container(
              color: AppColors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.navy500,
                unselectedLabelColor: AppColors.gray400,
                indicatorColor: AppColors.navy500,
                indicatorWeight: 2,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Transacciones'),
                  Tab(text: 'Metas'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTransactionsTab(),
                  _buildGoalsTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
          setState(() {});
        },
        backgroundColor: AppColors.navy500,
        icon: const Icon(Icons.add_rounded, color: AppColors.white),
        label: Text(
          'Registrar',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final savingsRate = MockData.savingsRate;

    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
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
                  Text(
                    'Ahorros',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enero 2025',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Main stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat(
                          'Ingresos',
                          'S/. ${MockData.totalIncome.toStringAsFixed(0)}',
                          Icons.arrow_upward_rounded,
                          AppColors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildHeaderStat(
                          'Gastos',
                          'S/. ${MockData.totalExpenses.toStringAsFixed(0)}',
                          Icons.arrow_downward_rounded,
                          AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text('💰', style: TextStyle(fontSize: 22)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahorro del mes',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.white.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                'S/. ${MockData.totalSavings.toStringAsFixed(0)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${(savingsRate * 100).toInt()}% ahorrado',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: savingsRate >= 0.2
                                    ? AppColors.green
                                    : AppColors.amber,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 80,
                              child: GsProgressBar(
                                progress: savingsRate,
                                height: 6,
                                gradient: AppGradients.greenGradient,
                                backgroundColor:
                                    AppColors.white.withOpacity(0.15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        collapseMode: CollapseMode.parallax,
      ),
      title: Text(
        'Ahorros',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildHeaderStat(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.white.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    final categories = ['Todos', ...MockData.categories.map((c) => c.name)];
    final filtered = _selectedCategory == 'Todos'
        ? MockData.transactions
        : MockData.transactions
            .where((t) => t.category == _selectedCategory)
            .toList();

    return Column(
      children: [
        // Chart
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: _buildExpenseChart(),
        ),

        const SizedBox(height: 12),

        // Category filter
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (_, i) {
              final cat = categories[i];
              final isSelected = _selectedCategory == cat;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.navy500 : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.navy500 : AppColors.gray200,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppColors.white : AppColors.gray600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Transaction list
        Expanded(
          child: filtered.isEmpty
              ? GsEmptyState(
                  emoji: '📭',
                  title: 'Sin transacciones',
                  subtitle: 'No hay transacciones en esta categoria',
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final t = filtered[filtered.length - 1 - i];
                    return _buildTransactionTile(t);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildExpenseChart() {
    final categoryTotals = <String, double>{};
    for (final t in MockData.transactions.where((t) => !t.isIncome)) {
      categoryTotals[t.category] =
          (categoryTotals[t.category] ?? 0) + t.amount;
    }

    final entries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = [
      AppColors.navy500,
      AppColors.cyan,
      AppColors.green,
      AppColors.purple,
      AppColors.amber,
      AppColors.red,
      AppColors.orange,
    ];

    final sections = entries.asMap().entries.map((entry) {
      final i = entry.key;
      final e = entry.value;
      return PieChartSectionData(
        value: e.value,
        color: colors[i % colors.length],
        radius: 40,
        title: '',
        showTitle: false,
      );
    }).toList();

    return GsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distribucion de gastos',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.navy800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 24,
                    sectionsSpace: 2,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: entries.asMap().entries.take(4).map((entry) {
                    final i = entry.key;
                    final e = entry.value;
                    final pct = (e.value / MockData.totalExpenses * 100).toInt();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: colors[i % colors.length],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              e.key,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.gray600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '$pct%',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Transaction t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy800.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: t.isIncome ? AppColors.greenBg : AppColors.gray50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(t.categoryEmoji, style: const TextStyle(fontSize: 20)),
          ),
        ),
        title: Text(
          t.title,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray800,
          ),
        ),
        subtitle: Text(
          '${t.category} • ${_formatDate(t.date)}',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.gray400,
          ),
        ),
        trailing: Text(
          '${t.isIncome ? '+' : '-'} S/. ${t.amount.toStringAsFixed(0)}',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: t.isIncome ? AppColors.green : AppColors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      children: [
        _buildSharkAdvice(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mis metas',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.navy800,
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SavingsGoalsScreen()),
              ),
              icon: const Icon(Icons.add_rounded, size: 16, color: AppColors.cyan),
              label: Text(
                'Nueva meta',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.cyan,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...MockData.savingsGoals.map((g) => _buildGoalCard(g)),
      ],
    );
  }

  Widget _buildSharkAdvice() {
    final rate = MockData.savingsRate;
    String message;
    SharkMood mood;
    if (rate >= 0.2) {
      message = '¡Excelente! Estas ahorrando el ${(rate * 100).toInt()}% de tus ingresos. Vas por buen camino hacia la libertad financiera.';
      mood = SharkMood.celebration;
    } else if (rate >= 0.1) {
      message = 'Vas bien, pero puedes mejorar. Intenta llegar al 20% de ahorro mensual reduciendo gastos en entretenimiento.';
      mood = SharkMood.normal;
    } else {
      message = 'Este mes gastaste mas de lo que ingresaste. Revisemos juntos tus gastos para mejorar.';
      mood = SharkMood.thinking;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
      ),
      child: SharkGuide(size: 52, mood: mood, message: message),
    );
  }

  Widget _buildGoalCard(SavingsGoal goal) {
    final remaining = goal.targetAmount - goal.currentAmount;
    final daysLeft = goal.deadline.difference(DateTime.now()).inDays;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: goal.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(goal.emoji, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy800,
                        ),
                      ),
                      Text(
                        '$daysLeft dias restantes',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: daysLeft < 30 ? AppColors.amber : AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(goal.progress * 100).toInt()}%',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: goal.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GsProgressBar(
              progress: goal.progress,
              height: 8,
              foregroundColor: goal.color,
              backgroundColor: goal.color.withOpacity(0.1),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'S/. ${goal.currentAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: goal.color,
                  ),
                ),
                Text(
                  'Faltan S/. ${remaining.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.gray400,
                  ),
                ),
                Text(
                  'Meta: S/. ${goal.targetAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ],
        ),
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
