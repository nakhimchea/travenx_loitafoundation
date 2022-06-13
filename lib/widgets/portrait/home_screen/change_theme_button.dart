import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kVPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/helpers/theme_type.dart';
import 'package:travenx_loitafoundation/providers/theme_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        radius: 20 * displayScaleFactor,
        child: Icon(
          Icons.light_mode,
          size: 24,
          color: Colors.white,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _CustomThemeDialog(),
        );
      },
    );
  }
}

class _CustomThemeDialog extends StatefulWidget {
  const _CustomThemeDialog({Key? key}) : super(key: key);

  @override
  State<_CustomThemeDialog> createState() => _CustomThemeDialogState();
}

class _CustomThemeDialogState extends State<_CustomThemeDialog> {
  ThemeType? selectedTheme;
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
              _ThemeSelection(
                themeButton: ThemeType.lightGrey,
                onTap: () =>
                    setState(() => selectedTheme = ThemeType.lightGrey),
                selectedTheme: selectedTheme,
              ),
              _ThemeSelection(
                themeButton: ThemeType.lightCoffee,
                onTap: () =>
                    setState(() => selectedTheme = ThemeType.lightCoffee),
                selectedTheme: selectedTheme,
              ),
              _ThemeSelection(
                themeButton: ThemeType.lightPink,
                onTap: () =>
                    setState(() => selectedTheme = ThemeType.lightPink),
                selectedTheme: selectedTheme,
              ),
              _ThemeSelection(
                themeButton: ThemeType.lightPurple,
                onTap: () =>
                    setState(() => selectedTheme = ThemeType.lightPurple),
                selectedTheme: selectedTheme,
              ),
              _ThemeSelection(
                themeButton: ThemeType.darkGrey,
                onTap: () => setState(() => selectedTheme = ThemeType.darkGrey),
                selectedTheme: selectedTheme,
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
                      padding: EdgeInsets.only(
                          left: 26.0 * displayScaleFactor,
                          bottom: kVPadding + 5.0,
                          top: 5.0),
                      child: Text(
                        AppLocalizations.of(context)!.localeName == 'km'
                            ? 'បោះបង់'
                            : AppLocalizations.of(context)!.localeName == 'zh'
                                ? '取消'
                                : 'Cancel',
                        textScaleFactor: displayScaleFactor,
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
                          Provider.of<ThemeProvider>(context, listen: false);
                      if (selectedTheme != null)
                        provider.setTheme(selectedTheme!);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 26.0 * displayScaleFactor, bottom: kVPadding),
                      child: Text(
                        AppLocalizations.of(context)!.localeName == 'km'
                            ? 'រួចរាល់'
                            : AppLocalizations.of(context)!.localeName == 'zh'
                                ? '完毕'
                                : 'Done',
                        textScaleFactor: displayScaleFactor,
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

class _ThemeSelection extends StatelessWidget {
  final ThemeType? themeButton;
  final void Function() onTap;
  final ThemeType? selectedTheme;
  const _ThemeSelection({
    Key? key,
    required this.themeButton,
    required this.onTap,
    required this.selectedTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = '';
    switch (themeButton) {
      case ThemeType.lightGrey:
        AppLocalizations.of(context)!.localeName == 'km'
            ? label = 'ពណ៌ប្រផេះភ្លឺ'
            : AppLocalizations.of(context)!.localeName == 'en'
                ? label = 'Light Grey'
                : label = '----';
        break;
      case ThemeType.lightCoffee:
        AppLocalizations.of(context)!.localeName == 'km'
            ? label = 'ពណ៌កាហ្វេ'
            : AppLocalizations.of(context)!.localeName == 'en'
                ? label = 'Light Coffee'
                : label = '----';
        break;
      case ThemeType.lightPink:
        AppLocalizations.of(context)!.localeName == 'km'
            ? label = 'ពណ៌ផ្កាឈូក'
            : AppLocalizations.of(context)!.localeName == 'en'
                ? label = 'Light Pink'
                : label = '----';
        break;
      case ThemeType.lightPurple:
        AppLocalizations.of(context)!.localeName == 'km'
            ? label = 'ពណ៌ស្វាយ'
            : AppLocalizations.of(context)!.localeName == 'en'
                ? label = 'Light Purple'
                : label = '----';
        break;
      case ThemeType.darkGrey:
        AppLocalizations.of(context)!.localeName == 'km'
            ? label = 'ពណ៌ប្រផេះងងឹត'
            : AppLocalizations.of(context)!.localeName == 'en'
                ? label = 'Dark Grey'
                : label = '----';
        break;
      default:
        break;
    }
    return InkWell(
      onTap: onTap,
      focusColor: Theme.of(context).focusColor,
      highlightColor: Theme.of(context).highlightColor,
      hoverColor: Theme.of(context).hoverColor,
      child: Container(
        decoration: BoxDecoration(
          color: selectedTheme != null && selectedTheme == themeButton
              ? Theme.of(context).disabledColor
              : null,
          borderRadius: selectedTheme == ThemeType.lightGrey
              ? BorderRadius.vertical(top: Radius.circular(15.0))
              : null,
        ),
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: kVPadding),
        child: Text(
          label,
          textScaleFactor: displayScaleFactor,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
