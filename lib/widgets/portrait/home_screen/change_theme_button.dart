import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/constant.dart' show kVPadding;
import 'package:travenx_loitafoundation/providers/locale_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Theme.of(context).highlightColor,
        radius: 20,
        child: Image.asset(
          'assets/icons/home_screen/languages.png',
          height: 24,
          width: 24,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _CustomLanguageDialog(),
        );
      },
    );
  }
}

class _CustomLanguageDialog extends StatefulWidget {
  const _CustomLanguageDialog({
    Key? key,
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: 18),
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
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
              InkWell(
                onTap: () => setState(() => selectedLanguage = 2),
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  color: selectedLanguage != null && selectedLanguage == 2
                      ? Theme.of(context).disabledColor
                      : null,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: kVPadding),
                  child: Text(
                    '中文',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
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
                      padding:
                          const EdgeInsets.only(left: 30.0, bottom: kVPadding),
                      child: Text(
                        selectedLanguage == 0
                            ? 'បោះបង់'
                            : selectedLanguage == 2
                                ? '取消'
                                : 'Cancel',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final provider =
                          Provider.of<LocaleProvider>(context, listen: false);
                      if (selectedLanguage != null)
                        provider.setLocale(selectedLanguage!);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 30.0, bottom: kVPadding),
                      child: Text(
                        selectedLanguage == 0
                            ? 'រួចរាល់'
                            : selectedLanguage == 2
                                ? '完毕'
                                : 'Done',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Theme.of(context).primaryColor),
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
