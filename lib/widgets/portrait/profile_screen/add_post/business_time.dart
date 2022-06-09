import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/time_translator.dart';

class BusinessTime extends StatelessWidget {
  final bool openEnabled;
  final void Function({bool isDisabled}) openEnabledCallback;
  final bool closeEnabled;
  final void Function({bool isDisabled}) closeEnabledCallback;
  final DateTime openHour;
  final void Function(DateTime) openHourCallback;
  final DateTime closeHour;
  final void Function(DateTime) closeHourCallback;
  const BusinessTime({
    Key? key,
    required this.openEnabled,
    required this.openEnabledCallback,
    required this.closeEnabled,
    required this.closeEnabledCallback,
    required this.openHour,
    required this.openHourCallback,
    required this.closeHour,
    required this.closeHourCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApSthAdditionalLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.titleLarge
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: kHPadding),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    openEnabledCallback();
                    showDialog(
                      context: context,
                      builder: (context) => _CustomDialog(
                        hour: openHour,
                        hourCallback: openHourCallback,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: kVPadding),
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: !openEnabled
                              ? Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.5)
                              : Theme.of(context).primaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: kHPadding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                    .pfApSthAdditionalAtLabel +
                                timeTranslator(context, openHour),
                            style:
                                AppLocalizations.of(context)!.localeName == 'km'
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: openEnabled
                                                ? Theme.of(context)
                                                    .primaryIconTheme
                                                    .color
                                                : null,
                                            fontSize: 14 * textScaleFactor)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: openEnabled
                                                ? Theme.of(context)
                                                    .primaryIconTheme
                                                    .color
                                                : null,
                                            fontSize: 14 * textScaleFactor),
                          ),
                        ),
                      ),
                      Positioned(
                        left: kHPadding,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          color: Theme.of(context).canvasColor,
                          child: Text(
                            AppLocalizations.of(context)!
                                .pfApSthAdditionalOpenLabel,
                            textScaleFactor: textScaleFactor,
                            style:
                                AppLocalizations.of(context)!.localeName == 'km'
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: openEnabled
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.8)
                                                : null)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: openEnabled
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.8)
                                                : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    closeEnabledCallback();
                    showDialog(
                      context: context,
                      builder: (context) => _CustomDialog(
                        isOpenHour: false,
                        hour: closeHour,
                        hourCallback: closeHourCallback,
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: kVPadding),
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: !closeEnabled
                              ? Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.5)
                              : Theme.of(context).errorColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: kHPadding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                    .pfApSthAdditionalAtLabel +
                                timeTranslator(context, closeHour),
                            style:
                                AppLocalizations.of(context)!.localeName == 'km'
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: closeEnabled
                                                ? Theme.of(context)
                                                    .primaryIconTheme
                                                    .color
                                                : null,
                                            fontSize: 14 * textScaleFactor)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: closeEnabled
                                                ? Theme.of(context)
                                                    .primaryIconTheme
                                                    .color
                                                : null,
                                            fontSize: 14 * textScaleFactor),
                          ),
                        ),
                      ),
                      Positioned(
                        left: kHPadding,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          color: Theme.of(context).canvasColor,
                          child: Text(
                            AppLocalizations.of(context)!
                                .pfApSthAdditionalCloseLabel,
                            textScaleFactor: textScaleFactor,
                            style:
                                AppLocalizations.of(context)!.localeName == 'km'
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: closeEnabled
                                                ? Theme.of(context)
                                                    .errorColor
                                                    .withOpacity(0.8)
                                                : null)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: closeEnabled
                                                ? Theme.of(context)
                                                    .errorColor
                                                    .withOpacity(0.8)
                                                : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: openEnabled || closeEnabled,
                child: const SizedBox(width: 10),
              ),
              Visibility(
                visible: openEnabled || closeEnabled,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      openHourCallback(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 8));
                      closeHourCallback(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 21));
                      openEnabledCallback(isDisabled: true);
                      closeEnabledCallback(isDisabled: true);
                    },
                    child: Icon(
                      Icons.close,
                      size: 26,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomDialog extends StatefulWidget {
  final bool isOpenHour;
  final DateTime hour;
  final void Function(DateTime) hourCallback;
  const _CustomDialog({
    Key? key,
    this.isOpenHour = true,
    required this.hour,
    required this.hourCallback,
  }) : super(key: key);

  @override
  State<_CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<_CustomDialog> {
  bool _resetHold = false;
  bool _doneHold = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).canvasColor,
      insetPadding: EdgeInsets.symmetric(
          horizontal:
              (MediaQuery.of(context).size.width - 230 * textScaleFactor) / 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kVPadding),
          Container(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            height: 160 * textScaleFactor,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(
                            fontSize: 24 * textScaleFactor,
                            fontWeight: FontWeight.w500)),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: widget.hour,
                minuteInterval: 5,
                onDateTimeChanged: widget.hourCallback,
              ),
            ),
          ),
          const SizedBox(height: kVPadding),
          Divider(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            indent: 6.0,
            endIndent: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  widget.isOpenHour
                      ? widget.hourCallback(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 8))
                      : widget.hourCallback(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day, 21));
                  Navigator.pop(context);
                },
                onLongPress: () => setState(() => _resetHold = true),
                onLongPressEnd: (_) => setState(() => _resetHold = false),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: kVPadding),
                  child: Text(
                    AppLocalizations.of(context)!.resetLabel,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(
                                color: _resetHold
                                    ? widget.isOpenHour
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4)
                                        : Theme.of(context)
                                            .errorColor
                                            .withOpacity(0.3)
                                    : widget.isOpenHour
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .errorColor
                                            .withOpacity(0.7),
                                fontWeight: FontWeight.w400)
                        : Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: _resetHold
                                ? widget.isOpenHour
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4)
                                    : Theme.of(context)
                                        .errorColor
                                        .withOpacity(0.3)
                                : widget.isOpenHour
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .errorColor
                                        .withOpacity(0.7),
                            fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                onLongPress: () => setState(() => _doneHold = true),
                onLongPressEnd: (_) => setState(() => _doneHold = false),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30.0, bottom: kVPadding + 5.0, top: 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.doneLabel,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .copyWith(
                                color: _doneHold
                                    ? widget.isOpenHour
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4)
                                        : Theme.of(context)
                                            .errorColor
                                            .withOpacity(0.3)
                                    : widget.isOpenHour
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .errorColor
                                            .withOpacity(0.7))
                        : Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: _doneHold
                                ? widget.isOpenHour
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4)
                                    : Theme.of(context)
                                        .errorColor
                                        .withOpacity(0.3)
                                : widget.isOpenHour
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .errorColor
                                        .withOpacity(0.7)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
