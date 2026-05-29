import 'package:flutter/material.dart';

class PortfolioBackdrop extends StatelessWidget {
  const PortfolioBackdrop({super.key});

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
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0.0)]),
      ),
    );
  }
}