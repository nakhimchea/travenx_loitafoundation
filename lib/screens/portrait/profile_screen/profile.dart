import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';
import 'package:travenx_loitafoundation/config/palette.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/data_holders/profile_data.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/profile_widget.dart';

class Profile extends StatefulWidget {
  final void Function() loggedInCallback;
  const Profile({
    Key? key,
    required this.loggedInCallback,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ShortProfile(userProfile: userProfile),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding,
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
                  SizedBox(height: 20.0),
                  ProfileCategory(
                    icon: Icon(
                      CustomOutlinedIcons.location,
                      color: Palette.tertiary,
                      size: 20.0,
                    ),
                    title: 'ចុះឈ្មោះទីតាំង ឬអាជីវកម្ម',
                    textColor: Palette.tertiary,
                    trailing: [
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: 14.0,
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
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
                        overflow: TextOverflow.ellipsis,
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
                  SizedBox(height: 20.0),
                  ProfileCategory(
                    icon: Icon(
                      CustomFilledIcons.star,
                      color: Palette.priceColor,
                      size: 20.0,
                    ),
                    title: 'វាយតម្លៃកម្មវិធី',
                    trailing: [],
                  ),
                  ProfileCategory(
                    icon: Icon(
                      CustomFilledIcons.share,
                      color: Palette.tertiary,
                      size: 20.0,
                    ),
                    title: 'ចែករំលែកកម្មវិធី',
                    trailing: [],
                  ),
                  SizedBox(height: 20.0),
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
                      await FirebaseAuth.instance.signOut();
                      widget.loggedInCallback();
                    },
                  ),
                  SizedBox(height: 20.0),
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
