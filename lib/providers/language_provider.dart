import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language.dart';

class LanguageProvider extends ChangeNotifier {
  Language _currentLanguage = Language.english;
  static const String _langKey = 'selected_language';

  LanguageProvider() {
    _loadLanguage();
  }

  Language get currentLanguage => _currentLanguage;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langIndex = prefs.getInt(_langKey);
    if (langIndex != null) {
      _currentLanguage = Language.values[langIndex];
      notifyListeners();
    }
  }

  Future<void> setLanguage(Language language) async {
    if (_currentLanguage == language) return;
    _currentLanguage = language;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_langKey, language.index);
  }

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
}
