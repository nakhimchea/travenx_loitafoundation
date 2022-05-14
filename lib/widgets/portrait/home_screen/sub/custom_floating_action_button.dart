import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData iconData;
  final Color? iconColor;
  final double iconSize;
  final Color? buttonColor;
  final double buttonSize;

  const CustomFloatingActionButton({
    Key? key,
    required this.onTap,
    this.iconData = Icons.arrow_back_ios_new,
    this.iconColor,
    this.iconSize = 18.0,
    this.buttonColor,
    this.buttonSize = 42,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(buttonSize / 2),
      highlightColor: Colors.transparent,
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.2),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.6),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor != null
              ? buttonColor
              : Theme.of(context).disabledColor.withOpacity(0.5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).disabledColor.withOpacity(0.5),
              offset: const Offset(0, 1),
              spreadRadius: 2.0,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Icon(
          iconData,
          color:
              iconColor != null ? iconColor : Theme.of(context).iconTheme.color,
          size: iconSize,
        ),
      ),
    );
  }
}
