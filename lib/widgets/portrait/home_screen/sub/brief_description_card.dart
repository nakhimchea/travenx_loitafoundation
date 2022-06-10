import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show displayScaleFactor, briefIconSize;
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';

class BriefDescriptionCard extends StatelessWidget {
  final double ratings;
  final int views;
  final int temperature;

  const BriefDescriptionCard({
    Key? key,
    required this.ratings,
    required this.views,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ModelIconMenu> _briefDescriptionIcons = [
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/star.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: AppLocalizations.of(context)!.pdBdReviewLabel,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/direction.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: AppLocalizations.of(context)!.pdBdDistanceLabel,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/weather.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: AppLocalizations.of(context)!.pdBdForecastLabel,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/view.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: AppLocalizations.of(context)!.pdBdViewLabel,
      ),
    ];

    final int _distance = 500;
    return Container(
      height: MediaQuery.of(context).size.height / 8.12 < 130
          ? 130
          : MediaQuery.of(context).size.height / 8.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).canvasColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(0).icon,
            text: ratings.toStringAsFixed(1),
            subText: _briefDescriptionIcons.elementAt(0).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(1).icon,
            text: (_distance > 1000)
                ? '${(_distance / 1000).toStringAsFixed(0)}km'
                : '${_distance.toStringAsFixed(0)}m',
            subText: _briefDescriptionIcons.elementAt(1).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(2).icon,
            text: '${this.temperature.toString()}c',
            subText: _briefDescriptionIcons.elementAt(2).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(3).icon,
            text: (views > 1000)
                ? '${(views / 1000).toStringAsFixed(1)}k'
                : views.toStringAsFixed(0),
            subText: _briefDescriptionIcons.elementAt(3).label,
          ),
        ],
      ),
    );
  }
}

class _CardRowItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final String subText;

  const _CardRowItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 8.0),
        Text(
          text,
          textScaleFactor: displayScaleFactor,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: '',
              ),
        ),
        const SizedBox(height: 8.0),
        Text(
          subText,
          textScaleFactor: displayScaleFactor,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.bodySmall
              : Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
