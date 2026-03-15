import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/mock_data.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/shark_guide.dart';
import 'quiz_screen.dart';

class _FlashCardData {
  final String title;
  final String body;
  const _FlashCardData({required this.title, required this.body});
}

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

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final List<_FlashCardData> _cards;
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;

  int _currentCard = 0;
  int _furthestCard = 0;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _cards = _parseContent(widget.lesson.content);
    _pageController = PageController();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  List<_FlashCardData> _parseContent(String content) {
    final paragraphs =
        content.split('\n\n').where((p) => p.trim().isNotEmpty).toList();
    final cards = <_FlashCardData>[];
    int i = 0;

    while (i < paragraphs.length) {
      final p = paragraphs[i].trim();
      if (p.startsWith('**') && p.endsWith('**')) {
        final title = p.replaceAll('**', '');
        final bodyParts = <String>[];
        i++;
        while (i < paragraphs.length &&
            !(paragraphs[i].trim().startsWith('**') &&
                paragraphs[i].trim().endsWith('**'))) {
          bodyParts.add(paragraphs[i].trim());
          i++;
        }
        if (bodyParts.isNotEmpty) {
          cards.add(_FlashCardData(title: title, body: bodyParts.join('\n\n')));
        } else {
          cards.add(_FlashCardData(title: '', body: title));
        }
      } else {
        // Extract first sentence as title, rest as body
        final firstDot = p.indexOf('. ');
        final firstNewline = p.indexOf('\n');
        int splitAt = -1;
        if (firstDot != -1 && (firstNewline == -1 || firstDot < firstNewline)) {
          splitAt = firstDot + 1;
        } else if (firstNewline != -1) {
          splitAt = firstNewline;
        }

        if (splitAt != -1 && splitAt < p.length - 10) {
          final title = p.substring(0, splitAt).trim();
          final body = p.substring(splitAt).trim();
          cards.add(_FlashCardData(title: title, body: body));
        } else {
          // Too short to split — use full text as both title and body
          cards.add(_FlashCardData(title: p, body: p));
        }
        i++;
      }
    }

    if (cards.isEmpty) {
      cards.add(_FlashCardData(title: content, body: content));
    }

    return cards;
  }

  bool get _canProceed => _furthestCard >= _cards.length - 1;

  void _onPageChanged(int index) {
    setState(() {
      _currentCard = index;
      _isFlipped = false;
      if (index > _furthestCard) _furthestCard = index;
    });
    if (_flipController.value > 0) _flipController.reverse();
  }

  void _goNext() {
    if (_currentCard < _cards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goPrev() {
    if (_currentCard > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleFlip() {
    setState(() => _isFlipped = !_isFlipped);
    if (_isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          _buildAppBar(context),
          const SizedBox(height: 12),
          _buildCardCounter(),
          const SizedBox(height: 8),
          _buildProgressBar(),
          const SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                final isLast = index == _cards.length - 1;
                return _buildFlashCard(card, isLast);
              },
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: AppColors.navy700,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.path.title,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      widget.lesson.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardCounter() {
    return Text(
      'Tarjeta ${_currentCard + 1} de ${_cards.length}',
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.gray500,
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_furthestCard + 1) / _cards.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.gray200,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.cyan),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _canProceed ? '¡Todas vistas!' : 'Desliza para avanzar',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: _canProceed ? AppColors.cyan : AppColors.gray400,
                  fontWeight:
                      _canProceed ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              Row(
                children: List.generate(_cards.length, (i) {
                  final seen = i <= _furthestCard;
                  final active = i == _currentCard;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(left: 4),
                    width: active ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: seen ? AppColors.cyan : AppColors.gray200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlashCard(_FlashCardData card, bool isLast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _toggleFlip,
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            final angle = _flipAnimation.value * 3.14159;
            final isShowingFront = angle < 1.5708;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isShowingFront
                  ? _buildCardFront(card, isLast)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(3.14159),
                      child: _buildCardBack(card),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFront(_FlashCardData card, bool isLast) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.navy700,
            AppColors.navy500,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy800.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: emoji + flip hint
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.lesson.emoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.white.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.touch_app_rounded,
                                size: 13,
                                color: AppColors.white.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              'Toca para ver más',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: AppColors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                ...[
                  Text(
                    card.title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 2,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.cyan,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Hint to flip
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flip_rounded,
                          color: AppColors.white.withOpacity(0.3),
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Toca para ver la explicación',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Last card: shark message
                if (isLast) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.cyan.withOpacity(0.3)),
                    ),
                    child: SharkGuide(
                      size: 40,
                      mood: SharkMood.happy,
                      message:
                          '¡Excelente! Ya conoces todo el contenido. ¡Ahora pon a prueba lo aprendido!',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(_FlashCardData card) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cyan.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy800.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cyan.withOpacity(0.06),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.lightbulb_rounded,
                          color: AppColors.cyan, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        card.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navy700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleFlip,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.flip_rounded,
                                size: 12, color: AppColors.gray500),
                            const SizedBox(width: 4),
                            Text(
                              'Volver',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(height: 1, color: AppColors.gray100),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildCardBodyLight(card.body),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBody(String body) {
    final lines = body.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final trimmed = line.trim();
        if (trimmed.startsWith('•')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.cyan,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    trimmed.replaceFirst('•', '').trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.white.withOpacity(0.9),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (trimmed.startsWith('✓')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.cyan, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trimmed.replaceFirst('✓', '').trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.white.withOpacity(0.9),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return trimmed.isEmpty
            ? const SizedBox(height: 8)
            : Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  trimmed,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.white.withOpacity(0.85),
                    height: 1.6,
                  ),
                ),
              );
      }).toList(),
    );
  }

  Widget _buildCardBodyLight(String body) {
    final lines = body.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final trimmed = line.trim();
        if (trimmed.startsWith('•')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.cyan,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    trimmed.replaceFirst('•', '').trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.gray700,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (trimmed.startsWith('✓')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trimmed.replaceFirst('✓', '').trim(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.gray700,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return trimmed.isEmpty
            ? const SizedBox(height: 8)
            : Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  trimmed,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.gray700,
                    height: 1.6,
                  ),
                ),
              );
      }).toList(),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final isFirst = _currentCard == 0;
    final isLast = _currentCard == _cards.length - 1;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
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
            Row(
              children: [
                // Previous button
                GestureDetector(
                  onTap: isFirst ? null : _goPrev,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          isFirst ? AppColors.gray100 : AppColors.navy500,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: isFirst ? AppColors.gray300 : AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Next / Quiz button
                Expanded(
                  child: isLast
                      ? GsButton(
                          label: widget.lesson.quiz.isEmpty
                              ? 'Completar lección'
                              : 'Ir al quiz  →',
                          onTap: _canProceed
                              ? () {
                                  if (widget.lesson.quiz.isNotEmpty) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => QuizScreen(
                                            lesson: widget.lesson),
                                      ),
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          backgroundColor: _canProceed
                              ? AppColors.navy500
                              : AppColors.gray300,
                        )
                      : GestureDetector(
                          onTap: _goNext,
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.cyan,
                                  AppColors.cyan.withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Siguiente',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward_rounded,
                                    color: AppColors.white, size: 18),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
