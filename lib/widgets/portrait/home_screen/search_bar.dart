import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, //TODO: Push Screen when Search Button push to subscreen
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(
              CustomOutlinedIcons.search,
              size: 26.0,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            Text(
              'ស្វែងរក',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
