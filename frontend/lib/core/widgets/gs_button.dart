import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class GsButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isSecondary;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;

  const GsButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.isSecondary = false,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height = 52,
  });

  const GsButton.secondary({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.height = 52,
  })  : isSecondary = true,
        backgroundColor = null,
        textColor = null;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ??
        (isSecondary ? Colors.transparent : AppColors.navy500);
    final fg = textColor ??
        (isSecondary ? AppColors.navy500 : AppColors.white);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: isSecondary
                  ? Border.all(color: AppColors.gray200, width: 1.5)
                  : null,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: fg,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: fg, size: 18),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          label,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: fg,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class GsIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final double size;

  const GsIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: color ?? AppColors.gray600, size: 20),
        ),
      ),
    );
  }
}

class GsCyanButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isFullWidth;
  final IconData? icon;
  final double height;

  const GsCyanButton({
    super.key,
    required this.label,
    this.onTap,
    this.isFullWidth = true,
    this.icon,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    return GsButton(
      label: label,
      onTap: onTap,
      isFullWidth: isFullWidth,
      icon: icon,
      height: height,
      backgroundColor: AppColors.cyan,
      textColor: AppColors.navy900,
    );
  }
}
