import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/palette.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/widgets/wide/home_screen/profile_category.dart';
import 'package:travenx_loitafoundation/widgets/wide/home_screen/short_profile.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => CustomScrollView(
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
                horizontal: constraints.maxWidth / 300 > 1.6
                    ? 16
                    : constraints.maxWidth / 18.75,
                vertical: constraints.maxWidth / 300 > 1.6
                    ? 10
                    : constraints.maxWidth / 30,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.user,
                        color: Theme.of(context).primaryColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'ប្រវត្តិរូប',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.bookmark,
                        color: Theme.of(context).primaryColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'បានរក្សាទុក',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.star,
                        color: Theme.of(context).primaryColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'បានវាយតម្លៃ',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    SizedBox(
                        height: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.location,
                        color: Theme.of(context).hintColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'ចុះឈ្មោះទីតាំង ឬអាជីវកម្ម',
                      textColor: Theme.of(context).hintColor,
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    SizedBox(
                        height: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.setting,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'ភាសា',
                      trailing: [
                        Text(
                          'ភាសាខ្មែរ',
                          textScaleFactor: constraints.maxWidth / 300 > 1.6
                              ? 1.6
                              : constraints.maxWidth / 300,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.warning,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'អំពីយើង',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.file,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'លក្ខខណ្ឌ និងគោលការណ៍ផ្សេងៗ',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.help,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'សំនួរ/ចម្លើយ',
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: MediaQuery.of(context).size.height / 75,
                        )
                      ],
                    ),
                    SizedBox(
                        height: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23),
                    ProfileCategory(
                      icon: Icon(
                        CustomFilledIcons.star,
                        color: Palette.priceColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'វាយតម្លៃកម្មវិធី',
                      trailing: [],
                    ),
                    ProfileCategory(
                      icon: Icon(
                        CustomFilledIcons.share,
                        color: Theme.of(context).hintColor,
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'ចែករំលែកកម្មវិធី',
                      trailing: [],
                    ),
                    SizedBox(
                        height: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23),
                    ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.logout,
                        color: Color(0xFFC23616),
                        size: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23,
                      ),
                      title: 'ចាកចេញ',
                      textColor: Color(0xFFC23616),
                      trailing: [],
                      onTap: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          await FlutterSecureStorage().delete(key: 'userId');
                          await FlutterSecureStorage()
                              .delete(key: 'isAnonymous');
                          widget.cleanProfileCallback();
                          widget.loggedInCallback();
                        } catch (_) {
                          print('Cannot Sign User out');
                        }
                      },
                    ),
                    SizedBox(
                        height: constraints.maxWidth / 300 > 1.6
                            ? 22
                            : constraints.maxWidth / 23),
                    Text(
                      'កម្មវិធីជំនាន់ទី ១.០',
                      textScaleFactor: constraints.maxWidth / 300 > 1.6
                          ? 1.6
                          : constraints.maxWidth / 300,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
