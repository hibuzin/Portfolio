import 'package:flutter/material.dart';
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
    final h = widget.isMobile ? AppSpacing.sectionHMobile : AppSpacing.sectionH;
    return Container(
      width: double.infinity,
      color: AppColors.bg,
      child: Stack(
        children: [
          // Dot grid background
          Positioned.fill(
            child: CustomPaint(
              painter: DotGridPainter(color: AppColors.white10),
            ),
          ),
          // Glow blobs
          Positioned(
            top: -100,
            left: -100,
            child: _Blob(color: AppColors.cyan.withOpacity(0.12), size: 500),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: _Blob(color: AppColors.purple.withOpacity(0.1), size: 400),
          ),
          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(
                h, widget.isMobile ? 120 : 140, h, 80),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: widget.isMobile
                    ? _MobileHero()
                    : _DesktopHero(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    text: 'We Build\nSoftware\nThat Scales.',
                    style: AppText.display,
                    gradient: AppColors.gradient1,
                  ),
                ],
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
                      CyberButton(
                          label: 'Get In Touch', onTap: () {}, outlined: true),
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

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}