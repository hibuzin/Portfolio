import 'package:flutter/material.dart';
import 'package:hibuz_portfolio/projects/clothing.dart';
import 'package:hibuz_portfolio/projects/jewellery.dart';
import '../core/constants.dart';
import '../core/data.dart';
import '../widgets/shared_widgets.dart';

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  const ProjectsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(text: 'OUR WORK'),
          const SizedBox(height: 16),
          Row(
            children: [
              GradientText(
                text: 'OUR RECENT PROJECTS',
                style: isMobile ? AppText.headingMobile : AppText.heading,
                gradient: AppColors.gradient1,
              ),
              const Spacer(),
              ],
          ),
          const SizedBox(height: 48),
          isMobile
              ? Column(
            children: AppData.projects
                .map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _ProjectCard(project: p),
            ))
                .toList(),
          )
              : Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _ProjectCard(project: AppData.projects[0])),
                    const SizedBox(width: 24),
                    Expanded(child: _ProjectCard(project: AppData.projects[1])),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _ProjectCard(project: AppData.projects[2])),
                    const SizedBox(width: 24),
                   ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () {
            if (p.title == 'LUXURY GOLD') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JewelleryDetailPage(),
                ),
              );
            } else if (p.title == 'PATRO CLOTHING') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  ClothingDetailPage(),
                ),
              );
            }
          },
            child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? p.accent.withOpacity(0.5) : AppColors.cardBorder,
            ),
            boxShadow: _hovered
                ? [BoxShadow(color: p.accent.withOpacity(0.12), blurRadius: 40)]
                : [],
                    ),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: p.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: p.accent.withOpacity(0.25)),
                    ),
                    child: Text(p.category,
                        style: TextStyle(
                            fontSize: 11,
                            color: p.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5)),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_outward, color: p.accent, size: 18),
                ],
              ),
              const SizedBox(height: 20),
              Text(p.title,
                  style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white)),
              const SizedBox(height: 12),
              Text(p.desc, style: AppText.body),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: p.tags.map((t) => TechTag(label: t)).toList(),
              ),
            ],
                    ),
                  ),
          ),
    );
  }
}