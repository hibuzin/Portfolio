import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/constants.dart';
import '../widgets/shared_widgets.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      isMobile: isMobile,
      color: AppColors.bg,
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_ContactInfo(), const SizedBox(height: 48), _ContactForm()],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _ContactInfo()),
          const SizedBox(width: 80),
          Expanded(flex: 3, child: _ContactForm()),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(text: 'GET IN TOUCH'),
        const SizedBox(height: 20),
        GradientText(
          text: 'Let\'s Build\nSomething\nGreat.',
          style: AppText.heading,
          gradient: AppColors.gradient1,
        ),
        const SizedBox(height: 20),
        const Text(
          'Got a project in mind? Tell us about it — we\'ll get back Asap.',
          style: AppText.body,
        ),
        const SizedBox(height: 40),
        _InfoRow(icon: Icons.email_outlined, text: 'hibuzin@gmail.com'),
        const SizedBox(height: 16),
        _InfoRow(icon: Icons.phone_outlined, text: '+91 8526854562'),
        const SizedBox(height: 16),
        _InfoRow(icon: Icons.location_on_outlined, text: 'Chennai, India'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyan, size: 18),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: AppColors.white80, fontSize: 14)),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  const _SocialIcon({required this.icon, required this.label});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cyan.withOpacity(0.1) : AppColors.card,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: _hovered ? AppColors.cyan : AppColors.cardBorder),
        ),
        child: Icon(widget.icon,
            color: _hovered ? AppColors.cyan : AppColors.white50, size: 18),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool loading = false;

  Future<void> sendMessage() async {
    setState(() => loading = true);

    try {
      final response = await http.post(
        Uri.parse("https://land-backo.onrender.com/api/contact"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "message": messageController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Message sent successfully")),
        );

        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
              color: AppColors.cyan.withOpacity(0.06),
              blurRadius: 40,
              spreadRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ANY QUARIES',
              style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white)),
          const SizedBox(height: 28),

          _CyberInput(hint: 'Your Name', controller: nameController),
          const SizedBox(height: 16),

          _CyberInput(hint: 'Email Address', controller: emailController),
          const SizedBox(height: 16),

          _CyberInput(
            hint: 'Tell us about your project...',
            maxLines: 4,
            controller: messageController,
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: CyberButton(
              label: loading ? 'Sending...' : 'Send Message →',
              onTap: loading
                  ? () {}
                  : () {
                sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CyberInput extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;

  const _CyberInput({
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
          fontFamily: 'Courier',
          color: AppColors.white,
          fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: AppColors.white50, fontSize: 13, fontFamily: 'Courier'),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.cardBorder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.cardBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.cyan, width: 1.5)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}