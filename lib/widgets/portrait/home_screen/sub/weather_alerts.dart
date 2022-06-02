import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show textScaleFactor;

class WeatherAlerts extends StatelessWidget {
  final List<String> forecast;
  final String sunrise;
  final String sunset;
  const WeatherAlerts({
    Key? key,
    required this.forecast,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: this.forecast.length > 0 ? 10.0 : 0.0),
        this.forecast.length > 0
            ? this.forecast.length == 1
                ? Text(
                    AppLocalizations.of(context)!.localeName == 'km'
                        ? 'ទីនេះ ${this.forecast.first.split('/')[0]}នឹងមាន${this.forecast.first.split('/')[1]} នៅម៉ោង ${this.forecast.first.split('/')[2]}។'
                        : AppLocalizations.of(context)!.localeName == 'en'
                            ? 'There will be a ${this.forecast.first.split('/')[1]} here ${this.forecast.first.split('/')[0]} at ${this.forecast.first.split('/')[2]}.'
                            : '',
                    textAlign: TextAlign.justify,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).errorColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).errorColor),
                  )
                : Text(
                    AppLocalizations.of(context)!.localeName == 'km'
                        ? 'ទីនេះ ${this.forecast.first.split('/')[0]}នឹងមាន${this.forecast.first.split('/')[1]} នៅម៉ោង ${this.forecast.first.split('/')[2]}។'
                            ' ហើយ ${this.forecast.elementAt(1).split('/')[0]}នឹងមាន${this.forecast.elementAt(1).split('/')[1]} នៅម៉ោង ${this.forecast.elementAt(1).split('/')[2]}។'
                        : AppLocalizations.of(context)!.localeName == 'en'
                            ? 'There will be a ${this.forecast.first.split('/')[1]} here ${this.forecast.first.split('/')[0]} at ${this.forecast.first.split('/')[2]}.'
                                ' And there will also be a ${this.forecast.elementAt(1).split('/')[1]} ${this.forecast.elementAt(1).split('/')[0]} at ${this.forecast.first.split('/')[2]}.'
                            : '',
                    textAlign: TextAlign.justify,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).errorColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).errorColor),
                  )
            : const SizedBox.shrink(),
        const SizedBox(height: 20.0),
        this.sunset != ''
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.localeName == 'km'
                      ? 'ថ្ងៃនេះព្រះអាទិត្យលិចនៅទីតាំងនេះ ម៉ោង $sunset។\nហើយរះថ្ងៃស្អែក នៅម៉ោង $sunrise។'
                      : AppLocalizations.of(context)!.localeName == 'en'
                          ? 'Today, the sun will here set at $sunset.\nAnd rise tomorrow at $sunrise.'
                          : '',
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context)
                          .primaryTextTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w400)
                      : Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(height: this.sunset != '' ? 15.0 : 0.0),
      ],
    );
  }
}
