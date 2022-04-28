import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
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
      color: Theme.of(context).bottomAppBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'សកម្មភាព (ជ្រើសរើសបានលើសពី១)',
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.button,
          ),
          const SizedBox(height: kHPadding),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 7,
            children: [
              ActivityButton(
                label: 'ជិះទូក',
                state: activities.contains(ActivityType.boating),
                onPressed: () {
                  activityPickerCallback(ActivityType.boating,
                      isRemoved: activities.contains(ActivityType.boating));
                },
              ),
              ActivityButton(
                label: 'មុជទឹក',
                state: activities.contains(ActivityType.diving),
                onPressed: () {
                  activityPickerCallback(ActivityType.diving,
                      isRemoved: activities.contains(ActivityType.diving));
                },
              ),
              ActivityButton(
                label: 'ស្ទូចត្រី',
                state: activities.contains(ActivityType.fishing),
                onPressed: () {
                  activityPickerCallback(ActivityType.fishing,
                      isRemoved: activities.contains(ActivityType.fishing));
                },
              ),
              ActivityButton(
                label: 'លំហែកាយ',
                state: activities.contains(ActivityType.relaxing),
                onPressed: () {
                  activityPickerCallback(ActivityType.relaxing,
                      isRemoved: activities.contains(ActivityType.relaxing));
                },
              ),
              ActivityButton(
                label: 'ហែលទឹក',
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

class ActivityButton extends StatelessWidget {
  final String label;
  final bool state;
  final void Function()? onPressed;
  const ActivityButton({
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
            Theme.of(context).textTheme.button!.color!.withOpacity(0.1)),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          label,
          textScaleFactor: textScaleFactor,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: state ? Colors.white : null),
        ),
      ),
    );
  }
}
