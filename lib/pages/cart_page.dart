import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../models/language.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CartPage extends StatefulWidget {
  final Function(String) onNavigate;

  const CartPage({super.key, required this.onNavigate});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Using global LanguageProvider

  @override
  Widget build(BuildContext context) {

    final languageProvider = Provider.of<LanguageProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
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
                
                // CART HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildPlayfulCard(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          _buildStrokeText(
                            getText('YOUR BASKET.', 'VOTRE PANIER.', 'TU CESTA.'),
                            fontSize: isMobile ? 40 : 80,
                            color: const Color(0xFF3C3530),
                            strokeColor: Colors.white,
                            strokeWidth: 6,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            getText('READY FOR ADVENTURE?', 'PRÊT POUR L\'AVENTURE ?', '¿LISTO PARA LA AVENTURA?'),
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

                // CART ITEMS
                if (cartProvider.items.isEmpty)
                  _buildEmptyState(isMobile, getText)
                else
                  ...cartProvider.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: _buildPlayfulCard(
                      child: _buildCartItemTile(item, isMobile, cartProvider, getText),
                    ),
                  )),

                const SizedBox(height: 30),

                // SUMMARY SECTION
                if (cartProvider.items.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildPlayfulCard(
                      child: _buildSummary(cartProvider, isMobile, getText),
                    ),
                  ),

                const SizedBox(height: 60),
                const AppFooter(currentPage: 'cart'),
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
              currentPage: 'cart',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isMobile, String Function(String, String, String) getText) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildPlayfulCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
          child: Column(
            children: [
              const Text('🛒', style: TextStyle(fontSize: 80)),
              const SizedBox(height: 20),
              Text(
                getText('YOUR BASKET IS EMPTY!', 'VOTRE PANIER EST VIDE !', '¡TU CESTA ESTÁ VACÍA!'),
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF3C3530),
                ),
              ),
              const SizedBox(height: 30),
              _buildLargeButton(
                text: getText('GO EXPLORE', 'EXPLORER', 'EXPLORAR'),
                onPressed: () => widget.onNavigate('home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItemTile(dynamic item, bool isMobile, CartProvider cartProvider, String Function(String, String, String) getText) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          // Item Image
          Container(
            width: isMobile ? 80 : 120,
            height: isMobile ? 80 : 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF3C3530).withOpacity(0.1), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(item.game.imageUrl, fit: BoxFit.cover, errorBuilder: (c,e,s) => const Center(child: Text('🎴', style: TextStyle(fontSize: 30)))),
            ),
          ),
          const SizedBox(width: 25),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.game.name.toUpperCase(),
                  style: GoogleFonts.fredoka(
                    fontSize: isMobile ? 18 : 24,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF3C3530),
                  ),
                ),
                Text(
                  '\$${item.game.price}',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3C3530).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          // Quantity & Remove
          if (!isMobile) ...[
            _buildQuantityController(item, cartProvider),
            const SizedBox(width: 30),
          ],
          IconButton(
            onPressed: () => cartProvider.removeFromCart(item.game.id),
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityController(dynamic item, CartProvider cartProvider) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3C3530).withOpacity(0.05),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF3C3530).withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQtyBtn(Icons.remove, () => cartProvider.updateQuantity(item.game.id, item.quantity - 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${item.quantity}',
              style: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w900, color: const Color(0xFF3C3530)),
            ),
          ),
          _buildQtyBtn(Icons.add, () => cartProvider.updateQuantity(item.game.id, item.quantity + 1)),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, size: 20, color: const Color(0xFF3C3530)),
      ),
    );
  }

  Widget _buildSummary(CartProvider cartProvider, bool isMobile, String Function(String, String, String) getText) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getText('TOTAL', 'TOTAL', 'TOTAL'),
                style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF3C3530)),
              ),
              Text(
                '\$${cartProvider.total.toStringAsFixed(2)}',
                style: GoogleFonts.fredoka(fontSize: 36, fontWeight: FontWeight.w900, color: const Color(0xFF3C3530)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildLargeButton(
            text: getText('COMPLETE PURCHASE', 'FINALISER L\'ACHAT', 'COMPLETAR COMPRA'),
            onPressed: () => widget.onNavigate('checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3C3530),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Color(0xFF3C3530), width: 3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
        elevation: 0,
      ),
      child: Text(
        text,
        style: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.bold),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
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
