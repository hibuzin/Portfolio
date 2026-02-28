import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/data.dart';
import '../widgets/shared_widgets.dart';

class TechSection extends StatelessWidget {
  final bool isMobile;
  const TechSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          const SectionLabel(text: 'TECH STACK'),
          const SizedBox(height: 16),

          GradientText(
            text: 'Technologies We Master',
            style: isMobile ? AppText.headingMobile : AppText.heading,
            gradient: AppColors.gradient2,
          ),

          const SizedBox(height: 12),

          const Text(
            'Modern, battle-tested tools for every layer of the stack.',
            style: AppText.body,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 60),

          const TechStackCarousel(),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}


class TechStackCarousel extends StatefulWidget {
  const TechStackCarousel({super.key});

  @override
  State<TechStackCarousel> createState() => _TechStackCarouselState();
}

class _TechStackCarouselState extends State<TechStackCarousel> {
  late ScrollController _scrollController;
  late Timer _timer;

  final List<Map<String, String>> techImages = const [
    {"name": "Flutter", "image": "assets/icons/flutter.png", "category": "Mobile / Web"},
    {"name": "Python", "image": "assets/icons/python.png", "category": "Backend"},
    {"name": "Node.js", "image": "assets/icons/nodejs.png", "category": "Backend"},
    {"name": "AWS", "image": "assets/icons/aws.png", "category": "Cloud"},
    {"name": "Docker", "image": "assets/icons/docker.png", "category": "DevOps"},
    {"name": "MongoDB", "image": "assets/icons/mongo.png", "category": "Database"},
    {"name": "React", "image": "assets/icons/react.png", "category": "Frontend"},
  ];

  late final List<Map<String, String>> _items;

  @override
  void initState() {
    super.initState();

    _items = [...techImages, ...techImages, ...techImages, ...techImages];

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      if (currentScroll >= maxScroll * 0.75) {
        _scrollController.jumpTo(maxScroll * 0.25);
      } else {
        _scrollController.jumpTo(currentScroll + 2.5);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: 140,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final tech = _items[index];

          return SizedBox(
            width: screenWidth / 5, // more items visible = less empty space
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    tech["image"]!,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tech["name"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  tech["category"]!,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}