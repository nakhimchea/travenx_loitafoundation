import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/l10n/locales.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(int languageIndex) {
    if (!Locales.languages.contains(Locales.languages.elementAt(languageIndex)))
      return;

    _locale = Locales.languages.elementAt(languageIndex);
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
