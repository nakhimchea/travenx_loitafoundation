import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kVPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class PoliciesInputBox extends StatelessWidget {
  final String hintText;
  final bool autofocus;
  final int minimumLines;
  final List<TextEditingController> policyControllers;
  final void Function({bool isRemoved, int index}) policiesCallback;
  const PoliciesInputBox({
    Key? key,
    required this.hintText,
    this.autofocus = false,
    this.minimumLines = 1,
    required this.policyControllers,
    required this.policiesCallback,
  }) : super(key: key);

  List<Widget> _buildPolicies(BuildContext context) {
    return List.generate(
      policyControllers.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.only(top: kVPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${index + 1}.',
                textAlign: TextAlign.justify,
                textScaleFactor: displayScaleFactor,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 3),
              Expanded(
                child: TextField(
                  controller: policyControllers.elementAt(index),
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryIconTheme.color,
                          fontSize: 14 * displayScaleFactor)
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryIconTheme.color,
                          fontSize: 14 * displayScaleFactor),
                  minLines: minimumLines,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  cursorColor: Theme.of(context).primaryColor,
                  autofocus: autofocus,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    suffixIconConstraints: BoxConstraints.tightFor(width: 46),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        index + 1 < policyControllers.length
                            ? policiesCallback(isRemoved: true, index: index)
                            : policiesCallback();
                      },
                      child: Icon(
                        index + 1 < policyControllers.length
                            ? CustomOutlinedIcons.delete
                            : CustomOutlinedIcons.add,
                        color: index + 1 < policyControllers.length
                            ? Theme.of(context).errorColor.withOpacity(0.8)
                            : Theme.of(context).primaryColor.withOpacity(0.8),
                      ),
                    ),
                    hintText: hintText,
                    hintStyle: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14 * displayScaleFactor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14 * displayScaleFactor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildPolicies(context),
    );
  }
}
