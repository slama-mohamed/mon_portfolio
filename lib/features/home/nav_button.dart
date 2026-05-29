import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
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
            backgroundColor: _hovered
                ? const Color(0xFF14213A)
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
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
