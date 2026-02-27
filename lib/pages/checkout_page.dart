import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class CheckoutPage extends StatefulWidget {
  final Function(String) onNavigate;

  const CheckoutPage({super.key, required this.onNavigate});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    setState(() => _currentStep--);
  }

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
                
                // STEP INDICATOR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildStepIndicator(getText, isMobile),
                ),

                const SizedBox(height: 30),

                // FORM SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: _buildPlayfulCard(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 30 : 60),
                        child: _buildCurrentStepView(getText, cartProvider, isMobile),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                const AppFooter(currentPage: 'checkout'),
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
              currentPage: 'checkout',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(String Function(String, String, String) getText, bool isMobile) {
    final steps = [
      getText('Shipping', 'Livraison', 'Envío'),
      getText('Payment', 'Paiement', 'Pago'),
      getText('Review', 'Révision', 'Revisión'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final label = entry.value;
        final isActive = _currentStep >= index;
        
        return Row(
          children: [
            _buildStepCircle(index + 1, isActive, isMobile),
            if (!isMobile) ...[
              const SizedBox(width: 10),
              Text(
                label.toUpperCase(),
                style: GoogleFonts.fredoka(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: isActive ? const Color(0xFF3C3530) : const Color(0xFF3C3530).withOpacity(0.3),
                  letterSpacing: 1.5,
                ),
              ),
            ],
            if (index < steps.length - 1)
              Container(
                width: isMobile ? 30 : 60,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF3C3530) : const Color(0xFF3C3530).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStepCircle(int step, bool isActive, bool isMobile) {
    return Container(
      width: isMobile ? 36 : 48,
      height: isMobile ? 36 : 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3C3530) : const Color(0xFFFAF9F6),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF3C3530), width: 3),
        boxShadow: isActive ? [] : [
          const BoxShadow(color: Color(0xFF3C3530), offset: Offset(3, 3)),
        ],
      ),
      child: Text(
        '$step',
        style: GoogleFonts.fredoka(
          color: isActive ? Colors.white : const Color(0xFF3C3530),
          fontSize: isMobile ? 16 : 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    ).animate(target: isActive ? 1 : 0).scale(duration: 400.ms, curve: Curves.elasticOut);
  }

  Widget _buildCurrentStepView(String Function(String, String, String) getText, CartProvider cart, bool isMobile) {
    switch (_currentStep) {
      case 0:
        return _buildShippingForm(getText, isMobile);
      case 1:
        return _buildPaymentForm(getText, isMobile);
      case 2:
        return _buildOrderReview(getText, cart, isMobile);
      default:
        return Container();
    }
  }

  Widget _buildShippingForm(String Function(String, String, String) getText, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(getText('SHIPPING DETAILS', 'DÉTAILS DE LIVRAISON', 'DETALLES DE ENVÍO')),
        const SizedBox(height: 30),
        _buildInputField(getText('Full Name', 'Nom complet', 'Nombre completo'), _nameController),
        const SizedBox(height: 20),
        _buildInputField(getText('Email Address', 'Adresse e-mail', 'Correo electrónico'), _emailController),
        const SizedBox(height: 20),
        _buildInputField(getText('Shipping Address', 'Adresse de livraison', 'Dirección de envío'), _addressController),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildInputField(getText('City', 'Ville', 'Ciudad'), _cityController)),
            const SizedBox(width: 20),
            Expanded(child: _buildInputField(getText('Zip Code', 'Code postal', 'Código postal'), _zipController)),
          ],
        ),
        const SizedBox(height: 40),
        _buildActionButtons(getText, isLast: false),
      ],
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildPaymentForm(String Function(String, String, String) getText, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(getText('PAYMENT METHOD', 'MODE DE PAIEMENT', 'MÉTODO DE PAGO')),
        const SizedBox(height: 30),
        _buildInputField(getText('Card Number', 'Numéro de carte', 'Número de tarjeta'), _cardNumberController, icon: Icons.credit_card),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildInputField(getText('Expiry (MM/YY)', 'Expiration', 'Vencimiento'), _expiryController)),
            const SizedBox(width: 20),
            Expanded(child: _buildInputField(getText('CVV', 'CVV', 'CVV'), _cvvController)),
          ],
        ),
        const SizedBox(height: 40),
        _buildActionButtons(getText, isLast: false, showBack: true),
      ],
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildOrderReview(String Function(String, String, String) getText, CartProvider cart, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(getText('ORDER SUMMARY', 'RÉSUMÉ DE LA COMMANDE', 'RESUMEN DEL PEDIDO')),
        const SizedBox(height: 30),
        ...cart.items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.quantity}x ${item.game.name}',
                style: GoogleFonts.fredoka(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('\$${item.total.toStringAsFixed(2)}', style: GoogleFonts.fredoka(fontWeight: FontWeight.w900)),
            ],
          ),
        )),
        const Divider(height: 40, thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getText('TOTAL', 'TOTAL', 'TOTAL'), style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w900)),
            Text('\$${cart.total.toStringAsFixed(2)}', style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF3C3530))),
          ],
        ),
        const SizedBox(height: 40),
        _buildActionButtons(getText, isLast: true, showBack: true, onComplete: () {
          // Success Feedback
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(getText('ORDER PLACED!', 'COMMANDE PASSÉE !', '¡PEDIDO REALIZADO!'))),
          );
          cart.clear();
          widget.onNavigate('home');
        }),
      ],
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.fredoka(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: const Color(0xFF3C3530),
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.fredoka(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF3C3530).withOpacity(0.6),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
          style: GoogleFonts.fredoka(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF3C3530)) : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Color(0xFF3C3530), width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Color(0xFF3C3530), width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Color(0xFF3C3530), width: 4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(String Function(String, String, String) getText, {required bool isLast, bool showBack = false, VoidCallback? onComplete}) {
    return Row(
      children: [
        if (showBack) ...[
          _buildBouncyButton(
            text: getText('BACK', 'RETOUR', 'ATRÁS'),
            onPressed: _prevStep,
            isSecondary: true,
          ),
          const SizedBox(width: 20),
        ],
        Expanded(
          child: _buildBouncyButton(
            text: isLast ? getText('PLACE ORDER', 'COMMANDER', 'PEDIR') : getText('CONTINUE', 'CONTINUER', 'CONTINUAR'),
            onPressed: isLast ? onComplete! : _nextStep,
          ),
        ),
      ],
    );
  }

  Widget _buildBouncyButton({required String text, required VoidCallback onPressed, bool isSecondary = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? Colors.white : const Color(0xFF3C3530),
        foregroundColor: isSecondary ? const Color(0xFF3C3530) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Color(0xFF3C3530), width: 3),
        ),
        padding: const EdgeInsets.symmetric(vertical: 22),
        elevation: 0,
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.fredoka(fontWeight: FontWeight.w900, fontSize: 16),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02), duration: 1.seconds);
  }

  Widget _buildPlayfulCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          const BoxShadow(
            color: Color(0xFF3C3530),
            blurRadius: 0,
            offset: Offset(8, 8),
          ),
        ],
        border: Border.all(color: const Color(0xFF3C3530), width: 4),
      ),
      child: child,
    );
  }
}
