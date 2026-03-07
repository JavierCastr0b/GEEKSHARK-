import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/shark_guide.dart';

class TaxArticleScreen extends StatefulWidget {
  final TaxArticle article;

  const TaxArticleScreen({super.key, required this.article});

  @override
  State<TaxArticleScreen> createState() => _TaxArticleScreenState();
}

class _TaxArticleScreenState extends State<TaxArticleScreen> {
  int _expandedSection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeaderCard(),
                const SizedBox(height: 20),
                Text(
                  'Contenido',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy800,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.article.sections.asMap().entries.map(
                  (entry) => _buildSection(entry.key, entry.value),
                ),
                const SizedBox(height: 20),
                _buildSharkNote(),
                const SizedBox(height: 20),
                _buildRelatedArticles(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: widget.article.color,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, color: AppColors.white, size: 14),
                const SizedBox(width: 4),
                Text(
                  widget.article.readTime,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.article.color,
                widget.article.color.withBlue(
                    (widget.article.color.blue * 0.6).toInt()),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.article.emoji,
                      style: const TextStyle(fontSize: 40)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.article.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
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
        widget.article.title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildHeaderCard() {
    return GsCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          widget.article.color.withOpacity(0.12),
          widget.article.color.withOpacity(0.04),
        ],
      ),
      border: Border.all(color: widget.article.color.withOpacity(0.2)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.gray600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                      Icons.menu_book_rounded,
                      '${widget.article.sections.length} secciones',
                      widget.article.color),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                      Icons.star_border_rounded, 'Basico', AppColors.amber),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(int index, TaxSection section) {
    final isExpanded = _expandedSection == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GsCard(
        onTap: () => setState(
          () => _expandedSection = isExpanded ? -1 : index,
        ),
        border: isExpanded
            ? Border.all(color: widget.article.color.withOpacity(0.4))
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? widget.article.color
                        : AppColors.gray100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isExpanded ? AppColors.white : AppColors.gray500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy800,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isExpanded ? widget.article.color : AppColors.gray400,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 14),
              _buildSectionContent(section.content),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    final lines = content.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final isBullet = line.trimLeft().startsWith('•');
        final isNumbered = RegExp(r'^\d+\.').hasMatch(line.trim());

        if (isBullet) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: widget.article.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    line.replaceFirst('•', '').trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.gray700,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (isNumbered) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              line,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.gray700,
                height: 1.6,
              ),
            ),
          );
        } else if (line.startsWith('✓')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    line.substring(1).trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.gray700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.gray700,
                height: 1.6,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  Widget _buildSharkNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
      ),
      child: const SharkGuide(
        size: 52,
        mood: SharkMood.thinking,
        message: 'Recuerda: entender tus obligaciones tributarias no es complicado. Comienza por lo basico y ve avanzando. Un contador de confianza siempre es un buen aliado.',
      ),
    );
  }

  Widget _buildRelatedArticles(BuildContext context) {
    final related = MockData.taxArticles
        .where((a) => a.id != widget.article.id)
        .take(2)
        .toList();

    if (related.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Articulos relacionados',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.navy800,
          ),
        ),
        const SizedBox(height: 10),
        ...related.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GsCard(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => TaxArticleScreen(article: a),
                ),
              ),
              child: Row(
                children: [
                  Text(a.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy800,
                          ),
                        ),
                        Text(
                          a.readTime,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.gray400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.gray300, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
