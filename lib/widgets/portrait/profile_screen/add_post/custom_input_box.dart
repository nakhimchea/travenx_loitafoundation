import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart'
    show textScaleFactor;

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
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 3),
        TextField(
          controller: textController,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).iconTheme.color,
              fontSize: 14 * textScaleFactor),
          minLines: minimumLines,
          maxLines: 24,
          textAlign: TextAlign.justify,
          cursorColor: Theme.of(context).primaryColor,
          cursorHeight: 14 * textScaleFactor,
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
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 14 * textScaleFactor),
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
