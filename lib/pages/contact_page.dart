import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../models/language.dart';

class ContactPage extends StatefulWidget {
  final Function(String) onNavigate;

  const ContactPage({super.key, required this.onNavigate});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Language _currentLanguage = Language.english;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String getText(String en, String fr, String es) {
    switch (_currentLanguage) {
      case Language.english:
        return en;
      case Language.french:
        return fr;
      case Language.spanish:
        return es;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF2a1810),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(
              currentLanguage: _currentLanguage,
              onLanguageChanged: (lang) => setState(() => _currentLanguage = lang),
              onNavigate: widget.onNavigate,
              currentPage: 'contact',
            ),
            // Hero Section
            Container(
              padding: EdgeInsets.all(isMobile ? 20 : 40),
              color: const Color(0xFF1a1410),
              child: Column(
                children: [
                  Text(
                    getText('Get in Touch', 'Nous Contacter',
                        'Ponte en Contacto'),
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFd4a574),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    getText(
                        'We\'d love to hear from you. Send us a message!',
                        'Nous aimerions entendre parler de vous. Envoyez-nous un message!',
                        '¡Nos encantaría saber de ti! ¡Envíanos un mensaje!'),
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 18,
                      color: const Color(0xFFe8c4a0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Contact Form & Info
            Container(
              padding: EdgeInsets.all(isMobile ? 20 : 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Info
                  if (!isMobile)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildContactInfo(
                            '📧',
                            getText('Email', 'Email', 'Correo Electrónico'),
                            'support@nanogames.com',
                          ),
                          const SizedBox(height: 30),
                          _buildContactInfo(
                            '📍',
                            getText('Location', 'Localisation', 'Ubicación'),
                            getText(
                                'Worldwide Shipping',
                                'Expédition Mondiale',
                                'Envío Mundial'),
                          ),
                          const SizedBox(height: 30),
                          _buildContactInfo(
                            '⏰',
                            getText('Business Hours', 'Horaires',
                                'Horario Comercial'),
                            getText(
                                'Mon-Fri: 9AM-5PM EST',
                                'Lun-Ven: 9h-17h EST',
                                'Lun-Vie: 9AM-5PM EST'),
                          ),
                          const SizedBox(height: 30),
                          _buildContactInfo(
                            '📱',
                            getText('Social Media', 'Médias Sociaux',
                                'Redes Sociales'),
                            '@NanoGamesOfficial',
                          ),
                        ],
                      ),
                    ),
                  if (!isMobile) const SizedBox(width: 60),
                  // Contact Form
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildTextField(
                          _nameController,
                          getText('Your Name', 'Votre Nom', 'Tu Nombre'),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          _emailController,
                          getText('Your Email', 'Votre Email', 'Tu Email'),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          _messageController,
                          getText('Message', 'Message', 'Mensaje'),
                          maxLines: 6,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    getText('Message sent! We\'ll reply soon.',
                                        'Message envoyé! Nous vous répondrons bientôt.',
                                        '¡Mensaje enviado! Pronto responderemos.'),
                                  ),
                                  backgroundColor:
                                      const Color(0xFFc19a6b),
                                ),
                              );
                              _nameController.clear();
                              _emailController.clear();
                              _messageController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFc19a6b),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              getText('Send Message', 'Envoyer le Message',
                                  'Enviar Mensaje'),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1a1410),
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // FAQ Section
            Container(
              padding: EdgeInsets.all(isMobile ? 20 : 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getText('Frequently Asked Questions', 'Questions Fréquemment Posées',
                        'Preguntas Frecuentes'),
                    style: TextStyle(
                      fontSize: isMobile ? 22 : 28,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFd4a574),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildFAQ(
                    getText('What is shipping time?',
                        'Quel est le délai d\'expédition?',
                        '¿Cuál es el tiempo de envío?'),
                    getText('Standard shipping is 5-7 business days.',
                        'L\'expédition standard est de 5 à 7 jours ouvrables.',
                        'El envío estándar es de 5 a 7 días hábiles.'),
                  ),
                  const SizedBox(height: 15),
                  _buildFAQ(
                    getText('Do you offer returns?',
                        'Proposez-vous des retours?',
                        '¿Ofrecen devoluciones?'),
                    getText('Yes, 30-day money-back guarantee.',
                        'Oui, garantie de remboursement de 30 jours.',
                        'Sí, garantía de devolución de dinero de 30 días.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AppFooter(currentPage: 'contact'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String icon, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFFd4a574),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFFe8c4a0),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFFe8c4a0)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFc19a6b)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFc19a6b)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFc19a6b), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFd4a574), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF1a1410),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFc19a6b), width: 1),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1a1410),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFFd4a574),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFe8c4a0),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
