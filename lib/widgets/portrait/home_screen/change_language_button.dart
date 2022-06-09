import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/providers/locale_provider.dart';

class ChangeLanguageButton extends StatelessWidget {
  final void Function() callback;
  const ChangeLanguageButton({Key? key, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Theme.of(context).highlightColor,
        radius: 20 * textScaleFactor,
        child: Image.asset(
          'assets/icons/home_screen/languages.png',
          height: 24 * textScaleFactor,
          width: 24 * textScaleFactor,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _CustomLanguageDialog(callback: callback),
        );
      },
    );
  }
}

class _CustomLanguageDialog extends StatefulWidget {
  final void Function() callback;
  const _CustomLanguageDialog({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<_CustomLanguageDialog> createState() => _CustomLanguageDialogState();
}

class _CustomLanguageDialogState extends State<_CustomLanguageDialog> {
  int? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Wrap(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () => setState(() => selectedLanguage = 0),
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedLanguage != null && selectedLanguage == 0
                        ? Theme.of(context).disabledColor
                        : null,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.0)),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: kVPadding),
                  child: Text(
                    'ភាសាខ្មែរ',
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              InkWell(
                onTap: () => setState(() => selectedLanguage = 1),
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  color: selectedLanguage != null && selectedLanguage == 1
                      ? Theme.of(context).disabledColor
                      : null,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: kVPadding),
                  child: Text(
                    'English',
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () => setState(() => selectedLanguage = 2),
              //   focusColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   hoverColor: Colors.transparent,
              //   child: Container(
              //     color: selectedLanguage != null && selectedLanguage == 2
              //         ? Theme.of(context).disabledColor
              //         : null,
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(vertical: kVPadding),
              //     child: Text(
              //       '中文',
              //       style: Theme.of(context)
              //           .textTheme
              //           .labelSmall,
              //     ),
              //   ),
              // ),
              Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                indent: 6.0,
                endIndent: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 26.0 * textScaleFactor,
                          bottom: kVPadding + 5.0,
                          top: 5.0),
                      child: Text(
                        selectedLanguage == 0
                            ? 'បោះបង់'
                            : selectedLanguage == 2
                                ? '取消'
                                : 'Cancel',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final provider =
                          Provider.of<LocaleProvider>(context, listen: false);
                      if (selectedLanguage != null)
                        provider.setLocale(selectedLanguage!);
                      widget.callback();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 26.0 * textScaleFactor, bottom: kVPadding),
                      child: Text(
                        selectedLanguage == 0
                            ? 'រួចរាល់'
                            : selectedLanguage == 2
                                ? '完毕'
                                : 'Done',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
