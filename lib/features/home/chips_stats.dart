import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      labelStyle: const TextStyle(
        color: Color(0xFFF4F7FB),
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: const Color(0xFF14213A),
      side: const BorderSide(color: Color(0xFF233047)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    );
  }
}

class AboutStat extends StatelessWidget {
  const AboutStat({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF233047)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFFF4F7FB),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF9FB0C7)),
          ),
        ],
      ),
    );
  }
}