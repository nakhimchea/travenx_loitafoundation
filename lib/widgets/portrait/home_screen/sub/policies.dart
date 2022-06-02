import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;

class Policies extends StatelessWidget {
  final List<String> policies;

  const Policies({Key? key, required this.policies}) : super(key: key);

  List<Widget> _buildPolicies(BuildContext context) {
    List<Widget> policyList = [];
    for (String policy in this.policies)
      policyList.add(
        Text(
          '• ' + policy,
          textScaleFactor: textScaleFactor,
          textAlign: TextAlign.justify,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.bodyLarge
              : Theme.of(context).textTheme.bodyLarge,
        ),
      );

    return policyList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHPadding,
        vertical: kVPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.pdPoliciesLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.titleLarge
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildPolicies(context),
          ),
        ],
      ),
    );
  }
}
