import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFooter extends StatelessWidget {
  final String currentPage;

  const AppFooter({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9E3), // Warm Sand Background
        borderRadius: const BorderRadius.vertical(top: Radius.circular(60)),
        border: Border.all(
          color: const Color(0xFF3C3530), // Charcoal Brown
          width: 4,
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 0,
            offset: Offset(0, -8),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 30 : 100,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NANO\nGAMES.',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF3C3530),
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Connecting the world through playful, faith-based gameplay. Every card tells a story, every game builds a bond.',
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        color: const Color(0xFF3C3530).withOpacity(0.5),
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      children: [
                        _buildSocialIcon('f'),
                        const SizedBox(width: 16),
                        _buildSocialIcon('𝕏'),
                        const SizedBox(width: 16),
                        _buildSocialIcon('ig'),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const Spacer(flex: 1),
                _buildFooterLinks('COMPANY', ['About Us', 'Contact', 'Blog']),
                const SizedBox(width: 80),
                _buildFooterLinks('SHOP', ['New Arrivals', 'Deck Gallery', 'FAQ']),
                const SizedBox(width: 80),
                _buildFooterLinks('LEGAL', ['Privacy Policy', 'Terms of Service', 'Shipping']),
              ],
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 64),
            Wrap(
              spacing: 32,
              runSpacing: 20,
              children: [
                _buildMobileLink('About'),
                _buildMobileLink('Shop'),
                _buildMobileLink('Contact'),
                _buildMobileLink('Privacy'),
              ],
            ),
          ],
          const SizedBox(height: 100),
          Container(
            height: 1.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2024 NANO GAMES. ALL RIGHTS RESERVED.',
                style: GoogleFonts.fredoka(
                  fontSize: 11,
                  color: const Color(0xFF3C3530).withOpacity(0.4),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'MADE WITH 🕊️ FOR THE FAITHFUL.',
                style: GoogleFonts.fredoka(
                  fontSize: 11,
                  color: const Color(0xFF3C3530).withOpacity(0.4),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.fredoka(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3C3530),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              link,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                color: const Color(0xFF3C3530).withOpacity(0.6),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildMobileLink(String text) {
    return Text(
      text,
      style: GoogleFonts.fredoka(
        fontSize: 13,
        color: const Color(0xFF3C3530).withOpacity(0.6),
      ),
    );
  }

  Widget _buildSocialIcon(String icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF3C3530).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            icon,
            style: const TextStyle(
              color: Color(0xFF3C3530),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
