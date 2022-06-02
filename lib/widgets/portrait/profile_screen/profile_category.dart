import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';
import 'package:travenx_loitafoundation/config/variable.dart';

class ProfileCategory extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<Widget> trailing;
  final Color? textColor;
  final void Function()? onTap;

  const ProfileCategory({
    Key? key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding:
            const EdgeInsets.symmetric(horizontal: kHPadding, vertical: 15.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            const SizedBox(width: kHPadding),
            Text(
              title,
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: textColor != null
                        ? textColor
                        : Theme.of(context).iconTheme.color,
                  ),
              overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
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
