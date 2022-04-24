import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

class StepOneCheckedBox extends StatelessWidget {
  final bool isAgreementHighlight;
  final bool isChecked;
  final void Function() isCheckedCallback;
  const StepOneCheckedBox({
    Key? key,
    required this.isAgreementHighlight,
    required this.isChecked,
    required this.isCheckedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kHPadding,
        right: kHPadding,
        top: 2 * kHPadding,
        bottom: kHPadding,
      ),
      decoration: BoxDecoration(
        color: isAgreementHighlight
            ? Theme.of(context).highlightColor.withOpacity(0.1)
            : Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: isCheckedCallback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              !isChecked
                  ? Icons.check_box_outline_blank
                  : Icons.check_box_outlined,
              color: !isChecked
                  ? Theme.of(context).primaryIconTheme.color
                  : Theme.of(context).primaryColor,
              size: 16.0 * textScaleFactor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'យល់ព្រមបើកសេវាប្រាប់ទិសតំបន់ និង ទទួលស្គាល់ថាលោកអ្នកបាននៅទីតាំង ឬអាជីវកម្មផ្ទាល់។',
                textAlign: TextAlign.justify,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: isChecked ? Theme.of(context).primaryColor : null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
