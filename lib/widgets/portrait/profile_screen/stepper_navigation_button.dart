import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kVPadding, displayScaleFactor;

class StepperNavigationButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  const StepperNavigationButton({
    Key? key,
    required this.backgroundColor,
    required this.label,
    required this.textStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: backgroundColor == Theme.of(context).primaryColor
            ? null
            : Theme.of(context).bottomAppBarColor == Colors.white
                ? Theme.of(context).disabledColor
                : Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
          overlayColor: MaterialStateProperty.all<Color?>(
              textStyle!.color!.withOpacity(0.1)),
          shape: MaterialStateProperty.all<OutlinedBorder?>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kVPadding / 2),
          child: Text(
            label,
            textScaleFactor: displayScaleFactor,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
