import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/features/home/chips_stats.dart';
import 'package:portfolio/features/home/contact_line.dart';
import 'package:portfolio/features/home/hero.dart';
import 'package:portfolio/features/home/layout_helpers.dart';
import 'package:portfolio/features/home/nav_button.dart';
import 'package:portfolio/features/home/portfolio_backdrop.dart';
import 'package:portfolio/features/home/project_card.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    'AI Engineer',
    'Mobile App Builder',
    'CS Engineering Student',
  ];

  final List<Map<String, String>> _projects = const [
    {
      'title': 'Psychora',
      'description':
          'AI-powered psychiatric diagnostic assistant using NLP and fine-tuned transformer models for disorder classification and progressive dialogue-based reasoning.',
      'image':
          'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/slama-mohamed/psychora',
      'tags': 'Python · NLP · Hugging Face',
    },
    {
      'title': 'SafeFile',
      'description':
          'Secure file storage and management platform with file upload, organisation, and access management — built with Flutter and backend APIs.',
      'image':
          'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/slama-mohamed/SafeFile',
      'tags': 'Flutter · Dart · REST APIs',
    },
    {
      'title': 'Neo School',
      'description':
          'Mobile application for school management and student interaction, featuring responsive UI components and complete educational workflows.',
      'image':
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/InnoTeamSolutions/neoschool-guardian-mobile',
      'tags': 'Flutter · Dart',
    },
    {
      'title': 'Portfolio',
      'description':
          'This very portfolio — a cross-platform Flutter app with Material 3, smooth scroll navigation, responsive layouts, and a working contact form.',
      'image':
          'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=1200&q=80',
      'github': 'https://github.com/slama-mohamed/mon_portfolio',
      'tags': 'Flutter · Dart · Material 3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _roleTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
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
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  void _downloadCv() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.92,
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: const Color(0xFF111827),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'CV Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close, color: Colors.white),
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SfPdfViewer.asset('assets/pdf/mohamed_slama.pdf'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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
            const PortfolioBackdrop(),
            Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionContainer(
                      key: _homeKey,
                      child: _buildHeroSection(context),
                    ),
                    SectionContainer(
                      key: _aboutKey,
                      child: _buildAboutSection(context),
                    ),
                    SectionContainer(
                      key: _projectsKey,
                      child: _buildProjectsSection(context),
                    ),
                    SectionContainer(
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
              NavButton(label: 'Home', onPressed: () => _scrollTo(_homeKey)),
              NavButton(label: 'About', onPressed: () => _scrollTo(_aboutKey)),
              NavButton(
                label: 'Projects',
                onPressed: () => _scrollTo(_projectsKey),
              ),
              NavButton(
                label: 'Contact',
                onPressed: () => _scrollTo(_contactKey),
              ),
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
                  Expanded(
                    child: HeroCopy(
                      roles: _roles,
                      roleIndex: _roleIndex,
                                onDownloadCv: _downloadCv,
                                onContact: () => _scrollTo(_contactKey),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(child: HeroVisual(onDownloadCv: _downloadCv)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeroVisual(onDownloadCv: _downloadCv),
                  const SizedBox(height: 28),
                          HeroCopy(
                            roles: _roles,
                            roleIndex: _roleIndex,
                            onDownloadCv: _downloadCv,
                            onContact: () => _scrollTo(_contactKey),
                          ),
                ],
              );

        return SectionFrame(
          label: 'INTRODUCTION',
          title: 'Computer Science Engineering Student .',
          subtitle:
              'Building AI-powered systems and polished mobile experiences — from ENSI, Tunisia.',
          child: content,
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return  SectionFrame(
      label: 'ABOUT',
      title: 'Passionate about software, mobile, and AI.',
      subtitle:
          'Currently studying Computer Science Engineering at ENSI with hands-on experience in Flutter and NLP.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final bioColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I am a Computer Science Engineering student at ENSI (Tunisia) with a strong interest in '
                'mobile development, artificial intelligence, and scalable software design.\n\n'
                'I have interned at InnoTeam Solutions and IB Space, building cross-platform Flutter apps, '
                'integrating REST APIs, and applying clean architecture principles. Outside of classes I '
                'contribute to hackathons and workshops through ECPC Club and the IEEE Student Branch at ENSI.',
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
                  SkillChip(label: 'Flutter'),
                  SkillChip(label: 'Dart'),
                  SkillChip(label: 'Python'),
                  SkillChip(label: 'NLP'),
                  SkillChip(label: 'Hugging Face'),
                  SkillChip(label: 'Firebase'),
                  SkillChip(label: 'REST APIs'),
                  SkillChip(label: 'C/C++'),
                  SkillChip(label: 'Java'),
                  SkillChip(label: 'Git'),
                ],
              ),
            ],
          );

          final statsColumn = Column(
            children: const [
              AboutStat(
                title: '2+ Years',
                subtitle: 'Flutter development experience',
              ),
              SizedBox(height: 16),
              AboutStat(
                title: '3+ Projects',
                subtitle: 'Personal & internship work',
              ),
              SizedBox(height: 16),
              AboutStat(
                title: 'Top 167',
                subtitle: 'National Engineering Exam (/ 1750)',
              ),
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
            children: [bioColumn, const SizedBox(height: 24), statsColumn],
          );
        },
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return SectionFrame(
      label: 'PROJECTS',
      title: 'Selected work — mobile apps and AI systems.',
      subtitle:
          'Each project reflects a focus on clean architecture, real-world utility, and thoughtful UI design.',
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
              mainAxisExtent: crossAxisCount == 1 ? 430 : 450,
            ),
            itemBuilder: (context, index) {
              final project = _projects[index];
              return ProjectCard(
                title: project['title']!,
                description: project['description']!,
                imageUrl: project['image']!,
                githubUrl: project['github']!,
                tags: project['tags']!,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return SectionFrame(
      label: 'CONTACT',
      title: 'Let\'s build something great together.',
      subtitle:
          'Feel free to reach out for internship opportunities, collaborations, or just to connect.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final contactDetails = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ContactLine(
                icon: Icons.email_outlined,
                title: 'Email',
                value: 'mohamed.slama@ensi-uma.tn',
              ),
              SizedBox(height: 16),
              ContactLine(
                icon: Icons.link_outlined,
                title: 'LinkedIn',
                value: 'linkedin.com/in/mohamed-slama-4677a5323',
              ),
              SizedBox(height: 16),
              ContactLine(
                icon: Icons.code_outlined,
                title: 'GitHub',
                value: 'github.com/slama-mohamed',
              ),
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
                    hintText: 'Tell me about your project or opportunity',
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
            children: [contactDetails, const SizedBox(height: 24), form],
          );
        },
      ),
    );
  }
}

