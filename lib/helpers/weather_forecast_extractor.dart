import 'dart:convert' show jsonDecode;

import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/helpers/time_translator.dart';
import 'package:travenx_loitafoundation/models/weather_forecast_model.dart';

ModelWeatherForecast weatherForecastExtractor(BuildContext context,
    {required String data}) {
  List<String> _forecast = [];
  String _sunrise = '';
  String _sunset = '';
  int _temperature = 30;

  try {
    if (jsonDecode(data)['cod'] == '200') {
      List<String> _knowledge = [];
      for (var snapshot in jsonDecode(data)['list']) {
        DateTime _timeframe = DateTime.fromMillisecondsSinceEpoch(
            int.parse(snapshot['dt'].toString()) * 1000);
        if (double.parse(snapshot['pop'].toString()) >= 0.67 &&
            _timeframe.hour >= 6) {
          _knowledge.add(snapshot['dt'].toString() +
              '/' +
              snapshot['weather'][0]['description'].toString());
        }
      }

      if (_knowledge.isNotEmpty) {
        DateTime _previous = DateTime.fromMillisecondsSinceEpoch(
            int.parse(_knowledge.first.split('/').first) * 1000);
        _forecast.add(_dateTranslator(
                context,
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(_knowledge.first.split('/').first) * 1000)) +
            '/' +
            _conditionTranslator(context, _knowledge.first.split('/').last) +
            '/' +
            timeTranslator(
                context,
                DateTime.fromMillisecondsSinceEpoch(
                    int.parse(_knowledge.first.split('/').first) * 1000)));
        for (int index = 1; index < _knowledge.length; index++) {
          final _timeframe = DateTime.fromMillisecondsSinceEpoch(
              int.parse(_knowledge.elementAt(index).split('/').first) * 1000);
          if (_timeframe.day > _previous.day) {
            _previous = _timeframe;
            _forecast.add(_dateTranslator(
                    context,
                    DateTime.fromMillisecondsSinceEpoch(int.parse(
                            _knowledge.elementAt(index).split('/').first) *
                        1000)) +
                '/' +
                _conditionTranslator(
                    context, _knowledge.elementAt(index).split('/').last) +
                '/' +
                timeTranslator(
                    context,
                    DateTime.fromMillisecondsSinceEpoch(int.parse(
                            _knowledge.elementAt(index).split('/').first) *
                        1000)));
          }
        }
      }

      final DateTime _rise = DateTime.fromMillisecondsSinceEpoch(
          int.parse(jsonDecode(data)['city']['sunrise'].toString()) * 1000);
      final DateTime _set = DateTime.fromMillisecondsSinceEpoch(
          int.parse(jsonDecode(data)['city']['sunset'].toString()) * 1000);

      _sunrise = timeTranslator(context, _rise);
      _sunset = timeTranslator(context, _set);
      _temperature = (double.parse(
              jsonDecode(data)['list'][0]['main']['feels_like'].toString()))
          .toInt();
    }
  } catch (_) {
    print('Cannot get weather data.');
  }

  return ModelWeatherForecast(
      forecast: _forecast,
      sunrise: _sunrise,
      sunset: _sunset,
      temperature: _temperature);
}

String _conditionTranslator(BuildContext context, String enCondition) {
  if (AppLocalizations.of(context)!.localeName == 'km')
    switch (enCondition) {
      case 'light rain':
        return 'ភ្លៀងធ្លាក់តិចតួច';
      case 'overcast clouds':
        return 'ភ្លៀងធ្លាក់តិចតួច';
      case 'moderate rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'thunderstorm with heavy drizzle':
        return 'រលឹមខ្លាំង';
      case 'shower drizzle':
        return 'រលឹមខ្លាំង';
      case 'heavy intensity drizzle':
        return 'រលឹមខ្លាំង';
      case 'thunderstorm with heavy rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'shower rain and drizzle':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'heavy shower rain and drizzle':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'heavy intensity rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'very heavy rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'extreme rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'freezing rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'light intensity shower rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'shower rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'heavy intensity shower rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      case 'ragged shower rain':
        return 'ភ្លៀងធ្លាក់ខ្លាំង';
      default:
        return 'ភ្លៀងធ្លាក់តិចតួច';
    }
  else if (AppLocalizations.of(context)!.localeName == 'en')
    switch (enCondition) {
      case 'light rain':
        return 'light rain';
      case 'overcast clouds':
        return 'light rain';
      case 'moderate rain':
        return 'moderate rain';
      case 'thunderstorm with heavy drizzle':
        return 'heavy drizzle';
      case 'shower drizzle':
        return 'shower drizzle';
      case 'heavy intensity drizzle':
        return 'heavy drizzle';
      case 'thunderstorm with heavy rain':
        return 'heavy rain';
      case 'shower rain and drizzle':
        return 'shower rain';
      case 'heavy shower rain and drizzle':
        return 'shower rain';
      case 'heavy intensity rain':
        return 'heavy rain';
      case 'very heavy rain':
        return 'heavy rain';
      case 'extreme rain':
        return 'heavy rain';
      case 'freezing rain':
        return 'freezing rain';
      case 'light intensity shower rain':
        return 'shower rain';
      case 'shower rain':
        return 'shower rain';
      case 'heavy intensity shower rain':
        return 'shower rain';
      case 'ragged shower rain':
        return 'shower rain';
      default:
        return 'light rain';
    }
  else
    return 'light rain';
}

String _dateTranslator(BuildContext context, DateTime dateTime) {
  final int today = DateTime.now().day;
  if (AppLocalizations.of(context)!.localeName == 'km') {
    if (dateTime.day - today == 0)
      return 'ថ្ងៃនេះ';
    else if (dateTime.day - today == 1)
      return 'ថ្ងៃស្អែក';
    else if (dateTime.day - today == 2)
      return 'ថ្ងៃខានស្អែក';
    else
      return 'ថ្ងៃទី${dateTime.day}';
  } else if (AppLocalizations.of(context)!.localeName == 'en') {
    if (dateTime.day - today == 0)
      return 'today';
    else if (dateTime.day - today == 1)
      return 'tomorrow';
    else if (dateTime.day - today == 2)
      return 'day after tomorrow';
    else
      return 'on ${_toOrdinal(dateTime.day)}';
  } else
    return dateTime.toIso8601String();
}

String _toOrdinal(int number) {
  var _ending = number % 10;
  if (_ending == 1)
    return number.toString() + 'st';
  else if (_ending == 2)
    return number.toString() + 'nd';
  else if (_ending == 3)
    return number.toString() + 'rd';
  else
    return number.toString() + 'th';
}
