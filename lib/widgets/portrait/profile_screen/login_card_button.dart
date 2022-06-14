import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;

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
      padding: EdgeInsets.symmetric(horizontal: 26.0 * displayScaleFactor),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
          decoration: BoxDecoration(
            color: titleColor != null
                ? titleColor
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: kHPadding),
              Image.asset(
                leadingUrl,
                width: (titleColor != null ? 22.0 : 25.0) * displayScaleFactor,
                height: (titleColor != null ? 22.0 : 25.0) * displayScaleFactor,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textScaleFactor: displayScaleFactor,
                      style: AppLocalizations.of(context)!.localeName == 'km'
                          ? Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .copyWith(
                                  color: titleColor != null
                                      ? Colors.white
                                      : Theme.of(context)
                                          .primaryIconTheme
                                          .color)
                          : Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: titleColor != null
                                  ? Colors.white
                                  : Theme.of(context).primaryIconTheme.color),
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                    Align(
                      alignment: const Alignment(0, -0.06),
                      child: Text(
                        trailing != '' ? ' ' + trailing : '',
                        textScaleFactor: displayScaleFactor,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryIconTheme.color,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40 * displayScaleFactor),
            ],
          ),
        ),
      ),
    );
  }
}
