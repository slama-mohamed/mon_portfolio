import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: child,
        ),
      ),
    );
  }
}

class SectionFrame extends StatelessWidget {
  const SectionFrame({super.key, 
    required this.label,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String label;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A).withValues(alpha: 0.84),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFF233047)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(label: label, title: title, subtitle: subtitle),
              const SizedBox(height: 28),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.title,
    required this.subtitle,
  });

  final String label;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF14213A),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFF233047)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF90B8FF),
              fontSize: 12,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFFF4F7FB),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF9FB0C7),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}