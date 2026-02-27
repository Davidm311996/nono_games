import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../models/language.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class AboutPage extends StatefulWidget {
  final Function(String) onNavigate;

  const AboutPage({super.key, required this.onNavigate});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Using global LanguageProvider

  // No local getText

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 768;

    String getText(String en, String fr, String es) => languageProvider.getText(en, fr, es);

    return Scaffold(
      backgroundColor: const Color(0xFFEDE9E3), // Warm Sand
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 140), // Clear NavBar
                
                // HEADER SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildPlayfulCard(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          _buildStrokeText(
                            getText('OUR STORY.', 'NOTRE HISTOIRE.', 'NUESTRA HISTORIA.'),
                            fontSize: isMobile ? 40 : 80,
                            color: const Color(0xFF3C3530),
                            strokeColor: Colors.white,
                            strokeWidth: 6,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getText('HOW NANO GAMES WAS BORN', 'COMMENT NANO GAMES EST NÉ', 'CÓMO NACIÓ NANO GAMES'),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.fredoka(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3C3530).withOpacity(0.5),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // STORY CONTENT SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildPlayfulCard(
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 30 : 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStoryHeading(getText('THE BEGINNING', 'LE DÉBUT', 'EL COMIENZO')),
                          _buildStoryBody(
                            getText(
                              'Nano Games started with a simple idea: bringing families and friends together through a game that not only entertains but also inspires. We saw a gap in the world of card games—something that combined deep strategy with faith-based values.',
                              'Nano Games est né d\'une idée simple : réunir les familles et les amis à travers un jeu qui non seulement divertit mais inspire aussi. Nous avons vu un manque dans le monde des jeux de cartes - quelque chose qui combinait une stratégie profonde avec des valeurs basées sur la foi.',
                              'Nano Games comenzó con una idea simple: unir a familias y amigos a través de un juego que no solo entretenga sino que también inspire. Vimos un vacío en el mundo de los juegos de cartas: algo que combinara una estrategia profunda con valores basados en la fe.',
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildStoryHeading(getText('THE VISION', 'LA VISION', 'LA VISIÓN')),
                          _buildStoryBody(
                            getText(
                              'Our vision was to create 120+ unique cards, each carrying a piece of biblical wisdom. We spent months refining the mechanics, ensuring that while the game is easy to learn, it offers infinite combinations for seasoned strategists. We wanted a game that builds connections, every time it lands on a table.',
                              'Notre vision était de créer plus de 120 cartes uniques, chacune portant une part de sagesse biblique. Nous avons passé des mois à affiner la mécanique, en veillant à ce que, bien que le jeu soit facile à apprendre, il offre des combinaisons infinies pour les stratèges chevronnés. Nous voulions un jeu qui crée des liens, chaque fois qu\'il atterrit sur une table.',
                              'Nuestra visión era crear más de 120 cartas únicas, cada una con un poco de sabiduría bíblica. Pasamos meses refinando la mecánica, asegurándonos de que, si bien el juego es fácil de aprender, ofrece infinitas combinaciones para estrategas experimentados. Queríamos un juego que construyera conexiones, cada vez que llega a una mesa.',
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildStoryHeading(getText('TODAY', 'AUJOURD\'HUI', 'HOY')),
                          _buildStoryBody(
                            getText(
                              'Today, Nano Games is more than just a deck of cards. It is a tool for communities to bond, for families to grow in faith, and for players to challenge their minds. We are humbled by the stories of connection we hear from around the world.',
                              'Aujourd\'hui, Nano Games est bien plus qu\'un simple jeu de cartes. C\'est un outil permettant aux communautés de se lier, aux familles de grandir dans la foi et aux joueurs de défier leur esprit. Nous sommes touchés par les histoires de connexion que nous entendons partout dans le monde.',
                              'Hoy, Nano Games es más que solo un mazo de cartas. Es una herramienta para que las comunidades se vinculen, para que las familias crezcan en su fe y para que los jugadores desafíen sus mentes. Nos sentimos honrados por las historias de conexión que escuchamos en todo el mundo.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                const AppFooter(currentPage: 'about'),
              ],
            ),
          ),

          // Floating NavBar
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: NavBar(
              currentLanguage: languageProvider.currentLanguage,
              onLanguageChanged: (lang) => languageProvider.setLanguage(lang),
              onNavigate: widget.onNavigate,
              currentPage: 'about',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        style: GoogleFonts.fredoka(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF3C3530),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildStoryBody(String text) {
    return Text(
      text,
      style: GoogleFonts.fredoka(
        fontSize: 18,
        height: 1.6,
        color: const Color(0xFF3C3530).withOpacity(0.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPlayfulCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          const BoxShadow(
            color: Color(0xFF3C3530),
            blurRadius: 0,
            offset: Offset(8, 8),
          ),
        ],
        border: Border.all(color: const Color(0xFF3C3530), width: 4),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _buildStrokeText(String text, {required double fontSize, required Color color, required Color strokeColor, required double strokeWidth, List<Shadow>? shadows}) {
    return Stack(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.fredoka(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
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
