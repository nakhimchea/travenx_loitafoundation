import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, iconSize;
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/icon_menu_tab.dart';

class IconsMenu extends StatelessWidget {
  final List<List<PostObject>> iconMenus;

  const IconsMenu({Key? key, required this.iconMenus}) : super(key: key);

  List<_IconMenu> _buildIconMenus(int initIndex, int finalIndex) {
    List<_IconMenu> iconMenuItems = [];

    for (int index = initIndex; index <= finalIndex; index++)
      iconMenuItems.add(_IconMenu(
        modelIconMenu: modelIconMenus.elementAt(index),
        iconMenus: iconMenus,
        currentIndex: index,
      ));

    return iconMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return iconMenus.length < 8
        ? Container(
            height: 2 * (10 * textScaleFactor + iconSize + kVPadding) + 19.3,
            child: Center(child: CircularProgressIndicator.adaptive()),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIconMenus(0, 3),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIconMenus(4, 7),
              ),
            ],
          );
  }
}

class _IconMenu extends StatelessWidget {
  final ModelIconMenu modelIconMenu;
  final List<List<PostObject>> iconMenus;
  final int currentIndex;

  const _IconMenu({
    Key? key,
    required this.modelIconMenu,
    required this.iconMenus,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IconMenuTab(
            initIndex: currentIndex,
            iconMenus: iconMenus,
          ),
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
