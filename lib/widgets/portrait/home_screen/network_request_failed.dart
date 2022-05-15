import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class NetworkRequestFailed extends StatelessWidget {
  const NetworkRequestFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Theme.of(context).errorColor.withOpacity(0.8),
      child: ListView(
        primary: false,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: kHPadding),
          Icon(
            CustomFilledIcons.warning,
            size: 16 * textScaleFactor,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Center(
            child: Text(
              AppLocalizations.of(context)!.noNetwork,
              textScaleFactor: textScaleFactor,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: kHPadding),
        ],
      ),
    );
  }
}
