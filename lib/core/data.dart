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
      icon: Icons.web_rounded,
      title: 'Web Development',
      desc: 'Blazing-fast, SEO-optimised websites and web apps built with modern frameworks like React, Next.js, and Flutter Web.',
      accent: const Color(0xFF00D4FF),
    ),
    ServiceModel(
      icon: Icons.phone_android_rounded,
      title: 'Mobile Apps',
      desc: 'Cross-platform iOS & Android apps using Flutter and React Native — one codebase, native performance.',
      accent: const Color(0xFF00FF88),
    ),
    ServiceModel(
      icon: Icons.cloud_rounded,
      title: 'Cloud & DevOps',
      desc: 'Scalable cloud architecture on AWS, GCP, and Azure. CI/CD pipelines, Docker, Kubernetes, and infrastructure as code.',
      accent: const Color(0xFF7B61FF),
    ),
    ServiceModel(
      icon: Icons.bar_chart_rounded,
      title: 'AI & Data',
      desc: 'Machine learning models, data pipelines, and AI-powered product features that transform raw data into business value.',
      accent: const Color(0xFFFF6B6B),
    ),
    ServiceModel(
      icon: Icons.lock_rounded,
      title: 'Cybersecurity',
      desc: 'Security audits, penetration testing, and hardened architectures to protect your systems and user data.',
      accent: const Color(0xFFFFD93D),
    ),
    ServiceModel(
      icon: Icons.design_services_rounded,
      title: 'UI/UX Design',
      desc: 'Research-driven design systems and pixel-perfect interfaces that users love and that convert.',
      accent: const Color(0xFFFF61DC),
    ),
  ];

  static final projects = [
    ProjectModel(
      title: 'FinFlow',
      category: 'Fintech SaaS',
      desc: 'Real-time payment processing platform handling 2M+ transactions/day with sub-50ms latency.',
      tags: ['Flutter', 'Node.js', 'PostgreSQL', 'AWS'],
      accent: const Color(0xFF00D4FF),
    ),
    ProjectModel(
      title: 'MediLink',
      category: 'Healthcare',
      desc: 'Telemedicine app connecting 500K+ patients with doctors across 12 states. HIPAA compliant.',
      tags: ['React Native', 'Django', 'Redis', 'GCP'],
      accent: const Color(0xFF00FF88),
    ),
    ProjectModel(
      title: 'LogiTrack',
      category: 'Logistics',
      desc: 'End-to-end supply chain visibility platform with ML-powered demand forecasting and route optimisation.',
      tags: ['Next.js', 'Python', 'TensorFlow', 'Azure'],
      accent: const Color(0xFF7B61FF),
    ),
    ProjectModel(
      title: 'EduSphere',
      category: 'EdTech',
      desc: 'Adaptive learning platform serving 100K+ students with personalised AI-generated study paths.',
      tags: ['Flutter', 'FastAPI', 'OpenAI', 'Firebase'],
      accent: const Color(0xFFFFD93D),
    ),
  ];

  static final techStack = [
    TechModel(name: 'Flutter', category: 'Mobile / Web'),
    TechModel(name: 'React', category: 'Frontend'),
    TechModel(name: 'Next.js', category: 'Frontend'),
    TechModel(name: 'Node.js', category: 'Backend'),
    TechModel(name: 'Python', category: 'Backend'),
    TechModel(name: 'Django', category: 'Backend'),
    TechModel(name: 'FastAPI', category: 'Backend'),
    TechModel(name: 'PostgreSQL', category: 'Database'),
    TechModel(name: 'MongoDB', category: 'Database'),
    TechModel(name: 'Redis', category: 'Cache'),
    TechModel(name: 'AWS', category: 'Cloud'),
    TechModel(name: 'GCP', category: 'Cloud'),
    TechModel(name: 'Docker', category: 'DevOps'),
    TechModel(name: 'Kubernetes', category: 'DevOps'),
    TechModel(name: 'TensorFlow', category: 'AI / ML'),
    TechModel(name: 'OpenAI API', category: 'AI / ML'),
  ];

  static final testimonials = [
    TestimonialModel(
      quote: 'DevCo delivered our fintech platform 2 weeks ahead of schedule. The code quality and architecture were exceptional — far beyond what we expected.',
      name: 'Arun Kumar',
      role: 'CTO',
      company: 'FinFlow Inc.',
    ),
    TestimonialModel(
      quote: 'They understood our healthcare domain constraints from day one. HIPAA compliance, security, and UX — all nailed perfectly.',
      name: 'Dr. Meena Rajan',
      role: 'Founder',
      company: 'MediLink Health',
    ),
    TestimonialModel(
      quote: 'Our app went from idea to App Store in 14 weeks. The Flutter expertise they brought was world-class.',
      name: 'Vikram Shah',
      role: 'Product Manager',
      company: 'LogiTrack Solutions',
    ),
  ];
}