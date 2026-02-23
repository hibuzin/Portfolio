import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/data.dart';
import '../widgets/shared_widgets.dart';

class ServicesSection extends StatelessWidget {
  final bool isMobile;
  const ServicesSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionLabel(text: 'WHAT WE DO'),
          const SizedBox(height: 16),
          GradientText(
            text: 'Our Services',
            style: isMobile ? AppText.headingMobile : AppText.heading,
            gradient: AppColors.gradient1,
          ),
          const SizedBox(height: 12),
          const Text(
            'End-to-end software solutions tailored to your business goals.',
            style: AppText.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 56),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 3 : 1.3,
            ),
            itemCount: AppData.services.length,
            itemBuilder: (_, i) => _ServiceCard(service: AppData.services[i]),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;
  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.card : AppColors.card.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? s.accent.withOpacity(0.5) : AppColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: s.accent.withOpacity(0.15), blurRadius: 30)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: s.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: s.accent.withOpacity(0.2)),
              ),
              child: Icon(s.icon, color: s.accent, size: 22),
            ),
            const SizedBox(height: 20),
            Text(s.title,
                style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white)),
            const SizedBox(height: 10),
            Expanded(
              child: Text(s.desc, style: AppText.bodySmall,
                  overflow: TextOverflow.fade),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Learn more',
                    style: TextStyle(
                        fontSize: 12,
                        color: s.accent,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5)),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward, color: s.accent, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}