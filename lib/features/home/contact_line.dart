import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactLine extends StatelessWidget {
  const ContactLine({super.key, 
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        final target = _normalizeTarget(value);
        final uri = Uri.tryParse(target);
        if (uri == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid contact link')),
          );
          return;
        }
        try {
          final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (!launched) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open link')),
            );
          }
        } catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open link')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF233047)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF14213A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: const Color(0xFF74B9FF)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF90B8FF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFFF4F7FB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _normalizeTarget(String value) {
    final trimmed = value.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://') || trimmed.startsWith('mailto:')) {
      return trimmed;
    }
    if (trimmed.contains('@')) {
      return 'mailto:$trimmed';
    }
    return 'https://$trimmed';
  }
}