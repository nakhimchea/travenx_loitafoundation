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
          : {
              'KH': 'Cambodia',
            };
  return countryPairs[enCountryName] != null
      ? countryPairs[enCountryName].toString()
      : 'ប្រទេសកម្ពុជា';
}
