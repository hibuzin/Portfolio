import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/services_section.dart';
import 'sections/projects_section.dart';
import 'sections/tech_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const DevCoApp());
}

class DevCoApp extends StatelessWidget {
  const DevCoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevCo — Software Development Company',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cyan,
          secondary: AppColors.green,
          surface: AppColors.surface,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();

  // Section keys for scroll-to navigation
  // Index: 0=About, 1=Services, 2=Projects, 3=Tech, 4=Testimonials, 5=Contact
  final List<GlobalKey> _keys = List.generate(6, (_) => GlobalKey());
  int _activeNav = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = 0; i < _keys.length; i++) {
      final ctx = _keys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 130) {
        if (_activeNav != i) setState(() => _activeNav = i);
      }
    }
  }

  void _scrollToSection(int index) {
    final ctx = _keys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 760;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // ── Scrollable content ──
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(isMobile: isMobile),
                AboutSection(key: _keys[0], isMobile: isMobile),
                ServicesSection(key: _keys[1], isMobile: isMobile),
                ProjectsSection(key: _keys[2], isMobile: isMobile),
                TechSection(key: _keys[3], isMobile: isMobile),
                TestimonialsSection(key: _keys[4], isMobile: isMobile),
                ContactSection(key: _keys[5], isMobile: isMobile),
                FooterWidget(isMobile: isMobile),
              ],
            ),
          ),
          // ── Sticky NavBar ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              activeIndex: _activeNav,
              onTap: _scrollToSection,
              isMobile: isMobile,
            ),
          ),
        ],
      ),
    );
  }
}