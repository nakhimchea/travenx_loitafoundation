import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart'
    show textScaleFactor;

class CustomInputBox extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType inputType;
  final bool autofocus;
  final void Function(String) textCallback;
  const CustomInputBox({
    Key? key,
    required this.label,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.autofocus = false,
    required this.textCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String string = '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.justify,
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.button,
        ),
        const SizedBox(height: 3),
        TextField(
          style: Theme.of(context).textTheme.button!.copyWith(
              color: Theme.of(context).iconTheme.color,
              fontSize: 14 * textScaleFactor),
          cursorColor: Theme.of(context).primaryColor,
          cursorHeight: 14 * textScaleFactor,
          autofocus: autofocus,
          onChanged: (newString) {
            string = newString != '' ? newString : '0';
            textCallback(string);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
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
