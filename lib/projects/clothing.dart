import 'package:flutter/material.dart';
import '../core/constants.dart';

const cyan = Color(0xFF00D4FF);
const cyanDim = Color(0xFF0099BB);

class ClothingDetailPage extends StatelessWidget {
  ClothingDetailPage({super.key});

  final images = [
    'assets/images/clothing/img.jpeg',
    'assets/images/clothing/img1.jpeg',
    'assets/images/clothing/img2.jpeg',
    'assets/images/clothing/img3.jpeg',
    'assets/images/clothing/img4.jpeg',
    'assets/images/clothing/img5.jpeg',
    'assets/images/clothing/img6.jpeg',
    'assets/images/clothing/img7.jpeg',
    'assets/images/clothing/img8.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final rowCount = (images.length / 3).ceil();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          "PATRO CLOTHING",
          style: TextStyle(
            color: cyan,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          children: List.generate(rowCount, (rowIndex) {
            final i0 = rowIndex * 3;
            final i1 = i0 + 1;
            final i2 = i0 + 2;

            final hasI1 = i1 < images.length;
            final hasI2 = i2 < images.length;

            return Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// LEFT SIDE IMAGES (TALL + SLIM)
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: _HoverImageCard(
                            imagePath: images[i0],
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (hasI1)
                          Expanded(
                            child: _HoverImageCard(
                              imagePath: images[i1],
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// RIGHT SIDE DETAIL
                  Expanded(
                    flex: 6,
                    child: hasI2
                        ? _DetailCard(
                      index: i2,
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HOVER IMAGE CARD (TALL STYLE)
////////////////////////////////////////////////////////////

class _HoverImageCard extends StatefulWidget {
  final String imagePath;

  const _HoverImageCard({required this.imagePath});

  @override
  State<_HoverImageCard> createState() => _HoverImageCardState();
}

class _HoverImageCardState extends State<_HoverImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scale = Tween(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _glow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.scale(
            scale: _scale.value,
            child: AspectRatio(
              aspectRatio: 3 / 5, // SLIM & TALL
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: cyan.withOpacity(0.15 + 0.35 * _glow.value),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cyan.withOpacity(0.18 * _glow.value),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    color: const Color(0xFF0F141A),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DETAIL CARD (MORE TEXT)
////////////////////////////////////////////////////////////

class _DetailCard extends StatefulWidget {
  final int index;

  const _DetailCard({required this.index});

  @override
  State<_DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<_DetailCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;
  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _glow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  String get title => "Premium UI Experience";
  String get description =>
      "This screen represents a refined and elegant user interface crafted "
          "for modern fashion commerce. The layout focuses on clarity, usability "
          "and premium visual hierarchy. Every element is carefully aligned to "
          "deliver a smooth browsing experience. Users can effortlessly explore "
          "collections, preview outfits, and navigate through product categories "
          "with intuitive gestures.\n\n"
          "Typography is minimal yet impactful, ensuring readability across "
          "different screen sizes. The spacing structure enhances focus on key "
          "content while maintaining visual breathing room. Micro-interactions "
          "and hover animations elevate the overall premium feel of the "
          "application.\n\n"
          "This design approach ensures scalability for future collections, "
          "seasonal campaigns, and promotional highlights while preserving "
          "brand consistency and luxury aesthetics.";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
        setState(() => _hover = true);
      },
      onExit: (_) {
        _controller.reverse();
        setState(() => _hover = false);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: const Color(0xFF111820),
              border: Border.all(
                color: cyan.withOpacity(0.15 + 0.3 * _glow.value),
              ),
              boxShadow: [
                BoxShadow(
                  color: cyan.withOpacity(0.15 * _glow.value),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SCREEN ${widget.index + 1}",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 4,
                    color: cyan.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    color: Colors.white.withOpacity(0.55),
                  ),
                ),
                const SizedBox(height: 26),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 2,
                  width: _hover ? 220 : 50,
                  color: cyan.withOpacity(0.5),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}