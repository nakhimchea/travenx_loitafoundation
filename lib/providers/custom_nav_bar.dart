import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';

class CustomNavBar extends StatelessWidget {
  final Map<String, List<IconData>> icons;
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomNavBar({
    Key? key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      tabs: icons
          .map(
            (key, icon) => MapEntry(
              key,
              Tab(
                iconMargin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                icon: Icon(
                  key == icons.keys.elementAt(selectedIndex)
                      ? icon[1]
                      : icon[0],
                  color: key == icons.keys.elementAt(selectedIndex)
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryIconTheme.color,
                  size: 30.0,
                ),
                child: Text(
                  key,
                  textScaleFactor: textScaleFactor,
                  style: key != icons.keys.elementAt(selectedIndex)
                      ? Theme.of(context).textTheme.bodyText2
                      : Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
          .values
          .toList(),
      onTap: onTap,
      indicator: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 3,
            color: Theme.of(context).primaryColor,
          ),
          left: BorderSide(
            width: 1.5,
            color: Theme.of(context).bottomAppBarColor,
          ),
          right: BorderSide(
            width: 1.5,
            color: Theme.of(context).bottomAppBarColor,
          ),
        ),
      ),
    );
  }
}
