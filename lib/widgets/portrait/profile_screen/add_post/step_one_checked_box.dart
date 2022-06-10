import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;

class StepOneCheckedBox extends StatelessWidget {
  final bool isAgreementHighlight;
  final bool isChecked;
  final void Function() isCheckedCallback;
  const StepOneCheckedBox({
    Key? key,
    required this.isAgreementHighlight,
    required this.isChecked,
    required this.isCheckedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kHPadding,
        right: kHPadding,
        top: 2 * kHPadding,
        bottom: kHPadding,
      ),
      decoration: BoxDecoration(
        color: isAgreementHighlight
            ? Theme.of(context).highlightColor.withOpacity(0.1)
            : Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: isCheckedCallback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                !isChecked
                    ? Icons.check_box_outline_blank
                    : Icons.check_box_outlined,
                color: !isChecked
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).primaryColor,
                size: 20.0 * displayScaleFactor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.pfApSoCheckbox,
                textAlign: TextAlign.justify,
                textScaleFactor: displayScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                        color:
                            isChecked ? Theme.of(context).primaryColor : null)
                    : Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color:
                            isChecked ? Theme.of(context).primaryColor : null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
