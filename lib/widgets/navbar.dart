import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

const _navItems = [ 'SERVICES', 'PROJECTS','ABOUT', 'TECH', 'CONTACT'];

class NavBar extends StatefulWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;
  final bool isMobile;

  const NavBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? _hovered;

  void _handleTap(int index) async {
    /// Small delay improves last section animation feel (Contact)
    await Future.delayed(const Duration(milliseconds: 10));
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg.withOpacity(0.92),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 60,
        vertical: 18,
      ),
      child: Row(
        children: [
          // Logo
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (b) => AppColors.gradient1.createShader(
              Rect.fromLTWH(0, 0, b.width, b.height),
            ),
            child: Text(
              'HIBUZ',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: widget.isMobile ? 16 : 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const Spacer(),
          if (!widget.isMobile)
            ..._navItems.asMap().entries.map((e) {
              final i = e.key;
              final label = e.value;
              final active = widget.activeIndex == i;
              final hovered = _hovered == i;

              return MouseRegion(
                onEnter: (_) => setState(() => _hovered = i),
                onExit: (_) => setState(() => _hovered = null),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _handleTap(i),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: active || hovered
                            ? AppColors.cyan
                            : AppColors.white50,
                      ),
                      child: Text(label),
                    ),
                  ),
                ),
              );
            }),
          if (!widget.isMobile) ...[
            const SizedBox(width: 36),
            _HireCTA(),
          ],
          if (widget.isMobile)
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: AppColors.white),
              color: AppColors.card,
              onSelected: _handleTap,
              itemBuilder: (_) => _navItems
                  .asMap()
                  .entries
                  .map((e) => PopupMenuItem(
                value: e.key,
                child: Text(
                  e.value,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _HireCTA extends StatefulWidget {
  @override
  State<_HireCTA> createState() => _HireCTAState();
}

class _HireCTAState extends State<_HireCTA> {
  bool _hovered = false;

  Future<void> _openLink() async {
    final Uri url = Uri.parse("https://react-jewellery.onrender.com");

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openLink, // ✅ CLICK ADDED
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            gradient:
            _hovered ? AppColors.gradient2 : AppColors.gradient1,
            borderRadius: BorderRadius.circular(4),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: AppColors.cyan.withOpacity(0.3),
                blurRadius: 16,
              )
            ]
                : [],
          ),
          child: const Text(
            'LIVE PROJECT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}