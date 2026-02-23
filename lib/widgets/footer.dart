import 'package:flutter/material.dart';
import '../core/constants.dart';

class FooterWidget extends StatelessWidget {
  final bool isMobile;
  const FooterWidget({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF050810),
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80, vertical: 28),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _content(),
      )
          : Row(children: _content()),
    );
  }

  List<Widget> _content() => [
    ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (b) => AppColors.gradient1
          .createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
      child: const Text('DEV<CO/>',
          style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 18,
              fontWeight: FontWeight.w900)),
    ),
    if (!isMobile) const Spacer(),
    if (isMobile) const SizedBox(height: 12),
    const Text(
      '© 2025 DevCo. All rights reserved. · Made in Chennai 🇮🇳',
      style: TextStyle(color: AppColors.white50, fontSize: 12),
    ),
  ];
}