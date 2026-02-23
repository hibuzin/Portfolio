import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/data.dart';
import '../widgets/shared_widgets.dart';

class TestimonialsSection extends StatelessWidget {
  final bool isMobile;
  const TestimonialsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionLabel(text: 'CLIENT TESTIMONIALS'),
          const SizedBox(height: 16),
          GradientText(
            text: 'What Clients\nSay About Us',
            style: isMobile ? AppText.headingMobile : AppText.heading,
            gradient: AppColors.gradient1,
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
            children: AppData.testimonials
                .map((t) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TestimonialCard(t: t),
            ))
                .toList(),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AppData.testimonials
                .map((t) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: _TestimonialCard(t: t),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final TestimonialModel t;
  const _TestimonialCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: AppColors.cyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (b) => AppColors.gradient1
                .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
            child: const Text('"',
                style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    height: 0.7)),
          ),
          const SizedBox(height: 16),
          Text(t.quote,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white80,
                  height: 1.7,
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 24),
          const Divider(color: AppColors.white10),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.gradient1,
                ),
                child: Center(
                  child: Text(
                    t.name[0],
                    style: const TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.name,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  Text('${t.role} · ${t.company}',
                      style: const TextStyle(
                          color: AppColors.white50, fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}