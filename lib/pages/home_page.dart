import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/game_card.dart';
import '../models/language.dart';
import '../providers/language_provider.dart';

class HomePage extends StatefulWidget {
  final Function(String) onNavigate;

  const HomePage({super.key, required this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Using languageProvider.getText() instead of local getText()

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 900;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String getText(String en, String fr, String es) => languageProvider.getText(en, fr, es);

    // Simplified sections for natural scrolling
    final sections = [
      _buildHero(isMobile, getText),
      _buildProductShowcase(isMobile, getText),
      _buildBenefits(isMobile, screenWidth, getText),
      _buildLifestyle(isMobile, getText),
      _buildFinalCTA(isMobile, getText),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEDE9E3), // Warm Sand Background
      body: Stack(
        children: [
          // Natural Scrolling Body
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 140), // Increased Space for floating NavBar
                ...sections.map((section) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : 40,
                    vertical: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: isMobile ? 500 : 700,
                    ),
                    child: _buildPlayfulCard(section),
                  ),
                )),
                const AppFooter(currentPage: 'home'),
              ],
            ),
          ),


          // Floating Pill Navbar
          Positioned(
            top: 30,
            left: isMobile ? 15 : 60,
            right: isMobile ? 15 : 60,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: NavBar(
                  currentLanguage: languageProvider.currentLanguage,
                  onLanguageChanged: (lang) => languageProvider.setLanguage(lang),
                  onNavigate: widget.onNavigate,
                  currentPage: 'home',
                ),
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.5, end: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayfulCard(Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Soft Creamy White
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          const BoxShadow(
            color: Color(0xFF3C3530), // Charcoal Brown Deep Shadow
            blurRadius: 0,
            offset: Offset(8, 8),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF3C3530), // Charcoal Brown Border
          width: 4,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _buildHero(bool isMobile, String Function(String, String, String) getText) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/hero_visual.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black38,
            BlendMode.darken,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80), // Increased Padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40), // Extra top spacing for title
            // Massive Playful Subtitle
            _buildStrokeText(
              getText('PLAY TO', 'JOUEZ POUR', 'JUEGA PARA'),
              fontSize: isMobile ? 32 : 50,
              color: const Color(0xFF3C3530),
              strokeColor: Colors.white,
              strokeWidth: 4,
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5, end: 0),
            
            const SizedBox(height: 10),

            // GIANT MAIN TEXT
            FittedBox(
              child: _buildStrokeText(
                getText('NANO\nGAMES.', 'NANO\nGAMES.', 'NANO\nGAMES.'),
                fontSize: isMobile ? 80 : 180,
                color: const Color(0xFF3C3530),
                strokeColor: Colors.white,
                strokeWidth: 10,
                shadows: [
                  const Shadow(color: Colors.black12, offset: Offset(8, 8), blurRadius: 0),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 800.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

            const SizedBox(height: 10),

            _buildStrokeText(
              getText('THE ULTIMATE DECK', 'LE PONT ULTIME', 'EL MAZO DEFINITIVO'),
              fontSize: isMobile ? 24 : 40,
              color: Colors.grey[700]!,
              strokeColor: Colors.white,
              strokeWidth: 4,
            ).animate().fadeIn(delay: 400.ms, duration: 800.ms).slideY(begin: -0.5, end: 0),

            const SizedBox(height: 60),
            
            ElevatedButton(
              onPressed: () => widget.onNavigate('cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3C3530),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: const BorderSide(color: Colors.white, width: 4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getText('GET BEGUN', 'COMMENCER', 'EMPEZAR'),
                    style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.arrow_downward, size: 30),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1.seconds, curve: Curves.easeInOut),
          ],
        ),
      ),
    );
  }

  Widget _buildProductShowcase(bool isMobile, String Function(String, String, String) getText) {
    return Container(
      color: Colors.transparent, // Let card color show through
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: isMobile ? 20 : 60),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStrokeText(
                getText('NANO\nDECK.', 'PONT\nNANO.', 'MAZO\nNANO.'),
                fontSize: isMobile ? 50 : 100,
                color: const Color(0xFF3C3530),
                strokeColor: Colors.white,
                strokeWidth: 8,
              ),
              if (!isMobile)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C3530).withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('🎴', style: TextStyle(fontSize: 40)),
                ).animate(onPlay: (c) => c.repeat()).rotate(duration: 10.seconds),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: isMobile ? 300 : 500,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(
                  image: AssetImage('assets/Images/cards_layout.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: -20, duration: 3.seconds, curve: Curves.easeInOut),
          ),
          const SizedBox(height: 20),
          Text(
            getText('120+ CARDS OF PURE ART.', '120+ CARTES D\'ART PUR.', '120+ CARTAS DE ARTE PURO.'),
            style: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3C3530).withOpacity(0.6),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowcaseDetail(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFFD4A574),
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Container(height: 2, width: 40, color: const Color(0xFFD4A574).withOpacity(0.4)),
      ],
    );
  }

  Widget _buildBenefits(bool isMobile, double screenWidth, String Function(String, String, String) getText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: _buildPlayfulCard(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            children: [
              FittedBox(
                child: _buildStrokeText(
                  getText('CORE VALUES.', 'VALEURS CLÉS.', 'VALORES CLAVE.'),
                  fontSize: isMobile ? 60 : 120,
                  color: Colors.white,
                  strokeColor: const Color(0xFF3C3530),
                  strokeWidth: 8,
                  shadows: [
                    const Shadow(color: Colors.black12, offset: Offset(5, 5)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  _buildSimplePlayfulCard('🎯', getText('STRATEGY', 'STRATÉGIE', 'ESTRATEGIA'), isMobile),
                  _buildSimplePlayfulCard('🕊️', getText('FAITH', 'FOI', 'FE'), isMobile),
                  _buildSimplePlayfulCard('🏠', getText('FAMILY', 'FAMILLE', 'FAMILIA'), isMobile),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimplePlayfulCard(String icon, String label, bool isMobile) {
    return Container(
      width: isMobile ? 140 : 200,
      height: isMobile ? 180 : 240,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6), // Creamy
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF3C3530), width: 4),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF3C3530),
            offset: Offset(6, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 50)),
          const SizedBox(height: 20),
          Text(
            label,
            style: GoogleFonts.fredoka(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF3C3530),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyle(bool isMobile, String Function(String, String, String) getText) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/lifestyle.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black45,
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Bubbly Pattern
            Positioned(
              top: -50,
              right: -50,
              child: _buildAnimatedBlob(200, Colors.purpleAccent.withOpacity(0.3)),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStrokeText(
                  getText('FOR EVERYONE.', 'POUR TOUS.', 'PARA TODOS.'),
                  fontSize: isMobile ? 48 : 100,
                  color: Colors.white,
                  strokeColor: const Color(0xFF3C3530),
                  strokeWidth: 8,
                ),
                const SizedBox(height: 30),
                _buildStrokeText(
                  getText('PURE CONNECTION.', 'CONNEXION PURE.', 'CONEXIÓN PURA.'),
                  fontSize: isMobile ? 20 : 32,
                  color: const Color(0xFF3C3530),
                  strokeColor: Colors.white,
                  strokeWidth: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalCTA(bool isMobile, String Function(String, String, String) getText) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStrokeText(
            getText('READY?', 'PRÊT ?', '¿LISTO?'),
            fontSize: isMobile ? 70 : 160,
            color: const Color(0xFF3C3530),
            strokeColor: Colors.white,
            strokeWidth: 10,
            shadows: [
              const Shadow(color: Colors.black12, offset: Offset(10, 10)),
            ],
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () => widget.onNavigate('cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.black, width: 6),
              ),
              elevation: 0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(4, 4)),
                ],
              ),
              child: Text(
                getText('ORDER NOW', 'COMMANDER', 'ORDENAR'),
                style: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w900),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
        ],
      ),
    );
  }

  Widget _buildAnimatedBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .scale(duration: 4.seconds, curve: Curves.easeInOut, end: const Offset(1.2, 1.2))
     .move(duration: 8.seconds, curve: Curves.easeInOut, end: const Offset(30, 30));
  }

  Widget _buildStrokeText(String text, {
    required double fontSize,
    required Color color,
    required Color strokeColor,
    double strokeWidth = 5,
    List<Shadow>? shadows,
  }) {
    return Stack(
      children: [
        // Stroke
        Text(
          text,
          style: GoogleFonts.fredoka(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Solid text
        Text(
          text,
          style: GoogleFonts.fredoka(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: color,
            shadows: shadows,
          ),
        ),
      ],
    );
  }
}
