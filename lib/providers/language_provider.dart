import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const _key = 'app_language';

  Locale _locale = const Locale('fr');
  Locale _tempLocale = const Locale('fr');

  Locale get locale => _locale;
  Locale get tempLocale => _tempLocale;

  // 🔹 AU DÉMARRAGE
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'fr';

    _locale = Locale(code);
    _tempLocale = Locale(code);
    notifyListeners();
  }

  // 🔹 SÉLECTION TEMPORAIRE
  void selectTemp(String code) {
    _tempLocale = Locale(code);
    notifyListeners();
  }

  // 🔹 VALIDER LE CHANGEMENT
  Future<void> confirmLanguage() async {
    _locale = _tempLocale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _locale.languageCode);

    notifyListeners();
  }

  bool isSelected(String code) {
    return _tempLocale.languageCode == code;
  }
}
