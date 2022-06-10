import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/helpers/activity_type.dart';

class ActivityPicker extends StatelessWidget {
  final List<ActivityType> activities;
  final void Function(ActivityType, {bool isRemoved}) activityPickerCallback;
  const ActivityPicker({
    Key? key,
    required this.activities,
    required this.activityPickerCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApSthActivityLabel,
            textAlign: TextAlign.justify,
            textScaleFactor: displayScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyMedium
                : Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: kHPadding),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 7,
            children: [
              _ActivityButton(
                label: AppLocalizations.of(context)!.pdActivityBoating,
                state: activities.contains(ActivityType.boating),
                onPressed: () {
                  activityPickerCallback(ActivityType.boating,
                      isRemoved: activities.contains(ActivityType.boating));
                },
              ),
              _ActivityButton(
                label: AppLocalizations.of(context)!.pdActivityDiving,
                state: activities.contains(ActivityType.diving),
                onPressed: () {
                  activityPickerCallback(ActivityType.diving,
                      isRemoved: activities.contains(ActivityType.diving));
                },
              ),
              _ActivityButton(
                label: AppLocalizations.of(context)!.pdActivityFishing,
                state: activities.contains(ActivityType.fishing),
                onPressed: () {
                  activityPickerCallback(ActivityType.fishing,
                      isRemoved: activities.contains(ActivityType.fishing));
                },
              ),
              _ActivityButton(
                label: AppLocalizations.of(context)!.pdActivityRelaxing,
                state: activities.contains(ActivityType.relaxing),
                onPressed: () {
                  activityPickerCallback(ActivityType.relaxing,
                      isRemoved: activities.contains(ActivityType.relaxing));
                },
              ),
              _ActivityButton(
                label: AppLocalizations.of(context)!.pdActivitySwimming,
                state: activities.contains(ActivityType.swimming),
                onPressed: () {
                  activityPickerCallback(ActivityType.swimming,
                      isRemoved: activities.contains(ActivityType.swimming));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityButton extends StatelessWidget {
  final String label;
  final bool state;
  final void Function()? onPressed;
  const _ActivityButton({
    Key? key,
    required this.label,
    required this.state,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(state
            ? Theme.of(context).primaryColor.withOpacity(0.8)
            : Theme.of(context).scaffoldBackgroundColor),
        overlayColor: MaterialStateProperty.all<Color?>(
            Theme.of(context).iconTheme.color!.withOpacity(0.1)),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          label,
          textScaleFactor: displayScaleFactor,
          textAlign: TextAlign.center,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context)
                  .primaryTextTheme
                  .bodySmall!
                  .copyWith(color: state ? Colors.white : null)
              : Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: state ? Colors.white : null),
        ),
      ),
    );
  }
}
