import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/variable.dart'
    show displayScaleFactor;

class CustomInputBox extends StatelessWidget {
  final TextEditingController textController;
  final bool isHighlight;
  final void Function()? disableHighlight;
  final String label;
  final String hintText;
  final TextInputType inputType;
  final bool autofocus;
  final int minimumLines;
  const CustomInputBox({
    Key? key,
    required this.textController,
    this.isHighlight = false,
    this.disableHighlight,
    required this.label,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.autofocus = false,
    this.minimumLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.justify,
          textScaleFactor: displayScaleFactor,
          style: minimumLines > 1
              ? AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context).primaryTextTheme.bodyMedium
                  : Theme.of(context).textTheme.bodyMedium
              : AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context).primaryTextTheme.bodySmall
                  : Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 3),
        TextField(
          controller: textController,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).primaryIconTheme.color,
                  fontSize: 16 * displayScaleFactor)
              : Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).primaryIconTheme.color,
                  fontSize: 16 * displayScaleFactor),
          minLines: minimumLines,
          maxLines: 24,
          textAlign: TextAlign.justify,
          cursorColor: Theme.of(context).primaryColor,
          autofocus: autofocus,
          onChanged: (_) =>
              disableHighlight != null ? disableHighlight!() : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: isHighlight
                ? Theme.of(context).errorColor.withOpacity(0.1)
                : Theme.of(context).primaryColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            hintText: hintText,
            hintStyle: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge!
                    .copyWith(fontSize: 16 * displayScaleFactor)
                : Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 16 * displayScaleFactor),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          keyboardType: inputType,
        ),
      ],
    );
  }
}
