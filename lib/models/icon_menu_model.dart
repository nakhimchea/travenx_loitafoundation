import 'package:flutter/widgets.dart' show Widget, BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenx_loitafoundation/config/constant.dart' show iconSize;

class ModelIconMenu {
  final Widget icon;
  final String label;

  const ModelIconMenu({
    required this.icon,
    required this.label,
  });
}

List<ModelIconMenu> modelIconMenus(BuildContext context) => [
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_camping.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icCamping,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_sea.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icSea,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_temple.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icTemple,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_mountain.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icMountain,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_park.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icPark,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_resort.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icResort,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_zoo.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icZoo,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_locations.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icLocations,
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/ic_locations.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppLocalizations.of(context)!.icAll,
      ),
    ];
