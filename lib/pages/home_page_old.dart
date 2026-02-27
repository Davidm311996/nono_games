import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _titleController;
  late AnimationController _cardRotationController;
  late AnimationController _pulseController;
  late AnimationController _glitchController;
  late List<AnimationController> _floatingCardControllers;
  late ScrollController _scrollController;

  double _scrollOffset = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _titleController.forward();

    _cardRotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat();

    _floatingCardControllers = List.generate(
      8,
      (index) => AnimationController(
        duration: Duration(seconds: 5 + _random.nextInt(4)),
        vsync: this,
      )..repeat(reverse: _random.nextBool()),
    );

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _titleController.dispose();
    _cardRotationController.dispose();
    _pulseController.dispose();
    _glitchController.dispose();
    for (var controller in _floatingCardControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1a1410),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // DYNAMIC HERO SECTION
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1a1410),
                    Color.lerp(
                      const Color(0xFF3d5a4a),
                      const Color(0xFF5a3e2b),
                      (_scrollOffset / 500).clamp(0.0, 1.0),
                    )!,
                    const Color(0xFF1a1410),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Animated particles & light effects
                  _buildDynamicParticleBackground(),

                  // Morphing shape overlays
                  _buildMorphingShapes(),

                  // Moving card elements
                  _buildAnimatedCardElements(gameProvider),

                  // Main content with animations
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnimatedTitle(),
                          const SizedBox(height: 60),
                          _buildDynamicButtons(),
                          const SizedBox(height: 40),
                          _buildGlitchText(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INTERACTIVE STATS SECTION - with curved top
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1410),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: [
                  _buildSectionLabel('DECK COMPOSITION'),
                  const SizedBox(height: 50),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int cols = constraints.maxWidth > 900 ? 4 : 2;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: cols,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.95,
                        children: gameProvider.game.features
                            .asMap()
                            .entries
                            .map((entry) => _AnimatedSpecCard(
                                  spec: entry.value,
                                  index: entry.key,
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),

            // DYNAMIC FEATURES CAROUSEL - organic curves
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF2a2218),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: [
                  _buildSectionLabel('GAME MECHANICS'),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 400,
                    child: _buildFeatureCarousel(),
                  ),
                ],
              ),
            ),

            // INTERACTIVE CTA SECTION - organic curves
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF3d5a4a),
                    const Color(0xFF5a3e2b),
                    const Color(0xFF1a1410),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
              child: Center(
                child: _buildPremiumCTA(),
              ),
            ),

            // Footer with particles - curved top
            Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: const Color(0xFF0f0c0a),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(120),
                  topRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '🎴 NANO GAMES 🎴',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFd4a574),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Blessed with purpose. Built for faith.',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '© 2026 • All cards reserved',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 11,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _titleController, curve: Curves.elasticOut),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(_titleController),
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
              .animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut)),
          child: Column(
            children: [
              // Animated emoji with rotation
              AnimatedBuilder(
                animation: _cardRotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _cardRotationController.value * 2 * pi,
                    child: Text(
                      '🎴',
                      style: const TextStyle(fontSize: 80),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Card-styled title
              _buildCardStyledTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardStyledTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color(0xFFd4a574),
          const Color(0xFFc19a6b),
          const Color(0xFFd4a574),
        ],
      ).createShader(bounds),
      child: Text(
        'NANO GAMES',
        style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 3,
        ),
      ),
    );
  }

  Widget _buildGlitchText() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.5 + (_pulseController.value * 0.5),
          child: Text(
            '✨ FAITH THROUGH PLAY ✨',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFFe8c4a0),
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              shadows: [
                BoxShadow(
                  color: const Color(0xFFd4a574).withOpacity(_pulseController.value),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDynamicButtons() {
    return Wrap(
      spacing: 25,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _DynamicCTAButton(
          label: '⛪ VIEW FAITH CARDS',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const CardGalleryModal(),
            );
          },
        ),
        _DynamicCTAButton(
          label: '✝️ GET YOUR COPY',
          isPrimary: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const BuyGameDialog(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDynamicParticleBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            animationValue: _particleController.value,
            scrollOffset: _scrollOffset,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildMorphingShapes() {
    return AnimatedBuilder(
      animation: _cardRotationController,
      builder: (context, child) {
        return Stack(
          children: [
            // Morphing circle 1
            Positioned(
              left: -100 + (sin(_cardRotationController.value * 2 * pi) * 150),
              top: 50 + (cos(_cardRotationController.value * 2 * pi) * 100),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6b8e73).withOpacity(0.15),
                      const Color(0xFF6b8e73).withOpacity(0.02),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6b8e73).withOpacity(0.1),
                      blurRadius: 50,
                    ),
                  ],
                ),
              ),
            ),
            // Morphing circle 2
            Positioned(
              right: -80 + (cos(_cardRotationController.value * 2 * pi) * 120),
              bottom: 100 + (sin(_cardRotationController.value * 2 * pi) * 80),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF8b6f47).withOpacity(0.1),
                      const Color(0xFF8b6f47).withOpacity(0.02),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8b6f47).withOpacity(0.1),
                      blurRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedCardElements(GameProvider gameProvider) {
    return Stack(
      children: List.generate(8, (index) {
        return Positioned(
          left: (MediaQuery.of(context).size.width / 8 * index) - 30,
          top: 100 + (index % 3) * 150,
          child: AnimatedBuilder(
            animation: _floatingCardControllers[index],
            builder: (context, child) {
              final floatAmount = sin(_floatingCardControllers[index].value * 2 * pi) * 30;
              final rotAmount = _floatingCardControllers[index].value * 2 * pi * (index % 2 == 0 ? 1 : -1);

              return Transform.translate(
                offset: Offset(0, floatAmount),
                child: Transform.rotate(
                  angle: rotAmount * 0.1,
                  child: child,
                ),
              );
            },
            child: Opacity(
              opacity: 0.4,
              child: Container(
                width: 70,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFc19a6b),
                    width: 1.5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF966633).withOpacity(0.3),
                      const Color(0xFF966633).withOpacity(0.1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc19a6b).withOpacity(0.2),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '🎴',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFc19a6b),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFFd4a574),
          fontWeight: FontWeight.w900,
          letterSpacing: 2.5,
        ),
      ),
    );
  }

  Widget _buildFeatureCarousel() {
    return PageView(
      children: [
        _buildFeatureSlide(
          title: '120+ FAITH CARDS',
          icon: '✝️',
          description: 'Beautifully crafted cards featuring Christian virtues, biblical wisdom, and spiritual values',
          color1: Colors.amber,
          color2: Colors.orange,
        ),
        _buildFeatureSlide(
          title: 'MEANINGFUL GAMEPLAY',
          icon: '🙏',
          description: 'Engage through strategic play that celebrates faith, morality, and spiritual growth',
          color1: Colors.purple,
          color2: Colors.indigo,
        ),
        _buildFeatureSlide(
          title: 'BRING FAITH TOGETHER',
          icon: '❤️',
          description: 'Perfect for churches, Christian groups, and faith-based communities seeking connection',
          color1: Colors.cyan,
          color2: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildFeatureSlide({
    required String title,
    required String icon,
    required String description,
    required Color color1,
    required Color color2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color1.withOpacity(0.2),
              color2.withOpacity(0.1),
            ],
          ),
          border: Border.all(
            color: const Color(0xFF6b8e73).withOpacity(0.7),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6b8e73).withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade300,
                  height: 1.6,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCTA() {
    return Container(
      width: min(600, MediaQuery.of(context).size.width * 0.9),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          color: const Color(0xFFc19a6b),
          width: 3,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2a2218),
            const Color(0xFF1f1a15),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFc19a6b).withOpacity(0.3),
            blurRadius: 50,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: const Color(0xFFc19a6b).withOpacity(0.15),
            blurRadius: 100,
            spreadRadius: 30,
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return ScaleTransition(
                scale: Tween<double>(begin: 1.0, end: 1.1)
                    .animate(_pulseController),
                child: Text(
                  '⛪',
                  style: TextStyle(
                    fontSize: 60,
                    shadows: [
                      BoxShadow(
                        color: const Color(0xFFc19a6b).withOpacity(_pulseController.value),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 25),
          const Text(
            'Ready for Victory?',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Join elite players worldwide in the ultimate strategic card game experience',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFFe8c4a0),
              height: 1.6,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 50),
          _DynamicCTAButton(
            label: '⚡ CLAIM YOUR DECK ⚡',
            isPrimary: true,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const BuyGameDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DynamicCTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _DynamicCTAButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  State<_DynamicCTAButton> createState() => _DynamicCTAButtonState();
}

class _DynamicCTAButtonState extends State<_DynamicCTAButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.12)
                  .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: widget.isPrimary
                        ? Colors.amber.shade700
                        : Colors.amber.shade600,
                    width: 2.5,
                  ),
                  color: widget.isPrimary
                      ? const Color(0xFFc19a6b)
                      : Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc19a6b).withOpacity(0.4 * _controller.value),
                      blurRadius: 20 + (10 * _controller.value),
                      spreadRadius: 3 + (3 * _controller.value),
                    ),
                  ],
                  gradient: widget.isPrimary
                      ? LinearGradient(
                          colors: [
                            const Color(0xFFc19a6b),
                            const Color(0xFFb8956a),
                          ],
                        )
                      : null,
                ),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: widget.isPrimary
                        ? const Color(0xFF1a1410)
                        : const Color(0xFFd4a574),
                    letterSpacing: 1.8,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedSpecCard extends StatefulWidget {
  final String spec;
  final int index;

  const _AnimatedSpecCard({
    required this.spec,
    required this.index,
  });

  @override
  State<_AnimatedSpecCard> createState() => _AnimatedSpecCardState();
}

class _AnimatedSpecCardState extends State<_AnimatedSpecCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFc19a6b).withOpacity(0.6),
            width: 2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2a2218),
              const Color(0xFF1a1510),
            ],
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFc19a6b).withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFc19a6b),
                  width: 2.5,
                ),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFc19a6b).withOpacity(0.2),
                    const Color(0xFFc19a6b).withOpacity(0.05),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFc19a6b).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFc19a6b),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.spec,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 15,
                height: 1.4,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardGalleryModal extends StatefulWidget {
  const CardGalleryModal({super.key});

  @override
  State<CardGalleryModal> createState() => _CardGalleryModalState();
}

class _CardGalleryModalState extends State<CardGalleryModal> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _scaleController;
  int _currentCard = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: const Color(0xFF1a1410),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(60)),
          border: Border(
            top: BorderSide(color: const Color(0xFFc19a6b), width: 3),
          ),
          boxShadow: [
            BoxShadow(color: const Color(0xFFc19a6b).withOpacity(0.2), blurRadius: 40),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              '🎪 EXPLORE ALL 120 CARDS 🎪',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentCard = index);
                  gameProvider.goToCard(index);
                },
                itemCount: 120,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFc19a6b), width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFc19a6b).withOpacity(0.4),
                            blurRadius: 35,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          gameProvider.getCardImagePath(index),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF2a2a2a),
                              child: Center(
                                child: Text(
                                  'Card ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFc19a6b), width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '🎯 Card ${_currentCard + 1} of 120 🎯',
                style: const TextStyle(
                  color: Color(0xFFd4a574),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class BuyGameDialog extends StatefulWidget {
  const BuyGameDialog({super.key});

  @override
  State<BuyGameDialog> createState() => _BuyGameDialogState();
}

class _BuyGameDialogState extends State<BuyGameDialog> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleController.forward();

    _buttonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return ScaleTransition(
      scale: Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
      ),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: min(550, MediaQuery.of(context).size.width * 0.92),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: const Color(0xFFc19a6b), width: 3),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF2a2218), const Color(0xFF1f1a15)],
            ),
            boxShadow: [
              BoxShadow(color: const Color(0xFFc19a6b).withOpacity(0.4), blurRadius: 50, spreadRadius: 15),
              BoxShadow(color: const Color(0xFFc19a6b).withOpacity(0.2), blurRadius: 100, spreadRadius: 30),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🎴 NANO GAMES 🎴',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.amber.shade700, width: 1.5),
                    color: Colors.amber.withOpacity(0.08),
                  ),
                  child: Text(
                    gameProvider.game.longDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amber.shade200,
                      fontSize: 15,
                      height: 1.8,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '💰 PRICE',
                          style: const TextStyle(
                            color: Color(0xFFd4a574),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$${gameProvider.game.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFc19a6b),
                            shadows: [
                              BoxShadow(color: Color(0xFFc19a6b), blurRadius: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '⭐ RATING',
                          style: const TextStyle(
                            color: Color(0xFFd4a574),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFc19a6b), size: 32),
                            const SizedBox(width: 5),
                            Text(
                              '${gameProvider.game.rating}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFc19a6b),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                AnimatedBuilder(
                  animation: _buttonController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_buttonController.value * 0.05),
                      child: child,
                    );
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '✨ ${gameProvider.game.name} acquired! ✨',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          backgroundColor: Colors.amber.shade700,
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFc19a6b),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      elevation: 20,
                      shadowColor: const Color(0xFFc19a6b).withOpacity(0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      '🛒 UNLOCK DECK 🛒',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1a1410),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFc19a6b), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  ),
                  child: Text(
                    'BROWSE CARDS',
                    style: const TextStyle(
                      color: Color(0xFFd4a574),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.8,
                      fontSize: 14,
                    ),
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

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final double scrollOffset;

  ParticlePainter({required this.animationValue, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw moving particles with earthy tones
    for (int i = 0; i < 40; i++) {
      final seed = (i * 12345).toDouble();
      final x = (seed + animationValue * 100) % size.width;
      final y = ((seed * 7 + scrollOffset) % size.height);
      final opacity = (sin(animationValue * 2 * pi + i) + 1) / 2 * 0.3;

      final paint = Paint()
        ..color = const Color(0xFFc19a6b).withOpacity(opacity * 0.5)
        ..strokeWidth = 1;

      canvas.drawCircle(Offset(x, y), 1.5, paint);
    }

    // Draw flowing lines with earthy gradient
    for (int i = 0; i < 8; i++) {
      final offset = (i * 50 + animationValue * 200) % size.width;
      final paint = Paint()
        ..color = const Color(0xFF6b8e73).withOpacity(0.1)
        ..strokeWidth = 2;

      canvas.drawLine(Offset(offset, 0), Offset(offset - 100, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
