import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/data.dart';
import '../widgets/shared_widgets.dart';

class TechSection extends StatelessWidget {
  final bool isMobile;
  const TechSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final categories = AppData.techStack
        .map((t) => t.category)
        .toSet()
        .toList();

    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionLabel(text: 'TECH STACK'),
          const SizedBox(height: 16),
          GradientText(
            text: 'Technologies\nWe Master',
            style: isMobile ? AppText.headingMobile : AppText.heading,
            gradient: AppColors.gradient2,
          ),
          const SizedBox(height: 12),
          const Text(
            'Modern, battle-tested tools for every layer of the stack.',
            style: AppText.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 56),
          ...categories.map((cat) {
            final techs = AppData.techStack.where((t) => t.category == cat).toList();
            return Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: isMobile ? 90 : 140,
                    child: Text(cat,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.white50,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: techs.map((t) => _TechBadge(name: t.name)).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TechBadge extends StatefulWidget {
  final String name;
  const _TechBadge({required this.name});

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.cyan.withOpacity(0.12)
              : AppColors.card,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _hovered ? AppColors.cyan : AppColors.cardBorder,
          ),
        ),
        child: Text(widget.name,
            style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered ? AppColors.cyan : AppColors.white80)),
      ),
    );
  }
}