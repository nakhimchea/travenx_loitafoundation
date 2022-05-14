import 'package:flutter/material.dart';
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
        SizedBox(height: this.forecast.length > 0 ? 5.0 : 0.0),
        this.forecast.length > 0
            ? this.forecast.length == 1
                ? Text(
                    'ទីនេះ ថ្ងៃ${this.forecast.first.split('/')[0]}នឹងមាន${this.forecast.first.split('/')[1]} នៅម៉ោង ${this.forecast.first.split('/')[2]}។',
                    textAlign: TextAlign.justify,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).errorColor),
                  )
                : Text(
                    'ទីនេះ ថ្ងៃ${this.forecast.first.split('/')[0]}នឹងមាន${this.forecast.first.split('/')[1]} នៅម៉ោង ${this.forecast.first.split('/')[2]}។'
                    ' ហើយថ្ងៃ${this.forecast.elementAt(1).split('/')[0]}នឹងមាន${this.forecast.elementAt(1).split('/')[1]} នៅម៉ោង ${this.forecast.elementAt(1).split('/')[2]}។',
                    textAlign: TextAlign.justify,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).errorColor),
                  )
            : const SizedBox.shrink(),
        const SizedBox(height: 25.0),
        this.sunset != ''
            ? Center(
                child: Text(
                  'ថ្ងៃនេះព្រះអាទិត្យលិចនៅទីតាំងនេះ ម៉ោង $sunset។\nហើយរះថ្ងៃស្អែក នៅម៉ោង $sunrise។',
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).iconTheme.color),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(height: this.sunset != '' ? 15.0 : 0.0),
      ],
    );
  }
}
