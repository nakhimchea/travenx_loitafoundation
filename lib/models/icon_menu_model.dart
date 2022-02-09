import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenx_loitafoundation/config/constant.dart' show iconSize;

class ModelIconMenu {
  final Widget icon;
  final String label;
  final Function()? onTap;

  const ModelIconMenu({
    required this.icon,
    required this.label,
    this.onTap,
  });
}

final List<ModelIconMenu> modelIconMenus = [
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_camping.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'បោះតង់',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_sea.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'សមុទ្រ',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_temple.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'ប្រាសាទ',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_mountain.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'ភ្នំ',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_park.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'ឧទ្យាន',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_resort.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'រមណីយដ្ឋាន',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_zoo.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'សួនសត្វ',
  ),
  ModelIconMenu(
    icon: SvgPicture.asset(
      'assets/icons/home_screen/ic_locations.svg',
      width: iconSize,
      height: iconSize,
    ),
    label: 'តំបន់ផ្សេងៗ',
  ),
];
