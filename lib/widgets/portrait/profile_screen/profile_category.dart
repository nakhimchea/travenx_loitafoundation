import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';
import 'package:travenx_loitafoundation/config/variable.dart';

class ProfileCategory extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<Widget> trailing;
  final Color? textColor;

  const ProfileCategory({
    Key? key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Profile Item Clicked ...'),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(horizontal: kHPadding, vertical: 20.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            SizedBox(width: kHPadding),
            Text(
              title,
              textScaleFactor: textScaleFactor,
              style: TextStyle(
                color: textColor != null
                    ? textColor
                    : Theme.of(context).iconTheme.color,
                fontSize: 14.0,
                fontFamily: 'Nokora',
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
