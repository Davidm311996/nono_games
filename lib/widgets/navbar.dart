import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/language.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class NavBar extends StatefulWidget {
  final Language currentLanguage;
  final Function(Language) onLanguageChanged;
  final Function(String) onNavigate;
  final String currentPage;

  const NavBar({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.onNavigate,
    required this.currentPage,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // No local state, using provider

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 768;

    String getText(String en, String fr, String es) => languageProvider.getText(en, fr, es);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Creamy White
        borderRadius: BorderRadius.circular(50), 
        border: Border.all(
          color: const Color(0xFF3C3530), // Charcoal Brown
          width: 4, // Thicker bubbly borders
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 0,
            offset: Offset(6, 6), // 3D deep shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              // Logo/Brand with Bouncy Effect & #221616 background
              _buildBouncyBrand(isMobile),
              const Spacer(),
              // Navigation Links
              if (!isMobile) ...[
                _buildNavLink('home', getText('Home', 'Accueil', 'Inicio')),
                const SizedBox(width: 32),
                _buildNavLink('about', getText('Our Story', 'Notre Histoire', 'Nuestra Historia')),
                const SizedBox(width: 32),
              ],
              // Language Selector
              _buildActionIcon(
                onTap: () {
                  Language nextLang = languageProvider.currentLanguage == Language.english
                      ? Language.french
                      : languageProvider.currentLanguage == Language.french
                          ? Language.spanish
                          : Language.english;
                  languageProvider.setLanguage(nextLang);
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation.drive(CurveTween(curve: Curves.elasticOut)),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Text(
                  languageProvider.currentLanguage == Language.english
                      ? 'EN'
                      : languageProvider.currentLanguage == Language.french
                          ? 'FR'
                          : 'ES',
                  key: ValueKey(languageProvider.currentLanguage),
                    style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF3C3530),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Cart
              _buildActionIcon(
                onTap: () => widget.onNavigate('cart'),
                child: const Icon(
                  Icons.shopping_bag,
                  color: const Color(0xFF3C3530),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBouncyBrand(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF221616), // Requested background for logo
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10, width: 2),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onNavigate('home'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 40,
                errorBuilder: (c, e, s) => const Text('🎴', style: TextStyle(fontSize: 26)),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
               .scale(duration: 1.seconds, curve: Curves.bounceOut),
              const SizedBox(width: 12),
              if (!isMobile)
                Text(
                  'NANO GAMES',
                  style: GoogleFonts.fredoka(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon({required VoidCallback onTap, required Widget child}) {
    return _BouncyHover(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF3C3530).withOpacity(0.05),
            border: Border.all(color: const Color(0xFF3C3530).withOpacity(0.1)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildNavLink(String page, String label) {
    final isActive = widget.currentPage == page;
    return _BouncyHover(
      child: GestureDetector(
        onTap: () => widget.onNavigate(page),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.fredoka(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: isActive ? const Color(0xFF3C3530) : const Color(0xFF3C3530).withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class _BouncyHover extends StatefulWidget {
  final Widget child;
  const _BouncyHover({required this.child});

  @override
  State<_BouncyHover> createState() => _BouncyHoverState();
}

class _BouncyHoverState extends State<_BouncyHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: _isHovered ? 1.2 : 1.0,
        curve: Curves.elasticOut,
        child: widget.child,
      ),
    );
  }
}
