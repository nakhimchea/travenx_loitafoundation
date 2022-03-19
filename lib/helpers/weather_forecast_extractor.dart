import 'dart:convert';

import 'package:travenx_loitafoundation/models/weather_forecast_model.dart';

ModelWeatherForecast weatherForecastExtractor({required String data}) {
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
        _forecast.add(_dateTranslator(DateTime.fromMillisecondsSinceEpoch(
                int.parse(_knowledge.first.split('/').first) * 1000)) +
            '/' +
            _conditionTranslator(_knowledge.first.split('/').last) +
            '/' +
            _timeTranslator(DateTime.fromMillisecondsSinceEpoch(
                int.parse(_knowledge.first.split('/').first) * 1000)));
        for (int index = 1; index < _knowledge.length; index++) {
          final _timeframe = DateTime.fromMillisecondsSinceEpoch(
              int.parse(_knowledge.elementAt(index).split('/').first) * 1000);
          if (_timeframe.day > _previous.day) {
            _previous = _timeframe;
            _forecast.add(_dateTranslator(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(_knowledge.elementAt(index).split('/').first) *
                        1000)) +
                '/' +
                _conditionTranslator(
                    _knowledge.elementAt(index).split('/').last) +
                '/' +
                _timeTranslator(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(_knowledge.elementAt(index).split('/').first) *
                        1000)));
          }
        }
      }

      final DateTime _rise = DateTime.fromMillisecondsSinceEpoch(
          int.parse(jsonDecode(data)['city']['sunrise'].toString()) * 1000);
      final DateTime _set = DateTime.fromMillisecondsSinceEpoch(
          int.parse(jsonDecode(data)['city']['sunset'].toString()) * 1000);

      _sunrise = _timeTranslator(_rise);
      _sunset = _timeTranslator(_set);
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

String _conditionTranslator(String enCondition) {
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
}

String _dateTranslator(DateTime dateTime) {
  final int today = DateTime.now().day;
  if (dateTime.day - today == 0)
    return 'នេះ';
  else if (dateTime.day - today == 1)
    return 'ស្អែក';
  else if (dateTime.day - today == 2)
    return 'ខានស្អែក';
  else
    return 'ទី${dateTime.day}';
}

String _timeTranslator(DateTime dateTime) {
  final String _hour = dateTime.hour > 12
      ? (dateTime.hour - 12).toString()
      : dateTime.hour.toString();
  String _translatedString = dateTime.minute == 0
      ? _hour
      : dateTime.minute < 10
          ? _hour + ':0' + dateTime.minute.toString() + 'នាទី'
          : _hour + ':' + dateTime.minute.toString() + 'នាទី';
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
}
