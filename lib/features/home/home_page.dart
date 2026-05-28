import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final _contactFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Timer? _roleTimer;
  int _roleIndex = 0;

  final List<String> _roles = const [
    'Flutter Developer',
    'UI Engineer',
    'Mobile App Builder',
    'Firebase Integrator',
  ];

  final List<Map<String, String>> _projects = const [
    {
      'title': 'FinTrack',
      'description': 'A clean budgeting app with charts, goals, and smart reminders.',
      'image': 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/',
    },
    {
      'title': 'TravelMate',
      'description': 'An itinerary planner designed for smooth trip management and offline access.',
      'image': 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/',
    },
    {
      'title': 'TaskFlow',
      'description': 'A productivity dashboard for personal task tracking and team collaboration.',
      'image': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/',
    },
    {
      'title': 'ShopGrid',
      'description': 'A modern commerce experience with cart handling and responsive product browsing.',
      'image': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Cycles through the intro text so the hero feels alive without being distracting.
    _roleTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        _roleIndex = (_roleIndex + 1) % _roles.length;
      });
    });
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) {
      return;
    }
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  void _downloadCv() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dummy CV download action triggered.')),
    );
  }

  void _submitContactForm() {
    if (_contactFormKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully.')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF64B5F6),
      brightness: Brightness.dark,
      primary: const Color(0xFF74B9FF),
      secondary: const Color(0xFF7AE7C7),
      surface: const Color(0xFF111827),
    );

    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFF090D14),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF111827),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF0F172A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFF233047)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFF74B9FF), width: 1.4),
          ),
          labelStyle: const TextStyle(color: Color(0xFFB8C4D9)),
        ),
      ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            const _PortfolioBackdrop(),
            Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionContainer(
                      key: _homeKey,
                      child: _buildHeroSection(context),
                    ),
                    _SectionContainer(
                      key: _aboutKey,
                      child: _buildAboutSection(context),
                    ),
                    _SectionContainer(
                      key: _projectsKey,
                      child: _buildProjectsSection(context),
                    ),
                    _SectionContainer(
                      key: _contactKey,
                      child: _buildContactSection(context),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showInlineActions = width >= 780;

    return AppBar(
      toolbarHeight: 78,
      titleSpacing: 24,
      title: const Text('Portfolio'),
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: [
        if (showInlineActions)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavButton(label: 'Home', onPressed: () => _scrollTo(_homeKey)),
              _NavButton(label: 'About', onPressed: () => _scrollTo(_aboutKey)),
              _NavButton(label: 'Projects', onPressed: () => _scrollTo(_projectsKey)),
              _NavButton(label: 'Contact', onPressed: () => _scrollTo(_contactKey)),
            ],
          )
        else
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded),
            onSelected: (value) {
              switch (value) {
                case 'home':
                  _scrollTo(_homeKey);
                  break;
                case 'about':
                  _scrollTo(_aboutKey);
                  break;
                case 'projects':
                  _scrollTo(_projectsKey);
                  break;
                case 'contact':
                  _scrollTo(_contactKey);
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'home', child: Text('Home')),
              PopupMenuItem(value: 'about', child: Text('About')),
              PopupMenuItem(value: 'projects', child: Text('Projects')),
              PopupMenuItem(value: 'contact', child: Text('Contact')),
            ],
          ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 920;
        final content = isWide
            ? Row(
                children: [
                  Expanded(child: _HeroCopy(roles: _roles, roleIndex: _roleIndex, onDownloadCv: _downloadCv)),
                  const SizedBox(width: 32),
                  Expanded(child: _HeroVisual(onDownloadCv: _downloadCv)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroVisual(onDownloadCv: _downloadCv),
                  const SizedBox(height: 28),
                  _HeroCopy(roles: _roles, roleIndex: _roleIndex, onDownloadCv: _downloadCv),
                ],
              );

        return _SectionFrame(
          label: 'INTRODUCTION',
          title: 'A modern portfolio for a Flutter developer.',
          subtitle: 'Clean interfaces, smooth motion, and responsive layouts built with Material 3.',
          child: content,
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return _SectionFrame(
      label: 'ABOUT',
      title: 'A short bio with focused skills.',
      subtitle: 'Built for users who want clarity, speed, and polished mobile experiences.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final bioColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I design and build Flutter apps with strong attention to motion, usability, and detail.\n'
                'My work focuses on creating interfaces that feel premium while remaining practical and maintainable.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.7,
                      color: const Color(0xFFCBD5E1),
                    ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _SkillChip(label: 'Flutter'),
                  _SkillChip(label: 'Dart'),
                  _SkillChip(label: 'Firebase'),
                  _SkillChip(label: 'API'),
                  _SkillChip(label: 'UI/UX'),
                ],
              ),
            ],
          );

          final statsColumn = Column(
            children: const [
              _AboutStat(title: '3+ Years', subtitle: 'Mobile app experience'),
              SizedBox(height: 16),
              _AboutStat(title: '15+ Apps', subtitle: 'Personal and client work'),
              SizedBox(height: 16),
              _AboutStat(title: '100%', subtitle: 'Focus on responsive design'),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: bioColumn),
                const SizedBox(width: 24),
                SizedBox(width: 260, child: statsColumn),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bioColumn,
              const SizedBox(height: 24),
              statsColumn,
            ],
          );
        },
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return _SectionFrame(
      label: 'PROJECTS',
      title: 'Selected work presented in a responsive grid.',
      subtitle: 'Each project card is intentionally simple, fast to scan, and easy to adapt.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossAxisCount = width >= 1150
              ? 3
              : width >= 720
                  ? 2
                  : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: crossAxisCount == 1 ? 1.02 : 0.9,
            ),
            itemBuilder: (context, index) {
              final project = _projects[index];
              return _ProjectCard(
                title: project['title']!,
                description: project['description']!,
                imageUrl: project['image']!,
                githubUrl: project['github']!,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return _SectionFrame(
      label: 'CONTACT',
      title: 'Let’s build something polished together.',
      subtitle: 'Dummy contact details and a working form are included for the first version.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final contactDetails = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _ContactLine(icon: Icons.email_outlined, title: 'Email', value: 'hello@yourportfolio.dev'),
              SizedBox(height: 16),
              _ContactLine(icon: Icons.link_outlined, title: 'LinkedIn', value: 'linkedin.com/in/yourprofile'),
              SizedBox(height: 16),
              _ContactLine(icon: Icons.code_outlined, title: 'GitHub', value: 'github.com/yourprofile'),
            ],
          );

          final form = Form(
            key: _contactFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Color(0xFFE5EEF9)),
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Color(0xFFE5EEF9)),
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  style: const TextStyle(color: Color(0xFFE5EEF9)),
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    hintText: 'Tell me about your project',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 10) {
                      return 'Please enter a short message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    onPressed: _submitContactForm,
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Send Message'),
                  ),
                ),
              ],
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: contactDetails),
                const SizedBox(width: 24),
                Expanded(child: form),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              contactDetails,
              const SizedBox(height: 24),
              form,
            ],
          );
        },
      ),
    );
  }
}

class _PortfolioBackdrop extends StatelessWidget {
  const _PortfolioBackdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF090D14), Color(0xFF0B1220), Color(0xFF090D14)],
          ),
        ),
        child: Stack(
          children: const [
            Positioned(
              top: -80,
              right: -60,
              child: _BackdropOrb(color: Color(0x3342A5F5), size: 220),
            ),
            Positioned(
              top: 420,
              left: -40,
              child: _BackdropOrb(color: Color(0x2240C9A2), size: 180),
            ),
            Positioned(
              bottom: 120,
              right: 80,
              child: _BackdropOrb(color: Color(0x1A7C8CF8), size: 140),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackdropOrb extends StatelessWidget {
  const _BackdropOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({super.key, required this.child});

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

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
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

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.roles,
    required this.roleIndex,
    required this.onDownloadCv,
  });

  final List<String> roles;
  final int roleIndex;
  final VoidCallback onDownloadCv;

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
          'Your Name',
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: const Color(0xFFF8FAFC),
            height: 1.05,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'I craft modern Flutter experiences that combine performance, clarity, and a refined visual language.',
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
              onPressed: () {},
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.onDownloadCv});

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
                  child: Image.network(
                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=1200&q=80',
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(child: _MiniStat(value: '10+', label: 'Projects')),
                    SizedBox(width: 12),
                    Expanded(child: _MiniStat(value: '4.9', label: 'Rating')),
                    SizedBox(width: 12),
                    Expanded(child: _MiniStat(value: '100%', label: 'Responsive')),
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
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF9FB0C7),
                ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.githubUrl,
  });

  final String title;
  final String description;
  final String imageUrl;
  final String githubUrl;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        scale: _isHovered ? 1.02 : 1.0,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFF4F7FB),
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFB3C1D4),
                              height: 1.6,
                            ),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: const Icon(Icons.code_rounded),
                        label: const Text('GitHub'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

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

class _AboutStat extends StatelessWidget {
  const _AboutStat({required this.title, required this.subtitle});

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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF9FB0C7),
                ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  const _NavButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _hovered ? 1.04 : 1.0,
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFF4F7FB),
            backgroundColor: _hovered ? const Color(0xFF14213A) : Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
