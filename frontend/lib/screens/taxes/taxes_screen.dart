import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';
import 'tax_article_screen.dart';

class TaxesScreen extends StatelessWidget {
  const TaxesScreen({super.key});

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
                _buildDisclaimerCard(),
                const SizedBox(height: 20),
                _buildChecklist(),
                const SizedBox(height: 20),
                _buildSectionTitle('Guias y articulos'),
                const SizedBox(height: 12),
                ...MockData.taxArticles.map(
                  (a) => _buildArticleCard(context, a),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      backgroundColor: AppColors.navy700,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A0D3C), AppColors.navy800],
            ),
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
                          'Impuestos',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          'Entiende SUNAT sin complicaciones',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildPill(Icons.menu_book_rounded, '5 guias'),
                            const SizedBox(width: 8),
                            _buildPill(Icons.lightbulb_outline_rounded, 'Nivel basico'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SharkGuide(size: 70, mood: SharkMood.normal),
                ],
              ),
            ),
          ),
        ),
        collapseMode: CollapseMode.parallax,
      ),
      title: Text(
        'Impuestos',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white.withOpacity(0.7), size: 13),
          const SizedBox(width: 5),
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

  Widget _buildDisclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.amberLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.amber.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Este contenido es educativo, no asesoría legal ni tributaria. Para casos específicos, consulta un contador o asesor tributario.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.gray700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist() {
    final items = [
      {'check': true, 'text': 'Tengo mi DNI vigente'},
      {'check': true, 'text': 'Se que es el RUC'},
      {'check': false, 'text': 'Tengo RUC activo'},
      {'check': false, 'text': 'Emito comprobantes electronicos'},
      {'check': false, 'text': 'Declaro mis ingresos anuales'},
      {'check': false, 'text': 'Tengo clave SOL activa'},
    ];

    return GsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.navy500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.checklist_rounded, color: AppColors.navy500, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                'Checklist tributario basico',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          ...items.map((item) {
            final checked = item['check'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: checked ? AppColors.green : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: checked ? AppColors.green : AppColors.gray300,
                        width: 1.5,
                      ),
                    ),
                    child: checked
                        ? const Icon(Icons.check_rounded, color: AppColors.white, size: 13)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item['text'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: checked ? AppColors.gray600 : AppColors.gray800,
                      decoration: checked ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            );
          }),
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

  Widget _buildArticleCard(BuildContext context, TaxArticle article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GsCard(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TaxArticleScreen(article: article),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: article.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(article.emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    article.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.gray500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 12, color: AppColors.gray400),
                      const SizedBox(width: 4),
                      Text(
                        article.readTime,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.gray300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${article.sections.length} secciones',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.gray300, size: 20),
          ],
        ),
      ),
    );
  }
}
