import 'package:flutter/material.dart';
import '../theme.dart';

enum SharkMood { normal, happy, celebration, thinking }

class SharkGuide extends StatelessWidget {
  final double size;
  final SharkMood mood;
  final String? message;

  const SharkGuide({
    super.key,
    this.size = 80,
    this.mood = SharkMood.normal,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildShark(),
          const SizedBox(width: 12),
          Expanded(child: _buildBubble(context)),
        ],
      );
    }
    return _buildShark();
  }

  Widget _buildShark() {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SharkPainter(mood: mood),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy500.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        message!,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.gray700,
          height: 1.5,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class _SharkPainter extends CustomPainter {
  final SharkMood mood;

  _SharkPainter({required this.mood});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Body paint
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.navy400, AppColors.navy700],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final suitPaint = Paint()
      ..color = AppColors.navy800
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final cyanPaint = Paint()
      ..color = AppColors.cyan
      ..style = PaintingStyle.fill;

    final darkPaint = Paint()
      ..color = AppColors.navy900
      ..style = PaintingStyle.fill;

    // ── Body (rounded ellipse) ──────────────────────────────
    final bodyRect = Rect.fromLTWH(w * 0.1, h * 0.25, w * 0.8, h * 0.6);
    final bodyRRect = RRect.fromRectAndCorners(
      bodyRect,
      topLeft: Radius.circular(w * 0.38),
      topRight: Radius.circular(w * 0.38),
      bottomLeft: Radius.circular(w * 0.28),
      bottomRight: Radius.circular(w * 0.28),
    );
    canvas.drawRRect(bodyRRect, bodyPaint);

    // ── Dorsal fin ──────────────────────────────────────────
    final finPaint = Paint()
      ..color = AppColors.navy600
      ..style = PaintingStyle.fill;
    final finPath = Path()
      ..moveTo(w * 0.35, h * 0.27)
      ..lineTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.65, h * 0.27)
      ..close();
    canvas.drawPath(finPath, finPaint);

    // ── Suit jacket (white shirt stripe) ───────────────────
    final shirtPath = Path()
      ..moveTo(w * 0.38, h * 0.55)
      ..lineTo(w * 0.5, h * 0.48)
      ..lineTo(w * 0.62, h * 0.55)
      ..lineTo(w * 0.62, h * 0.82)
      ..lineTo(w * 0.38, h * 0.82)
      ..close();
    canvas.drawPath(shirtPath, whitePaint);

    // Suit jacket left lapel
    final lapelLeft = Path()
      ..moveTo(w * 0.1, h * 0.25)
      ..lineTo(w * 0.38, h * 0.55)
      ..lineTo(w * 0.38, h * 0.82)
      ..lineTo(w * 0.1, h * 0.85)
      ..close();
    canvas.drawPath(lapelLeft, suitPaint);

    // Suit jacket right lapel
    final lapelRight = Path()
      ..moveTo(w * 0.9, h * 0.25)
      ..lineTo(w * 0.62, h * 0.55)
      ..lineTo(w * 0.62, h * 0.82)
      ..lineTo(w * 0.9, h * 0.85)
      ..close();
    canvas.drawPath(lapelRight, suitPaint);

    // ── Tie ────────────────────────────────────────────────
    final tieTop = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.44, h * 0.5, w * 0.12, h * 0.08),
      const Radius.circular(2),
    );
    canvas.drawRRect(tieTop, cyanPaint);

    final tiePath = Path()
      ..moveTo(w * 0.44, h * 0.58)
      ..lineTo(w * 0.41, h * 0.75)
      ..lineTo(w * 0.5, h * 0.80)
      ..lineTo(w * 0.59, h * 0.75)
      ..lineTo(w * 0.56, h * 0.58)
      ..close();
    canvas.drawPath(tiePath, cyanPaint);

    // ── Eyes ───────────────────────────────────────────────
    // Left eye
    canvas.drawCircle(Offset(w * 0.37, h * 0.42), w * 0.085, whitePaint);
    canvas.drawCircle(Offset(w * 0.37, h * 0.42), w * 0.055, darkPaint);
    canvas.drawCircle(Offset(w * 0.355, h * 0.405), w * 0.018, whitePaint);

    // Right eye
    canvas.drawCircle(Offset(w * 0.63, h * 0.42), w * 0.085, whitePaint);
    canvas.drawCircle(Offset(w * 0.63, h * 0.42), w * 0.055, darkPaint);
    canvas.drawCircle(Offset(w * 0.615, h * 0.405), w * 0.018, whitePaint);

    // ── Eyebrows (friendly arch) ───────────────────────────
    final browPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04
      ..strokeCap = StrokeCap.round;

    if (mood == SharkMood.thinking) {
      // Asymmetric brows for thinking
      final leftBrowPath = Path()
        ..moveTo(w * 0.29, h * 0.32)
        ..quadraticBezierTo(w * 0.37, h * 0.28, w * 0.45, h * 0.33);
      canvas.drawPath(leftBrowPath, browPaint);

      final rightBrowPath = Path()
        ..moveTo(w * 0.55, h * 0.30)
        ..quadraticBezierTo(w * 0.63, h * 0.26, w * 0.71, h * 0.30);
      canvas.drawPath(rightBrowPath, browPaint);
    } else {
      // Standard friendly brows
      final leftBrowPath = Path()
        ..moveTo(w * 0.29, h * 0.33)
        ..quadraticBezierTo(w * 0.37, h * 0.27, w * 0.45, h * 0.32);
      canvas.drawPath(leftBrowPath, browPaint);

      final rightBrowPath = Path()
        ..moveTo(w * 0.55, h * 0.32)
        ..quadraticBezierTo(w * 0.63, h * 0.27, w * 0.71, h * 0.33);
      canvas.drawPath(rightBrowPath, browPaint);
    }

    // ── Smile / expression ─────────────────────────────────
    final smilePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04
      ..strokeCap = StrokeCap.round;

    if (mood == SharkMood.happy || mood == SharkMood.celebration) {
      final smilePath = Path()
        ..moveTo(w * 0.36, h * 0.53)
        ..quadraticBezierTo(w * 0.5, h * 0.63, w * 0.64, h * 0.53);
      canvas.drawPath(smilePath, smilePaint);
    } else if (mood == SharkMood.thinking) {
      final smilePath = Path()
        ..moveTo(w * 0.40, h * 0.56)
        ..lineTo(w * 0.60, h * 0.56);
      canvas.drawPath(smilePath, smilePaint);
    } else {
      final smilePath = Path()
        ..moveTo(w * 0.38, h * 0.54)
        ..quadraticBezierTo(w * 0.5, h * 0.60, w * 0.62, h * 0.54);
      canvas.drawPath(smilePath, smilePaint);
    }

    // ── Celebration stars ──────────────────────────────────
    if (mood == SharkMood.celebration) {
      _drawStar(canvas, Offset(w * 0.08, h * 0.15), w * 0.06, AppColors.amber);
      _drawStar(canvas, Offset(w * 0.92, h * 0.1), w * 0.05, AppColors.cyan);
      _drawStar(canvas, Offset(w * 0.85, h * 0.35), w * 0.04, AppColors.amber);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outer = Offset(
        center.dx + radius * Math.cos((i * 4 * 3.14159 / 5) - 3.14159 / 2),
        center.dy + radius * Math.sin((i * 4 * 3.14159 / 5) - 3.14159 / 2),
      );
      final inner = Offset(
        center.dx + radius * 0.4 * Math.cos(((i * 4 + 2) * 3.14159 / 5) - 3.14159 / 2),
        center.dy + radius * 0.4 * Math.sin(((i * 4 + 2) * 3.14159 / 5) - 3.14159 / 2),
      );
      if (i == 0) path.moveTo(outer.dx, outer.dy);
      else path.lineTo(outer.dx, outer.dy);
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SharkPainter oldDelegate) => oldDelegate.mood != mood;
}

// Simple math helpers to avoid dart:math import complexity
class Math {
  static double cos(double x) {
    // Taylor series approximation
    double result = 1;
    double term = 1;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
  }

  static double sin(double x) {
    double result = x;
    double term = x;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }
}
