import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';

class LoginCardButton extends StatelessWidget {
  final String leadingUrl;
  final String title;
  final String trailing;
  final Color? titleColor;
  final void Function()? onTap;

  const LoginCardButton({
    Key? key,
    required this.leadingUrl,
    required this.title,
    this.trailing = '',
    this.titleColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4 - 50,
            ),
            child: Row(
              children: [
                Image.asset(
                  leadingUrl,
                  width: 25.0,
                  height: 25.0,
                ),
                SizedBox(width: 30.0),
                Flexible(
                  child: Text(
                    title,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: titleColor != null
                            ? titleColor
                            : Theme.of(context).textTheme.headline4!.color,
                        fontSize: 15.0,
                        fontWeight: titleColor != null &&
                                Theme.of(context).colorScheme.brightness ==
                                    Brightness.dark
                            ? FontWeight.w600
                            : FontWeight.w400),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  trailing,
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
