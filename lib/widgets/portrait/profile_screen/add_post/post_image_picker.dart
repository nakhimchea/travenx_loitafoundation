import 'dart:io' show Platform, File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/services/image_picker_service.dart';

class PostImagePicker extends StatelessWidget {
  final List<String> imagesPath;
  final void Function(String filePath, {bool isRemoved}) imagePickerCallback;
  const PostImagePicker({
    Key? key,
    required this.imagesPath,
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
      imagesPath.length + 1,
      (index) {
        if (index == imagesPath.length)
          return GestureDetector(
            onTap: () async =>
                await ImagePickerService().addImage(imagePickerCallback),
            child: Container(
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
            ),
          );
        else {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(1.0),
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: kIsWeb
                      ? Image.network(
                          imagesPath.elementAt(index),
                          fit: BoxFit.cover,
                        )
                      : Platform.isIOS
                          ? Image.asset(
                              imagesPath.elementAt(index),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagesPath.elementAt(index)),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: GestureDetector(
                  onTap: () => imagePickerCallback(
                    imagesPath.elementAt(index),
                    isRemoved: true,
                  ),
                  child: Container(
                    height:
                        (MediaQuery.of(context).size.width - (4 * kHPadding)) /
                            18,
                    width:
                        (MediaQuery.of(context).size.width - (4 * kHPadding)) /
                            18,
                    decoration: BoxDecoration(
                      color: Theme.of(context).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Icon(
                      CustomOutlinedIcons.delete,
                      size: (MediaQuery.of(context).size.width -
                              (4 * kHPadding)) /
                          18,
                      color: Theme.of(context).errorColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
