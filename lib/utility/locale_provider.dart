import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan dependensi shared_preferences di pubspec.yaml

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  LocaleProvider() {
    _loadLocaleFromPreferences(); // Muat locale saat provider diinisialisasi
  }

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners(); // Beri tahu widget yang mendengarkan bahwa locale berubah
      await _saveLocaleToPreferences(newLocale); // Simpan locale ke SharedPreferences
    }
  }

  Future<void> _loadLocaleFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLocale = prefs.getString('app_locale');
    if (storedLocale != null) {
      _locale = Locale(storedLocale);
    } else {
      // Locale default jika belum ada di SharedPreferences (misalnya, Indonesia)
      _locale = const Locale('en');
    }
    notifyListeners(); // Beri tahu widget setelah locale dimuat dari SharedPreferences
  }

  Future<void> _saveLocaleToPreferences(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    print(locale.languageCode);
    await prefs.setString('app_locale', locale.languageCode);
  }
}
