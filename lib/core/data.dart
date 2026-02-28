import 'package:flutter/material.dart';

// ─── Models ────────────────────────────────────────────────────────
class ServiceModel {
  final IconData icon;
  final String title;
  final String desc;
  final Color accent;
  ServiceModel({required this.icon, required this.title, required this.desc, required this.accent});
}

class ProjectModel {
  final String title;
  final String category;
  final String desc;
  final List<String> tags;
  final Color accent;
  ProjectModel({required this.title, required this.category, required this.desc, required this.tags, required this.accent});
}

class TechModel {
  final String name;
  final String category;
  TechModel({required this.name, required this.category});
}

class TestimonialModel {
  final String quote;
  final String name;
  final String role;
  final String company;
  TestimonialModel({required this.quote, required this.name, required this.role, required this.company});
}

// ─── Sample Data ───────────────────────────────────────────────────
class AppData {
  AppData._();

  static final services = [
    ServiceModel(
      icon: Icons.phone_android_rounded,
      title: 'Mobile Apps',
      desc:
      'Cross-platform Android and iOS mobile applications using Flutter — delivering native performance with a single codebase.',
      accent: const Color(0xFF00FF88),
    ),
    ServiceModel(
      icon: Icons.web_rounded,
      title: 'Web Development',
      desc:
      'High-performance, responsive websites and web applications built with modern technologies like Flutter Web, React, and Next.js.',
      accent: const Color(0xFF00D4FF),
    ),
    ServiceModel(
      icon: Icons.design_services_rounded,
      title: 'UI/UX Design',
      desc:
      'Modern, intuitive user interface and user experience design focused on usability, aesthetics, and conversion.',
      accent: const Color(0xFFFF61DC),
    ),

    ServiceModel(
      icon: Icons.auto_awesome_rounded,
      title: 'AI Integration',
      desc:
      'Integrate AI features like chatbots, automation, and intelligent data processing into your applications to enhance functionality.',
      accent: const Color(0xFFFF6B6B),
    ),
    ServiceModel(
      icon: Icons.sync_alt_rounded,
      title: 'Migrating',
      desc:
      'Seamless migration of applications, databases, or platforms with minimal downtime while ensuring data integrity and security.',
      accent: const Color(0xFFFFD93D),
    ),
    ServiceModel(
      icon: Icons.bug_report_rounded,
      title: 'Bug Fixing',
      desc:
      'Identify, troubleshoot, and resolve application issues efficiently to improve performance, stability, and user experience.',
      accent: const Color(0xFF7B61FF),
    ),
  ];

  static final projects = [
    ProjectModel(
      title: 'LUXURY GOLD',
      category: 'E-commerce ',
      desc: 'Premium online jewellery platform showcasing gold, diamond, and bridal collections with secure checkout and seamless shopping experience.',
      tags: ['React', 'Node.js', 'MongoDB', 'Render'],
      accent: const Color(0xFFFFC107),
    ),
    ProjectModel(
      title: 'PATRO CLOTHING',
      category: 'E-commerce',
      desc: 'Premium fashion shopping app offering curated collections, seasonal drops, size filters, and smooth payment integration.',
      tags: ['React', 'Node.js', 'MongoDB', 'Render'],
      accent: const Color(0xFF9C27B0),
    ),
    ProjectModel(
      title: 'LAND',
      category: 'Real Estate',
      desc: 'Smart property sale platform enabling buyers to discover verified listings, explore virtual tours, compare pricing insights, and connect directly with agents. Includes AI-powered recommendations and secure deal management.',
      tags: ['Flutter', 'Node.js', 'MongoDB', 'Render'],
      accent: const Color(0xFF2ECC71),
    ),
  ];

  static final techStack = [
    TechModel(name: 'Flutter', category: 'Mobile / Web'),
    TechModel(name: 'React', category: 'Frontend'),
    TechModel(name: 'Node.js', category: 'Backend'),
    TechModel(name: 'Python', category: 'Backend'),
    TechModel(name: 'FastAPI', category: 'Backend'),
    TechModel(name: 'MongoDB', category: 'Database'),
    TechModel(name: 'AWS', category: 'Cloud'),
    TechModel(name: 'Docker', category: 'DevOps'),
  ];
}

// ─── Tech Icon Resolver ─────────────────────────────────────────────
IconData getTechIcon(String name) {
  switch (name) {
    case 'Flutter':
      return Icons.flutter_dash;
    case 'React':
      return Icons.javascript;
    case 'Node.js':
      return Icons.memory;
    case 'Python':
      return Icons.code;
    case 'FastAPI':
      return Icons.api;
    case 'MongoDB':
      return Icons.storage;
    case 'AWS':
      return Icons.cloud;
    case 'Docker':
      return Icons.dns;
    default:
      return Icons.devices;
  }
}

// ─── Tech Stack Carousel Widget ─────────────────────────────────────
class TechStackCarousel extends StatefulWidget {
  const TechStackCarousel({super.key});

  @override
  State<TechStackCarousel> createState() => _TechStackCarouselState();
}

class _TechStackCarouselState extends State<TechStackCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.28);
  int _page = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), autoScroll);
  }

  void autoScroll() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));

      if (_controller.hasClients) {
        _page++;

        if (_page >= AppData.techStack.length) {
          _page = 0;
        }

        _controller.animateToPage(
          _page,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: PageView.builder(
        controller: _controller,
        itemCount: AppData.techStack.length,
        itemBuilder: (context, index) {
          final tech = AppData.techStack[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xFF111827),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    getTechIcon(tech.name),
                    size: 34,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    tech.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    tech.category,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}