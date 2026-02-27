import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends StatefulWidget {
  final String title;
  final String description;
  final String icon;
  final LinearGradient gradient;
  final int cardNumber;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.cardNumber,
    this.onTap,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return _BouncyCard(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: const Color(0xFFFAF9F6), // Creamy White
            border: Border.all(color: const Color(0xFF3C3530), width: 4), // Charcoal Brown
            boxShadow: [
              const BoxShadow(
                color: Color(0xFF3C3530), // Charcoal Brown Deep Shadow
                blurRadius: 0,
                offset: Offset(8, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Visual/Image Area
              Positioned.fill(
                child: Center(
                  child: Text(
                    widget.icon,
                    style: const TextStyle(fontSize: 100),
                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                   .shake(hz: 2, curve: Curves.easeInOut),
                ),
              ),
              // Glass Bottom Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title.toUpperCase(),
                        style: GoogleFonts.fredoka(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF3C3530),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'LVL ${widget.cardNumber}',
                          style: GoogleFonts.fredoka(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3C3530).withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BouncyCard extends StatefulWidget {
  final Widget child;
  const _BouncyCard({required this.child});

  @override
  State<_BouncyCard> createState() => _BouncyCardState();
}

class _BouncyCardState extends State<_BouncyCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 500),
        scale: _isHovered ? 1.05 : 1.0,
        curve: Curves.elasticOut,
        child: AnimatedRotation(
          duration: const Duration(milliseconds: 500),
          turns: _isHovered ? 0.01 : 0,
          curve: Curves.elasticOut,
          child: widget.child,
        ),
      ),
    );
  }
}
