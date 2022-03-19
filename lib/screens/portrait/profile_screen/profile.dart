import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/user_posts.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/profile_category.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/short_profile.dart';

class Profile extends StatefulWidget {
  final void Function() loggedInCallback;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  const Profile({
    Key? key,
    required this.loggedInCallback,
    required this.displayName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.backgroundUrl,
    required this.cleanProfileCallback,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ShortProfile(
              displayName: widget.displayName,
              phoneNumber: widget.phoneNumber,
              profileUrl: widget.profileUrl,
              backgroundUrl: widget.backgroundUrl,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5,
              vertical: kVPadding / 2,
            ),
            sliver: SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => _user != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UserPosts()),
                      )
                    : widget.loggedInCallback(),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CustomOutlinedIcons.new_icon,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      SizedBox(width: kHPadding),
                      Text(
                        'បង្ហោះទីតាំង ឬអាជីវកម្ម',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding / 2,
            ),
            sliver: SliverToBoxAdapter(
              child: ProfileCategory(
                icon: Icon(
                  CustomOutlinedIcons.menu,
                  color: Theme.of(context).primaryColor,
                  size: 20.0,
                ),
                title: 'ទីតាំង ឬអាជីវកម្មបានបង្ហោះ',
                trailing: [
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: 14.0,
                  ),
                ],
                onTap: () => _user != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UserPosts()),
                      )
                    : widget.loggedInCallback(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding / 2,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.user,
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    ),
                    title: 'ប្រវត្តិរូប',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.bookmark,
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    ),
                    title: 'បានរក្សាទុក',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.star,
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    ),
                    title: 'បានវាយតម្លៃ',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.setting,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: 20.0,
                    ),
                    title: 'ភាសា',
                    trailing: [
                      Text(
                        'ភាសាខ្មែរ',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).primaryColor),
                        overflow:
                            kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.warning,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: 20.0,
                    ),
                    title: 'អំពីយើង',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.file,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: 20.0,
                    ),
                    title: 'លក្ខខណ្ឌ និងគោលការណ៍ផ្សេងៗ',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.help,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: 20.0,
                    ),
                    title: 'សំនួរ/ចម្លើយ',
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  ProfileCategory(
                    icon: Icon(
                      CustomFilledIcons.star,
                      color: Theme.of(context).highlightColor,
                      size: 20.0,
                    ),
                    title: 'វាយតម្លៃកម្មវិធី',
                    trailing: [],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomFilledIcons.share,
                      color: Theme.of(context).hintColor,
                      size: 20.0,
                    ),
                    title: 'ចែករំលែកកម្មវិធី',
                    trailing: [],
                  ),
                  SizedBox(height: 15.0),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.logout,
                      color: Color(0xFFC23616),
                      size: 20.0,
                    ),
                    title: 'ចាកចេញ',
                    textColor: Color(0xFFC23616),
                    trailing: [],
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        await FlutterSecureStorage().delete(key: 'userId');
                        await FlutterSecureStorage().delete(key: 'isAnonymous');
                        widget.cleanProfileCallback();
                        widget.loggedInCallback();
                      } catch (_) {
                        print('Cannot Sign User out');
                      }
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'កម្មវិធីជំនាន់ទី ១.០',
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
