import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class PostImagePicker extends StatelessWidget {
  final List<File> images;
  final void Function(File, {bool isRemoved}) imagePickerCallback;
  const PostImagePicker({
    Key? key,
    required this.images,
    required this.imagePickerCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _spacing = 10.0;
    double _imageSize =
        (MediaQuery.of(context).size.width - (4 * kHPadding) - 3 * _spacing) /
            4;
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
            'រូបភាពទាក់ទាញ (រូបដំបូងនឹងត្រូវបានដាក់បង្ហាញជាងគេទៅអតិថិជន)',
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.button,
          ),
          const SizedBox(height: kHPadding),
          Wrap(
            spacing: _spacing,
            runSpacing: _spacing,
            children: _buildPicker(context, _imageSize),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPicker(BuildContext context, double imageSize) {
    return List.generate(
      8,
      (index) {
        return Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(
            CustomOutlinedIcons.add,
            size: imageSize / 2,
            color: Theme.of(context).disabledColor,
          ),
        );
      },
    );
  }
}
