import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(const NanoGamesApp());
}

class NanoGamesApp extends StatefulWidget {
  const NanoGamesApp({super.key});

  @override
  State<NanoGamesApp> createState() => _NanoGamesAppState();
}

class _NanoGamesAppState extends State<NanoGamesApp> {
  String _currentPage = 'home';

  void _navigateTo(String page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MaterialApp(
        title: 'Nano Games',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFD4A574),
            primary: const Color(0xFFD4A574), // Oak/Gold
            secondary: const Color(0xFF8B5A2B), // Deep Wood
            surface: const Color(0xFF1A1A1A), // Dark Silk
            onSurface: const Color(0xFFF5E6D3), // Cream
            error: const Color(0xFFCF6679),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.interTextTheme(
            ThemeData.dark().textTheme,
          ).copyWith(
            displayLarge: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF5E6D3),
            ),
            displayMedium: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF5E6D3),
            ),
            headlineLarge: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF5E6D3),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4A574),
              foregroundColor: const Color(0xFF1A1A1A),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        home: _buildCurrentPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case 'about':
        return AboutPage(onNavigate: _navigateTo);
      case 'contact':
        return ContactPage(onNavigate: _navigateTo);
      case 'cart':
        return CartPage(onNavigate: _navigateTo);
      case 'checkout':
        return CheckoutPage(onNavigate: _navigateTo);
      default:
        return HomePage(onNavigate: _navigateTo);
    }
  }
}
