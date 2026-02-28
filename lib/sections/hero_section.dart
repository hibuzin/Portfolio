import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/constants.dart';
import '../widgets/shared_widgets.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback? onViewWork;
  final VoidCallback? onGetInTouch;
  const HeroSection({
    super.key,
    required this.isMobile,
    this.onViewWork,
    this.onGetInTouch,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.isMobile ? AppSpacing.sectionHMobile : AppSpacing.sectionH;

    return Container(
      width: double.infinity,
      color: AppColors.bg,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // ── Luxury Background ──
          const Positioned.fill(child: _LuxuryBackground()),
          // ── Floating Dust Particles ──
          const Positioned.fill(child: _DustParticles()),
          // ── Content ──
          Padding(
            padding: EdgeInsets.fromLTRB(h, widget.isMobile ? 120 : 140, h, 80),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: widget.isMobile
                    ? _MobileHero(onViewWork: widget.onViewWork, onGetInTouch: widget.onGetInTouch)
                    : _DesktopHero(onViewWork: widget.onViewWork, onGetInTouch: widget.onGetInTouch),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Luxury Background ────────────────────────────────────────────
class _LuxuryBackground extends StatefulWidget {
  const _LuxuryBackground();

  @override
  State<_LuxuryBackground> createState() => _LuxuryBackgroundState();
}

class _LuxuryBackgroundState extends State<_LuxuryBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _LuxuryBgPainter(t: _ctrl.value * 2 * math.pi),
        size: Size.infinite,
      ),
    );
  }
}

class _LuxuryBgPainter extends CustomPainter {
  final double t;
  const _LuxuryBgPainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Deep black base ──
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF080705),
    );

    // ── Slow drifting cyan orbs ──
    _drawOrb(
      canvas: canvas, size: size,
      cxF: 0.15, cyF: 0.30,
      speedX: 0.08, speedY: 0.10,
      phaseX: 0.0, phaseY: 0.0,
      rX: w * 0.55, rY: h * 0.50,
      color: const Color(0xFF00D4FF),
      opacity: 0.13,
      blur: 120,
    );

    _drawOrb(
      canvas: canvas, size: size,
      cxF: 0.85, cyF: 0.65,
      speedX: 0.06, speedY: 0.09,
      phaseX: math.pi * 1.2, phaseY: math.pi * 0.5,
      rX: w * 0.50, rY: h * 0.55,
      color: const Color(0xFF00D4FF),
      opacity: 0.09,
      blur: 130,
    );

    _drawOrb(
      canvas: canvas, size: size,
      cxF: 0.50, cyF: 0.10,
      speedX: 0.05, speedY: 0.07,
      phaseX: math.pi * 0.8, phaseY: math.pi * 1.6,
      rX: w * 0.40, rY: h * 0.35,
      color: const Color(0xFF00D4FF),
      opacity: 0.10,
      blur: 100,
    );

    // ── Deep navy depth orb ──
    _drawOrb(
      canvas: canvas, size: size,
      cxF: 0.70, cyF: 0.20,
      speedX: 0.07, speedY: 0.11,
      phaseX: math.pi * 0.3, phaseY: math.pi * 1.0,
      rX: w * 0.35, rY: h * 0.40,
      color: const Color(0xFF0D1A2E),
      opacity: 0.90,
      blur: 80,
    );

    // ── Vignette top ──
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h * 0.30),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF080705), Colors.transparent],
        ).createShader(Rect.fromLTWH(0, 0, w, h * 0.30)),
    );

    // ── Vignette bottom ──
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.70, w, h * 0.30),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [const Color(0xFF080705), Colors.transparent],
        ).createShader(Rect.fromLTWH(0, h * 0.70, w, h * 0.30)),
    );

    // ── Edge vignettes left & right ──
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w * 0.20, h),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [const Color(0xFF080705), Colors.transparent],
        ).createShader(Rect.fromLTWH(0, 0, w * 0.20, h)),
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.80, 0, w * 0.20, h),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [const Color(0xFF080705), Colors.transparent],
        ).createShader(Rect.fromLTWH(w * 0.80, 0, w * 0.20, h)),
    );
  }

  void _drawOrb({
    required Canvas canvas,
    required Size size,
    required double cxF,
    required double cyF,
    required double speedX,
    required double speedY,
    required double phaseX,
    required double phaseY,
    required double rX,
    required double rY,
    required Color color,
    required double opacity,
    required double blur,
  }) {
    final cx = size.width * cxF +
        math.sin(t * speedX + phaseX) * size.width * 0.06;
    final cy = size.height * cyF +
        math.sin(t * speedY + phaseY) * size.height * 0.06;

    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, cy), width: rX * 2, height: rY * 2),
      Paint()
        ..color = color.withOpacity(opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur),
    );
  }

  @override
  bool shouldRepaint(_LuxuryBgPainter old) => old.t != t;
}

// ─── Floating Dust Particles ──────────────────────────────────────
class _DustParticles extends StatefulWidget {
  const _DustParticles();

  @override
  State<_DustParticles> createState() => _DustParticlesState();
}

class _DustParticlesState extends State<_DustParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _DustPainter(t: _ctrl.value),
        size: Size.infinite,
      ),
    );
  }
}

class _DustPainter extends CustomPainter {
  final double t;
  const _DustPainter({required this.t});

  static const _particles = [
    (0.10, 0.0,  1.0, 1.8, 0.00),
    (0.22, 0.3,  0.7, 1.2, 0.15),
    (0.35, 0.6,  1.3, 2.0, 0.30),
    (0.48, 0.1,  0.9, 1.5, 0.45),
    (0.57, 0.8,  1.1, 1.0, 0.60),
    (0.63, 0.4,  0.8, 2.2, 0.72),
    (0.74, 0.2,  1.4, 1.4, 0.10),
    (0.80, 0.7,  1.0, 1.8, 0.25),
    (0.88, 0.5,  0.6, 1.2, 0.55),
    (0.93, 0.9,  1.2, 1.6, 0.80),
    (0.15, 0.35, 1.5, 1.0, 0.40),
    (0.42, 0.65, 0.7, 2.0, 0.65),
    (0.68, 0.15, 1.1, 1.4, 0.20),
    (0.26, 0.55, 0.9, 1.8, 0.90),
    (0.53, 0.45, 1.3, 1.2, 0.05),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final xFrac   = p.$1;
      final phase   = p.$2;
      final speed   = p.$3;
      final radius  = p.$4;
      final startPh = p.$5;

      final progress = ((t * speed + startPh) % 1.0);

      final x = size.width * xFrac +
          math.sin((progress + phase) * 2 * math.pi) * 18;
      final y = size.height * (1.0 - progress);

      final opacity = progress < 0.15
          ? progress / 0.15
          : progress > 0.80
          ? (1.0 - progress) / 0.20
          : 1.0;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        Paint()
          ..color = const Color(0xFF00D4FF).withOpacity(opacity * 0.55)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
      );
    }
  }

  @override
  bool shouldRepaint(_DustPainter old) => old.t != t;
}

// ─── Hero Content ────────────────────────────────────────────────
class _DesktopHero extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onGetInTouch;
  const _DesktopHero({this.onViewWork, this.onGetInTouch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'SOFTWARE DEVELOPMENT COMPANY'),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: GradientText(
                text: 'We Build\nSoftware\nThat Scales.',
                style: AppText.display,
                gradient: AppColors.gradient1,
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'From MVP to enterprise-grade — we craft pixel-perfect products that perform at scale. Trusted by startups and Fortune 500s alike.',
                    style: AppText.body,
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      CyberButton(label: 'View Our Work', onTap: onViewWork ?? () {}),
                      const SizedBox(width: 16),
                      CyberButton(
                          label: 'Get In Touch', onTap: onGetInTouch ?? () {}, outlined: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 170),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onGetInTouch;
  const _MobileHero({this.onViewWork, this.onGetInTouch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'SOFTWARE HIBUZ COMPANY'),
        const SizedBox(height: 24),
        GradientText(
          text: 'We Build\nSoftware\nThat Scales.',
          style: AppText.displayMobile,
          gradient: AppColors.gradient1,
        ),
        const SizedBox(height: 20),
        const Text(
          'From MVP to enterprise — we craft pixel-perfect products that perform at scale.',
          style: AppText.body,
        ),
        const SizedBox(height: 28),
        CyberButton(label: 'View Our Work', onTap: onViewWork ?? () {}),
        const SizedBox(height: 12),
        CyberButton(label: 'Get In Touch', onTap: onGetInTouch ?? () {}, outlined: true),
        const SizedBox(height: 48),

      ],
    );
  }
}
