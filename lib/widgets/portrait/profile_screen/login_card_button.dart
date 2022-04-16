import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

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
            color: titleColor != null
                ? titleColor
                : Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: kHPadding),
              Image.asset(
                leadingUrl,
                width: titleColor != null ? 22.0 : 25.0,
                height: titleColor != null ? 22.0 : 25.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: titleColor != null
                              ? Colors.white
                              : Theme.of(context).textTheme.headline4!.color,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                    Align(
                      alignment: Alignment(0, -0.06),
                      child: Text(
                        trailing != '' ? ' ' + trailing : '',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 15.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
      ),
    );
  }
}
