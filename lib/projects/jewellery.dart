import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class JewelleryDetailPage extends StatelessWidget {
  const JewelleryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text("LUXURY GOLD"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Title
            const Text(
              "Luxury Gold Jewellery Platform",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// Description
            const Text(
              "Premium online jewellery store showcasing gold, diamond, and bridal collections with secure checkout and seamless shopping experience.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 30),

            /// Features Section
            const Text(
              "Key Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 16),

            const FeatureItem(text: "User Authentication & JWT Security"),
            const FeatureItem(text: "Wishlist & Add to Cart"),
            const FeatureItem(text: "Order Management System"),
            const FeatureItem(text: "Admin Dashboard"),
            const FeatureItem(text: "Online Payment Integration"),
            const FeatureItem(text: "Product Filtering & Categories"),

            const SizedBox(height: 30),

            /// Tech Stack
            const Text(
              "Tech Stack",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.amber,
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 10,
              children: const [
                Chip(label: Text("React")),
                Chip(label: Text("Node.js")),
                Chip(label: Text("MongoDB")),
                Chip(label: Text("Render")),
              ],
            ),

            const SizedBox(height: 40),

            /// Live Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse("https://react-jewellery.onrender.com");

                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not launch project")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                ),
                child: const Text(
                  "View Live Project",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Feature Bullet Widget
class FeatureItem extends StatelessWidget {
  final String text;
  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.amber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}