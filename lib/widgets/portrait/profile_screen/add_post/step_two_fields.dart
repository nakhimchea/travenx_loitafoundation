import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/custom_input_box.dart';

class StepTwoFields extends StatelessWidget {
  final void Function(String) titleCallback;
  final void Function(String) priceCallback;
  const StepTwoFields({
    Key? key,
    required this.titleCallback,
    required this.priceCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ព័ត៌មានចាំបាច់',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            label: 'ចំណងជើង',
            hintText: 'ហាងកាហ្វេ និងនំខេក',
            autofocus: true,
            textCallback: titleCallback,
          ),
          const SizedBox(height: kHPadding),
          CustomInputBox(
            label: 'តម្លៃ (\$)',
            hintText: '\$0.00 (Free ឬចូលដោយសេរី)',
            textCallback: priceCallback,
            inputType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
    );
  }
}
