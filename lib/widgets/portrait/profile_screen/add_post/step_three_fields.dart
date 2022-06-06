import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/custom_input_box.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/policies_input_box.dart';

class StepThreeFields extends StatelessWidget {
  final List<TextEditingController> policyControllers;
  final TextEditingController detailsController;
  final void Function({bool isRemoved, int index}) policiesCallback;
  final TextEditingController announcementController;
  const StepThreeFields({
    Key? key,
    required this.policyControllers,
    required this.detailsController,
    required this.policiesCallback,
    required this.announcementController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputBox(
            label: AppLocalizations.of(context)!.pfApSthDetailsLabel,
            hintText: AppLocalizations.of(context)!.pfApSthDetailsHint,
            textController: detailsController,
            minimumLines: 10,
          ),
          const SizedBox(height: kHPadding),
          Text(
            AppLocalizations.of(context)!.pfApSthPoliciesLabel,
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          PoliciesInputBox(
            hintText: AppLocalizations.of(context)!.pfApSthPoliciesHint,
            policyControllers: policyControllers,
            policiesCallback: policiesCallback,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            label: AppLocalizations.of(context)!.pfApSthAnnouncementLabel,
            hintText: AppLocalizations.of(context)!.pfApSthAnnouncementHint1 +
                '\n' +
                AppLocalizations.of(context)!.pfApSthAnnouncementHint2,
            textController: announcementController,
            minimumLines: 5,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
