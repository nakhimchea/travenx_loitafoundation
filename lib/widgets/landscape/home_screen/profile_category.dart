import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';

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
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: MediaQuery.of(context).size.height / 60),
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
              Expanded(
                child: Text(
                  title,
                  textScaleFactor: constraints.maxWidth / 200,
                  style: TextStyle(
                    color: textColor != null
                        ? textColor
                        : Theme.of(context).iconTheme.color,
                    fontSize: 12.0,
                    fontFamily: 'Nokora',
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
