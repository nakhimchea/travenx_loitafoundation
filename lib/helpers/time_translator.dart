import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String timeTranslator(BuildContext context, DateTime dateTime) {
  if (AppLocalizations.of(context)!.localeName == 'km') {
    final String _hour = dateTime.hour > 12
        ? (dateTime.hour - 12).toString()
        : dateTime.hour == 0
            ? '12'
            : dateTime.hour.toString();
    String _translatedString = dateTime.minute == 0
        ? _hour
        : dateTime.minute < 10
            ? _hour + ':0' + dateTime.minute.toString() + ' នាទី'
            : _hour + ':' + dateTime.minute.toString() + ' នាទី';
    if (dateTime.hour >= 3 && dateTime.hour < 6)
      return _translatedString + ' ព្រលឹម';
    else if (dateTime.hour >= 6 && dateTime.hour < 12)
      return _translatedString + ' ព្រឹក';
    else if (dateTime.hour >= 12 && dateTime.hour < 16)
      return _translatedString + ' ថ្ងៃ';
    else if (dateTime.hour >= 16 && dateTime.hour < 19)
      return _translatedString + ' ល្ងាច';
    else
      return _translatedString + ' យប់';
  } else if (AppLocalizations.of(context)!.localeName == 'en') {
    final String _hour = dateTime.hour > 12
        ? (dateTime.hour - 12).toString()
        : dateTime.hour.toString();
    String _translatedString = dateTime.minute == 0
        ? _hour
        : dateTime.minute < 10
            ? _hour + ':0' + dateTime.minute.toString()
            : _hour + ':' + dateTime.minute.toString();
    if (dateTime.hour >= 0 && dateTime.hour < 12)
      return _translatedString + ' AM';
    else
      return _translatedString + ' PM';
  } else {
    return 'Unknown Time Translation.';
  }
}
