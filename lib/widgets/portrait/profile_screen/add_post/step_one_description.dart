import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;

class StepOneDescription extends StatelessWidget {
  final bool isAgreementHighlight;
  const StepOneDescription({
    Key? key,
    required this.isAgreementHighlight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: isAgreementHighlight
            ? Theme.of(context).highlightColor.withOpacity(0.1)
            : Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApSoLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.titleLarge
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: kHPadding),
          Text(
            AppLocalizations.of(context)!.pfApSoDescription,
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyLarge
                : Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: kVPadding),
        ],
      ),
    );
  }
}
