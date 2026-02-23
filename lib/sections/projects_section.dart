import 'package:flutter/material.dart';
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
                text: 'Featured\nProjects',
                style: isMobile ? AppText.headingMobile : AppText.heading,
                gradient: AppColors.gradient1,
              ),
              const Spacer(),
              if (!isMobile)
                CyberButton(label: 'All Projects', onTap: () {}, outlined: true),
            ],
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.4 : 1.5,
            ),
            itemCount: AppData.projects.length,
            itemBuilder: (_, i) => _ProjectCard(project: AppData.projects[i]),
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
            Expanded(
              child: Text(p.desc, style: AppText.body, overflow: TextOverflow.fade),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.tags.map((t) => TechTag(label: t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}