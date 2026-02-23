import 'package:flutter/material.dart';
import 'package:hibuz_portfolio/core/constants.dart';
// ─── Section Label ─────────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 24, height: 1.5, color: AppColors.cyan),
        const SizedBox(width: 12),
        Text(text, style: AppText.label),
        const SizedBox(width: 12),
        Container(width: 24, height: 1.5, color: AppColors.cyan),
      ],
    );
  }
}

// ─── Section Wrapper ───────────────────────────────────────────────
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool isMobile;

  const SectionWrapper({
    super.key,
    required this.child,
    this.color,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final h = isMobile ? AppSpacing.sectionHMobile : AppSpacing.sectionH;
    return Container(
      width: double.infinity,
      color: color ?? AppColors.bg,
      padding: EdgeInsets.symmetric(horizontal: h, vertical: AppSpacing.sectionV),
      child: child,
    );
  }
}

// ─── Gradient Text ─────────────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

// ─── Glowing Card ──────────────────────────────────────────────────
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final EdgeInsets? padding;

  const GlowCard({
    super.key,
    required this.child,
    required this.glowColor,
    this.padding,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: widget.padding ?? const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered
                ? widget.glowColor.withOpacity(0.5)
                : AppColors.cardBorder,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: widget.glowColor.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}

// ─── Cyber Button ──────────────────────────────────────────────────
class CyberButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;

  const CyberButton({
    super.key,
    required this.label,
    required this.onTap,
    this.outlined = false,
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.outlined
                ? null
                : (_hovered ? AppColors.gradient2 : AppColors.gradient1),
            border: widget.outlined
                ? Border.all(
              color: _hovered ? AppColors.cyan : AppColors.white20,
              width: 1,
            )
                : null,
            borderRadius: BorderRadius.circular(4),
            boxShadow: !widget.outlined && _hovered
                ? [
              BoxShadow(
                color: AppColors.cyan.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
                : [],
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: widget.outlined
                  ? (_hovered ? AppColors.cyan : AppColors.white50)
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Dot Grid Painter ──────────────────────────────────────────────
class DotGridPainter extends CustomPainter {
  final Color color;
  const DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const spacing = 30.0;
    const radius = 1.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Tech Tag ──────────────────────────────────────────────────────
class TechTag extends StatelessWidget {
  final String label;
  const TechTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyan.withOpacity(0.08),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: AppColors.cyan.withOpacity(0.2), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.cyan,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}