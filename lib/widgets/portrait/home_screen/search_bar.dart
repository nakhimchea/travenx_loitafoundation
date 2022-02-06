// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
// import 'package:travenx_loitafoundation/services/firestore_service.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //TODO: Push Screen when Search Button push to subscreen
        // final User? _currentUser = FirebaseAuth.instance.currentUser;
        // String _postId = DateTime.now().millisecondsSinceEpoch.toString();
        // if (_currentUser != null) {
        //   try {
        //     await FirestoreService()
        //         .getProfileData(_currentUser.uid)
        //         .then((DocumentSnapshot<Map<String, dynamic>>
        //                 documentSnapshot) async =>
        //             await FirestoreService().setPromotionData(_postId, {
        //               'clientId': _currentUser.uid,
        //               'clientDisplayName': documentSnapshot.get('displayName'),
        //               'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //               'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //               'imageUrls': [
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //               ],
        //               'title': 'ដើរលេងបន្ទាប់',
        //               'location': 'ខេត្តកំពត កម្ពុជា',
        //               'price': 25,
        //               'activities': [
        //                 'boating',
        //                 'swimming',
        //                 'relaxing',
        //                 'fishing',
        //                 'diving',
        //               ],
        //               'details': {
        //                 'mapImageUrl': 'assets/images/travenx.png',
        //                 'textDetail':
        //                     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //               },
        //               'briefDescription': {
        //                 'ratings': 4.5,
        //                 'distance': 60000,
        //                 'temperature': 36,
        //                 'views': 1236,
        //               },
        //               'policies': [
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //               ],
        //               'galleryUrls': [
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //               ],
        //             }))
        //         .catchError((e) {
        //       print('Cannot get user ID: $e');
        //     });
        //     await FirestoreService()
        //         .addPostId2Profile(_currentUser.uid, _postId)
        //         .catchError((e) {
        //       print('Cannot get user IDD: $e');
        //     });
        //   } catch (e) {
        //     print('Unknown Error: $e');
        //   }
        // }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(
              CustomOutlinedIcons.search,
              size: 26.0,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            Text(
              'ស្វែងរក',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
