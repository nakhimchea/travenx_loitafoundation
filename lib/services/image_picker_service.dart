import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<void> addImage(
    void Function(XFile, {bool? isRemoved}) callback,
  ) async {
    try {
      final List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages != null)
        for (XFile pickedImage in pickedImages) callback(pickedImage);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
