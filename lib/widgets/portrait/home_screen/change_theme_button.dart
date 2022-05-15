import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/providers/locale_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        child: Icon(
          AppLocalizations.of(context)!.localeName == 'en'
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
      ),
      onTap: () {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        provider.setLocale(Locale('km'));
      },
    );
  }
}
