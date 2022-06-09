import 'package:flutter/material.dart';

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
          margin: EdgeInsets.symmetric(
              vertical: constraints.maxWidth / 300 > 1.6
                  ? 5
                  : constraints.maxWidth / 100),
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / 300 > 1.6
                  ? 16
                  : constraints.maxWidth / 18.75,
              vertical: constraints.maxWidth / 300 > 1.6
                  ? 15
                  : constraints.maxWidth / 32),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              SizedBox(
                  width: constraints.maxWidth / 300 > 1.6
                      ? 10
                      : constraints.maxWidth / 30),
              Expanded(
                child: Text(
                  title,
                  textScaleFactor: constraints.maxWidth / 200 > 1.6
                      ? 1.6
                      : constraints.maxWidth / 200,
                  style: TextStyle(
                    color: textColor != null
                        ? textColor
                        : Theme.of(context).iconTheme.color,
                    fontSize: 12.0,
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
