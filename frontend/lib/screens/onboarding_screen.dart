import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets/shark_guide.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingPage {
  final String emoji;
  final SharkMood mood;
  final String title;
  final String subtitle;
  final Color accentColor;
  final LinearGradient gradient;

  const _OnboardingPage({
    required this.emoji,
    required this.mood,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.gradient,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  int _currentPage = 0;
  String? _selectedGoal;
  String? _selectedLevel;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      emoji: '👋',
      mood: SharkMood.happy,
      title: 'Bienvenido a\nGeekShark',
      subtitle: 'Aprende a manejar tu dinero de forma simple, visual y gamificada. Como Duolingo, pero para tus finanzas.',
      accentColor: AppColors.cyan,
      gradient: AppGradients.navyDeepGradient,
    ),
    _OnboardingPage(
      emoji: '🎯',
      mood: SharkMood.thinking,
      title: '¿Cual es tu\nobjetivo?',
      subtitle: 'Cuéntame qué quieres lograr y personalizaré tu experiencia.',
      accentColor: AppColors.green,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.navy600, Color(0xFF0D2E20)],
      ),
    ),
    _OnboardingPage(
      emoji: '📊',
      mood: SharkMood.normal,
      title: '¿Cuanto sabes\nde finanzas?',
      subtitle: 'No te preocupes si empiezas desde cero. Aquí todos aprenden.',
      accentColor: AppColors.purple,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.navy700, Color(0xFF1A0D3C)],
      ),
    ),
    _OnboardingPage(
      emoji: '🚀',
      mood: SharkMood.celebration,
      title: 'Todo listo\npara empezar',
      subtitle: 'Tu camino hacia la inteligencia financiera comienza ahora.',
      accentColor: AppColors.amber,
      gradient: AppGradients.navyDeepGradient,
    ),
  ];

  final List<Map<String, String>> _goals = [
    {'emoji': '💰', 'label': 'Aprender a ahorrar'},
    {'emoji': '📈', 'label': 'Empezar a invertir'},
    {'emoji': '📊', 'label': 'Ordenar mis finanzas'},
    {'emoji': '🏦', 'label': 'Entender impuestos'},
  ];

  final List<Map<String, String>> _levels = [
    {'emoji': '🐣', 'label': 'Soy principiante'},
    {'emoji': '📖', 'label': 'Se lo básico'},
    {'emoji': '💡', 'label': 'Tengo experiencia'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _goToAuth();
    }
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AuthScreen(),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  bool get _canProceed {
    if (_currentPage == 1) return _selectedGoal != null;
    if (_currentPage == 2) return _selectedLevel != null;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final page = _pages[_currentPage];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(gradient: page.gradient),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _currentPage < _pages.length - 1
                      ? TextButton(
                          onPressed: _goToAuth,
                          child: Text(
                            'Saltar',
                            style: GoogleFonts.poppins(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(height: 44),
                ),
              ),

              // Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: _pages.length,
                  itemBuilder: (_, i) => _buildPage(i),
                ),
              ),

              // Bottom area
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  children: [
                    // Progress dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 24 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? page.accentColor
                                : AppColors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // CTA Button
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _canProceed ? 1.0 : 0.5,
                      child: GestureDetector(
                        onTap: _canProceed ? _nextPage : null,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [page.accentColor, page.accentColor.withOpacity(0.8)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: page.accentColor.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Crear mi cuenta'
                                  : 'Continuar',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _currentPage == _pages.length - 1
                                    ? AppColors.navy900
                                    : AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    final page = _pages[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shark
          Center(
            child: SharkGuide(size: 100, mood: page.mood),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            page.title,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            page.subtitle,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.white.withOpacity(0.65),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          // Page-specific content
          if (index == 1) _buildGoalSelector(),
          if (index == 2) _buildLevelSelector(),
          if (index == 3) _buildSummary(),
        ],
      ),
    );
  }

  Widget _buildGoalSelector() {
    return Column(
      children: _goals.map((g) {
        final isSelected = _selectedGoal == g['label'];
        return GestureDetector(
          onTap: () => setState(() => _selectedGoal = g['label']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.green.withOpacity(0.2)
                  : AppColors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? AppColors.green
                    : AppColors.white.withOpacity(0.12),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Text(g['emoji']!, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Text(
                  g['label']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.green : AppColors.white,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.green, size: 18),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLevelSelector() {
    return Column(
      children: _levels.map((l) {
        final isSelected = _selectedLevel == l['label'];
        return GestureDetector(
          onTap: () => setState(() => _selectedLevel = l['label']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.purple.withOpacity(0.2)
                  : AppColors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? AppColors.purple
                    : AppColors.white.withOpacity(0.12),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Text(l['emoji']!, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Text(
                  l['label']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.purple : AppColors.white,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.purple, size: 18),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummary() {
    final items = [
      {'icon': Icons.school_rounded, 'text': 'Lecciones personalizadas para ti'},
      {'icon': Icons.emoji_events_rounded, 'text': 'Gana XP y desbloquea logros'},
      {'icon': Icons.savings_rounded, 'text': 'Controla tus gastos y ahorros'},
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: AppColors.amber,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item['text'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
