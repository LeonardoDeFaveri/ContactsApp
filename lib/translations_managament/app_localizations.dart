import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale locale;
  // Utilizza questa lingua se per quella selezionata non ci sono traduzioni
  final Locale fallbackLocale = Locale('en');
  static AppLocalizations instance;

  AppLocalizations._init(Locale locale) {
    instance = this;
    this.locale = locale;
  }
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Stringhe nella lingua scelta
  Map<String, String> _localizedStrings;
  // Stringhe nella lingua di riserva
  Map<String, String> _fallbackLocalizedStrings;

  /// Carica le traduzioni.
  Future<void> load() async {
    _localizedStrings = await _loadLocalizedStrings(locale);
    _fallbackLocalizedStrings = {};

    // Se la lingua scelta è diversa da quella di riserva, carica le stringhe
    // di riserva
    if (locale != fallbackLocale) {
      _fallbackLocalizedStrings = await _loadLocalizedStrings(fallbackLocale);
    }
  }

  /// Carica le stringhe della traduzione in una determinata lingua [localeToBeLoaded].
  ///
  /// Restitusce una collezione contente tutte le stringhe tradotte. Le traduzioni
  /// sono accessibili tramite la loro chiave.
  Future<Map<String, String>> _loadLocalizedStrings(
      Locale localeToBeLoaded) async {
    String jsonString;
    Map<String, String> localizedStrings = {};

    try {
      jsonString = await rootBundle.loadString(
          'assets/translations/${localeToBeLoaded.languageCode}.json');
    } catch (exception) {
      print(exception);
      return localizedStrings;
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return localizedStrings;
  }

  /// Estrae la traduzione per la stringa identificata dalla chiave [key].
  ///
  /// Se presenti parametri [arguments] sostituisce per ogni segnaposto il
  /// valore associato.
  String translate(String key, [Map<String, String> arguments]) {
    String translation = _localizedStrings[key];
    translation = translation ?? _fallbackLocalizedStrings[key];
    translation = translation ?? "";

    if (arguments == null || arguments.length == 0) {
      return translation;
    }

    arguments.forEach((argumentKey, value) {
      if (value == null) {
        print(
            'Value for "$argumentKey" is null in call of translate(\'$key\')');
        value = '';
      }
      translation = translation.replaceAll("\$$argumentKey", value);
    });

    return translation;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations._init(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
