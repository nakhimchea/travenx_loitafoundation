import 'dart:io' show File;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

class StorageService {
  Future<List<String>> uploadPostImages({
    required String ownerId,
    required String postId,
    required List<XFile> imagesFile,
  }) async {
    List<String> urls = [];
    try {
      for (int index = 0; index < imagesFile.length; index++) {
        if (kIsWeb) {
          final String destination = 'posts/$postId/$ownerId/$index.jpg';
          Reference reference = FirebaseStorage.instance.ref(destination);
          await reference
              .putData(
            await imagesFile.elementAt(index).readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
              .whenComplete(() async {
            await reference.getDownloadURL().then((url) => urls.add(url));
          });
        } else {
          final String extension =
              imagesFile.elementAt(index).path.split('/').last.split('.').last;
          final String destination = 'posts/$postId/$ownerId/$index.$extension';
          final snapshot = await FirebaseStorage.instance
              .ref(destination)
              .putFile(File(imagesFile.elementAt(index).path))
              .whenComplete(() {});
          urls.add(await snapshot.ref.getDownloadURL());
        }
      }
    } on FirebaseException catch (e) {
      print('Firebase Errors: $e');
    }
    return urls;
  }

  Future<List<String>> uploadGalleryImages({
    required String ownerId,
    required String postId,
    required List<XFile> imagesFile,
  }) async {
    List<String> urls = [];
    try {
      for (int index = 0; index < imagesFile.length; index++) {
        if (kIsWeb) {
          final String destination = 'gallery/$postId/$ownerId/$index.jpg';
          Reference reference = FirebaseStorage.instance.ref(destination);
          await reference
              .putData(
            await imagesFile.elementAt(index).readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
              .whenComplete(() async {
            await reference.getDownloadURL().then((url) => urls.add(url));
          });
        } else {
          final String extension =
              imagesFile.elementAt(index).path.split('/').last.split('.').last;
          final String destination =
              'gallery/$postId/$ownerId/$index.$extension';
          final snapshot = await FirebaseStorage.instance
              .ref(destination)
              .putFile(File(imagesFile.elementAt(index).path))
              .whenComplete(() {});
          urls.add(await snapshot.ref.getDownloadURL());
        }
      }
    } on FirebaseException catch (e) {
      print('Firebase Errors: $e');
    }
    return urls;
  }
}
