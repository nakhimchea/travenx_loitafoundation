import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String countryNameTranslator(
  BuildContext context, {
  required String enCountryName,
}) {
  final Map<String, String> countryPairs =
      AppLocalizations.of(context)!.localeName == 'km'
          ? {
              'KH': 'ប្រទេសកម្ពុជា',
            }
          : AppLocalizations.of(context)!.localeName == 'en'
              ? {
                  'KH': 'Cambodia',
                }
              : {
                  'KH': 'KH',
                };
  return countryPairs[enCountryName] != null
      ? countryPairs[enCountryName].toString()
      : 'ប្រទេសកម្ពុជា';
}
