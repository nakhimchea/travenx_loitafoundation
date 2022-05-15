import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/icon_menu_tab.dart';

class IconsMenu extends StatelessWidget {
  const IconsMenu({Key? key}) : super(key: key);

  List<_IconMenu> _buildIconMenus(
      BuildContext context, int initIndex, int finalIndex) {
    List<_IconMenu> iconMenuItems = [];

    for (int index = initIndex; index <= finalIndex; index++)
      iconMenuItems.add(_IconMenu(
        modelIconMenu: modelIconMenus(context).elementAt(index),
        currentIndex: index,
      ));

    return iconMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildIconMenus(context, 0, 3),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildIconMenus(context, 4, 7),
        ),
      ],
    );
  }
}

class _IconMenu extends StatelessWidget {
  final ModelIconMenu modelIconMenu;
  final int currentIndex;

  const _IconMenu({
    Key? key,
    required this.modelIconMenu,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IconMenuTab(initIndex: currentIndex),
        ),
      ),
      child: Container(
        width: (MediaQuery.of(context).size.width - (kHPadding * 2)) / 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kVPadding),
              child: modelIconMenu.icon,
            ),
            Text(
              modelIconMenu.label,
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
