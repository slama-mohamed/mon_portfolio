import 'package:flutter/material.dart';

class HeroCopy extends StatelessWidget {
  const HeroCopy({super.key, 
    required this.roles,
    required this.roleIndex,
    required this.onDownloadCv,
    required this.onContact,
  });

  final List<String> roles;
  final int roleIndex;
  final VoidCallback onDownloadCv;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HELLO, I AM',
          style: textTheme.labelLarge?.copyWith(
            color: const Color(0xFF90B8FF),
            letterSpacing: 2.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Mohamed Slama',
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFFF8FAFC),
            height: 1.05,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'CS Engineering student at ENSI with hands-on experience in Flutter development '
          'and AI-powered systems — passionate about mobile, NLP, and scalable design.',
          style: textTheme.titleMedium?.copyWith(
            color: const Color(0xFFCBD5E1),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.bolt_rounded, color: Color(0xFF7AE7C7)),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.18),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  roles[roleIndex],
                  key: ValueKey<String>(roles[roleIndex]),
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF4F7FB),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            FilledButton.icon(
              onPressed: onDownloadCv,
              icon: const Icon(Icons.download_rounded),
              label: const Text('Download CV'),
            ),
            OutlinedButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }
}

class HeroVisual extends StatelessWidget {
  const HeroVisual({super.key, required this.onDownloadCv});

  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: const [
                    _SocialDot(color: Color(0xFF5B8DEF)),
                    SizedBox(width: 8),
                    _SocialDot(color: Color(0xFF40C9A2)),
                    SizedBox(width: 8),
                    _SocialDot(color: Color(0xFFF0B84B)),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/images/pcd_image.jpg',
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(
                      child: _MiniStat(value: '3+', label: 'Projects'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _MiniStat(value: '2', label: 'Internships'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _MiniStat(value: 'ENSI', label: 'University'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: onDownloadCv,
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('View CV Preview'),
          ),
        ),
      ],
    );
  }
}

class _SocialDot extends StatelessWidget {
  const _SocialDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF233047)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFFF4F7FB),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: const Color(0xFF9FB0C7)),
          ),
        ],
      ),
    );
  }
}
