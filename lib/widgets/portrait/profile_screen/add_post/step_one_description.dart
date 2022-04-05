import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;

class StepOneDescription extends StatelessWidget {
  const StepOneDescription({
    Key? key,
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
            'សេវាប្រាប់ទិសតំបន់ទីតាំង ឬអាជីវកម្ម',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: kHPadding),
          Text(
            '    លោកអ្នកត្រូវតែនៅទីតាំង ឬអាជីវកម្ម ដើម្បីបង្ហោះផ្សាយពាណិជ្ជកម្មនេះបាន។'
            ' លោកអ្នកត្រូវទទួលស្គាល់ថាពួកយើងចាប់យកទីតាំងដែលលោកអ្នកកំពុងស្ថិតនៅ'
            ' ដើម្បីចាប់យក ព័ត៌មាន អាកាសធាតុ ព្យាករណ៍ និងពេលវេលាថ្ងៃរះ និងលិចនៅទីតាំងរបស់លោកអ្នក។'
            ' ដាច់ខាតលោកអ្នកត្រូវតែបើកសេវាប្រាប់ទិសតំបន់ដើម្បីបន្ត។',
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: kVPadding),
        ],
      ),
    );
  }
}
