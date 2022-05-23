import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/variable.dart'
    show textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class CustomSnackBarContent extends StatelessWidget {
  final String contentCode;
  final String? phoneNumber;
  const CustomSnackBarContent({
    Key? key,
    required this.contentCode,
    this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3.0)]),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 45.0,
                decoration: BoxDecoration(
                  color: contentCode == 'code_sent' ||
                          contentCode == 'successful_login'
                      ? Theme.of(context).primaryColor
                      : contentCode == 'invalid_phone_number' ||
                              contentCode == 'invalid_sms_code' ||
                              contentCode == 'invalid_facebook_account' ||
                              contentCode == 'invalid_google_account'
                          ? Theme.of(context).errorColor
                          : Theme.of(context).hintColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(5.0)),
                ),
              ),
              contentCode == 'invalid_phone_number' ||
                      contentCode == 'invalid_sms_code' ||
                      contentCode == 'invalid_facebook_account' ||
                      contentCode == 'invalid_google_account'
                  ? CircleAvatar(
                      radius: (14 * textScaleFactor) / 2,
                      backgroundColor: Colors.white,
                      child: Icon(
                        CustomOutlinedIcons.close,
                        size: 10 * textScaleFactor,
                        color: Theme.of(context).errorColor,
                      ),
                    )
                  : Icon(
                      contentCode == 'code_sent' ||
                              contentCode == 'successful_login'
                          ? CustomFilledIcons.success
                          : CustomFilledIcons.warning,
                      size: 16 * textScaleFactor,
                      color: Colors.white,
                    ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: contentCode != 'code_sent'
                ? Image.asset(
                    'assets/images/profile_screen/${AppLocalizations.of(context)!.localeName == 'km' ? contentCode + '_km' : contentCode}.png',
                    height: 16.0 * textScaleFactor,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.centerLeft,
                  )
                : Row(
                    children: [
                      Image.asset(
                        'assets/images/profile_screen/${AppLocalizations.of(context)!.localeName == 'km' ? contentCode + '_km' : contentCode}.png',
                        height: 16.0 * textScaleFactor,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$phoneNumber',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
