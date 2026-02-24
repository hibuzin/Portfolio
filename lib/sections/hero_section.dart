import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/constants.dart';
import '../widgets/shared_widgets.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  const HeroSection({super.key, required this.isMobile});

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
    final size = MediaQuery.of(context).size;
    final h = widget.isMobile ? AppSpacing.sectionHMobile : AppSpacing.sectionH;
    final spot1Size = widget.isMobile ? 280.0 : 520.0;
    final spot2Size = widget.isMobile ? 220.0 : 420.0;

    return Container(
      width: double.infinity,
      color: AppColors.bg,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [

          // Spotlight 1 — cyan tint
          _Spotlight(
            color: const Color(0xFF004D5C),
            size: spot1Size,
            screenW: size.width,
            screenH: size.height,
            xFreq: 1.0,
            yFreq: 1.37,
            xAmp: size.width * 0.42,
            yAmp: size.height * 0.38,
            centerX: size.width * 0.5,
            centerY: size.height * 0.42,
            period: 150.0,
            phase: 0.0,
          ),

          // Spotlight 2 — purple tint
          _Spotlight(
            color: const Color(0xFF2A1A4D),
            size: spot2Size,
            screenW: size.width,
            screenH: size.height,
            xFreq: 1.0,
            yFreq: 1.61,
            xAmp: size.width * 0.38,
            yAmp: size.height * 0.35,
            centerX: size.width * 0.5,
            centerY: size.height * 0.5,
            period: 150.0,
            phase: math.pi * 0.7,
          ),

          // Content on top
          Padding(
            padding: EdgeInsets.fromLTRB(h, widget.isMobile ? 120 : 140, h, 80),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: widget.isMobile ? const _MobileHero() : const _DesktopHero(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Spotlight ────────────────────────────────────────────────────
// Looks like a theatre/stage spotlight — bright center, sharp falloff
class _Spotlight extends StatefulWidget {
  final Color color;
  final double size;
  final double screenW;
  final double screenH;
  final double xFreq;
  final double yFreq;
  final double xAmp;
  final double yAmp;
  final double centerX;
  final double centerY;
  final double period;
  final double phase;

  const _Spotlight({
    required this.color,
    required this.size,
    required this.screenW,
    required this.screenH,
    required this.xFreq,
    required this.yFreq,
    required this.xAmp,
    required this.yAmp,
    required this.centerX,
    required this.centerY,
    required this.period,
    required this.phase,
  });

  @override
  State<_Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<_Spotlight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.period * 1000).toInt()),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Spotlight shape — sharp bright center, hard falloff at edges
    // Uses multiple layered radial gradients for realistic light cone feel
    final spotlight = SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _SpotlightPainter(color: widget.color, size: widget.size),
      ),
    );

    return AnimatedBuilder(
      animation: _ctrl,
      child: spotlight,
      builder: (context, child) {
        final t = _ctrl.value * 2 * math.pi + widget.phase;
        final x = widget.centerX + math.sin(widget.xFreq * t) * widget.xAmp;
        final y = widget.centerY + math.sin(widget.yFreq * t + 0.8) * widget.yAmp;

        return Positioned(
          left: x - widget.size / 2,
          top:  y - widget.size / 2,
          child: child!,
        );
      },
    );
  }
}

// ─── Spotlight Painter ────────────────────────────────────────────
class _SpotlightPainter extends CustomPainter {
  final Color color;
  final double size;

  const _SpotlightPainter({required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final center = Offset(size / 2, size / 2);
    final r = size / 2;

    // Draw many rays from center outward — different lengths, random angles
    // This breaks the circular silhouette completely
    _drawRays(canvas, center, r);

    // Soft inner core glow — very small, heavily blurred
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.85),
          color.withOpacity(0.30),
          color.withOpacity(0.0),
        ],
        stops: const [0.0, 0.40, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: r * 0.22))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.12);
    canvas.drawCircle(center, r * 0.22, corePaint);

    // Mid haze — blurred heavily so shape disappears
    final midPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.40),
          color.withOpacity(0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: r * 0.45))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.30);
    canvas.drawCircle(center, r * 0.45, midPaint);
  }

  void _drawRays(Canvas canvas, Offset center, double r) {
    // 32 rays — varying lengths so it looks like a real sun burst
    const rayCount = 32;
    // Pre-defined length multipliers — irregular pattern
    const lengths = [
      0.95, 0.60, 0.82, 0.45, 0.98, 0.55, 0.75, 0.40,
      0.90, 0.62, 0.88, 0.50, 0.70, 0.42, 0.93, 0.58,
      0.80, 0.48, 0.85, 0.52, 0.72, 0.44, 0.96, 0.56,
      0.78, 0.46, 0.87, 0.53, 0.68, 0.41, 0.92, 0.60,
    ];

    for (int i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * math.pi;
      final len = r * lengths[i % lengths.length];

      // Ray width tapers — thick near center, thin at tip
      final rayPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withOpacity(0.70),
            color.withOpacity(0.15),
            color.withOpacity(0.0),
          ],
          stops: const [0.0, 0.55, 1.0],
          center: Alignment.centerLeft,
          focal: Alignment.centerLeft,
          radius: 1.0,
        ).createShader(Rect.fromPoints(center,
            center + Offset(math.cos(angle) * len, math.sin(angle) * len)))
        ..strokeWidth = (i % 3 == 0) ? 18 : (i % 2 == 0) ? 10 : 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawLine(
        center,
        center + Offset(math.cos(angle) * len, math.sin(angle) * len),
        rayPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) =>
      old.color != color || old.size != size;
}

// ─── Hero Content ─────────────────────────────────────────────────
class _DesktopHero extends StatelessWidget {
  const _DesktopHero();

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
                      CyberButton(label: 'View Our Work', onTap: () {}),
                      const SizedBox(width: 16),
                      CyberButton(label: 'Get In Touch', onTap: () {}, outlined: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 72),
        const _StatsRow(),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  const _MobileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'SOFTWARE DEV COMPANY'),
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
        CyberButton(label: 'View Our Work', onTap: () {}),
        const SizedBox(height: 12),
        CyberButton(label: 'Get In Touch', onTap: () {}, outlined: true),
        const SizedBox(height: 48),
        const _StatsRow(),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('50+', 'Projects Delivered'),
      ('30+', 'Happy Clients'),
      ('8+', 'Years Experience'),
      ('15', 'Team Members'),
    ];
    return Wrap(
      spacing: 48,
      runSpacing: 24,
      children: stats.map((s) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              text: s.$1,
              style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              gradient: AppColors.gradient1,
            ),
            Text(s.$2,
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white50,
                    letterSpacing: 0.5)),
          ],
        );
      }).toList(),
    );
  }
}