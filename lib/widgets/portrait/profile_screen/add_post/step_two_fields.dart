import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/custom_input_box.dart';

class StepTwoFields extends StatelessWidget {
  final bool isTitleHighlight;
  final void Function() disableHighlight;
  final TextEditingController titleController;
  final TextEditingController priceController;
  const StepTwoFields({
    Key? key,
    required this.isTitleHighlight,
    required this.disableHighlight,
    required this.titleController,
    required this.priceController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApStLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.titleLarge
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            isHighlight: isTitleHighlight,
            label: AppLocalizations.of(context)!.pfApStTitleLabel,
            hintText: AppLocalizations.of(context)!.pfApStTitleHint,
            textController: titleController,
            disableHighlight: disableHighlight,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            label: AppLocalizations.of(context)!.pfApStPriceLabel,
            hintText: AppLocalizations.of(context)!.pfApStPriceHint,
            textController: priceController,
            inputType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    );
  }
}
