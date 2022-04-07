import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<void> addImage(
    void Function(String, {bool isRemoved}) callback,
  ) async {
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage();
      if (pickedImages != null)
        for (XFile pickedImage in pickedImages) callback(pickedImage.path);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
