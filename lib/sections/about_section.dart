import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/shared_widgets.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;
  const AboutSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.surface,
      child: isMobile ? _MobileLayout() : _DesktopLayout(),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: _TerminalCard()),
        const SizedBox(width: 80),
        Expanded(flex: 3, child: _AboutContent()),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutContent(),
        const SizedBox(height: 40),
        _TerminalCard(),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'ABOUT US'),
        const SizedBox(height: 20),
        GradientText(
          text: 'Engineering\nExcellence\nSince 2016',
          style: AppText.heading,
          gradient: AppColors.gradient1,
        ),
        const SizedBox(height: 24),
        const Text(
          'DevCo is a full-stack software development company born in Chennai, operating globally. We partner with startups and enterprises to design, build, and scale digital products that matter.',
          style: AppText.body,
        ),
        const SizedBox(height: 16),
        const Text(
          'Our team of 15 engineers, designers, and strategists brings deep technical expertise across mobile, web, cloud, and AI — with a relentless focus on delivery and quality.',
          style: AppText.body,
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            'Agile Process',
            'Clean Architecture',
            'CI/CD First',
            'Test Driven',
            'Open Source Contributors',
          ].map((t) => _ValueChip(label: t)).toList(),
        ),
      ],
    );
  }
}

class _ValueChip extends StatelessWidget {
  final String label;
  const _ValueChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.white20, width: 1),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              color: AppColors.white80,
              fontWeight: FontWeight.w500)),
    );
  }
}

class _TerminalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
              color: AppColors.cyan.withOpacity(0.08),
              blurRadius: 40,
              spreadRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Terminal header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A2235),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                _Dot(color: const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _Dot(color: const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _Dot(color: const Color(0xFF28C840)),
                const SizedBox(width: 12),
                const Text('devco ~ stats',
                    style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 12,
                        color: AppColors.white50)),
              ],
            ),
          ),
          // Terminal body
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TerminalLine(prompt: '\$', command: 'devco --info', delay: 0),
                const SizedBox(height: 12),
                _TerminalStat(key_: 'founded', value: '2016'),
                _TerminalStat(key_: 'location', value: 'Chennai, IN'),
                _TerminalStat(key_: 'team_size', value: '15 engineers'),
                _TerminalStat(key_: 'projects', value: '50+ delivered'),
                _TerminalStat(key_: 'clients', value: '30+ worldwide'),
                _TerminalStat(key_: 'uptime_sla', value: '99.9%'),
                const SizedBox(height: 12),
                _TerminalLine(prompt: '\$', command: '_', delay: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _TerminalLine extends StatelessWidget {
  final String prompt;
  final String command;
  final int delay;
  const _TerminalLine(
      {required this.prompt, required this.command, required this.delay});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '$prompt ',
              style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 13,
                  color: AppColors.green,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: command,
              style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 13,
                  color: AppColors.white80)),
        ],
      ),
    );
  }
}

class _TerminalStat extends StatelessWidget {
  final String key_;
  final String value;
  const _TerminalStat({required this.key_, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: '  $key_',
                style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 13,
                    color: AppColors.cyan)),
            const TextSpan(
                text: ': ',
                style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 13,
                    color: AppColors.white50)),
            TextSpan(
                text: '"$value"',
                style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 13,
                    color: AppColors.white80)),
          ],
        ),
      ),
    );
  }
}