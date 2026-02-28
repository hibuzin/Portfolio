import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/services_section.dart';
import 'sections/projects_section.dart';
import 'sections/tech_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const DevCoApp());
}

class DevCoApp extends StatelessWidget {
  const DevCoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hibuz — Software Development Company',
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

  // One key per section — same order as navbar
  final _servicesKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _aboutKey    = GlobalKey();
  final _techKey     = GlobalKey();
  final _contactKey  = GlobalKey();

  // Fixed list — created once, not on every scroll
  late final List<GlobalKey> _sectionKeys;

  int _activeNav = 0;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _servicesKey,
      _projectsKey,
      _aboutKey,
      _techKey,
      _contactKey,
    ];
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 130) {
        if (_activeNav != i) setState(() => _activeNav = i);
      }
    }
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= _sectionKeys.length) return;
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToProjects() => _scrollToSection(1);
  void _scrollToAbout()    => _scrollToSection(2);
  void _scrollTocontact() => _scrollToSection(4);

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
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  isMobile: isMobile,
                  onViewWork: _scrollToProjects,
                  onGetInTouch: _scrollTocontact,
                ),
                ServicesSection(key: _servicesKey, isMobile: isMobile),
                ProjectsSection(key: _projectsKey, isMobile: isMobile),
                AboutSection(key: _aboutKey, isMobile: isMobile),
                TechSection(key: _techKey, isMobile: isMobile),
                ContactSection(key: _contactKey, isMobile: isMobile),
                FooterWidget(isMobile: isMobile),
              ],
            ),
          ),
          Positioned(
            top: 0, left: 0, right: 0,
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