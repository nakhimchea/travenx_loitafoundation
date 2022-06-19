import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, displayScaleFactor, selectedIndex;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/add_post.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/user_posts.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/change_language_button.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/profile_category.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/short_profile.dart';

class Profile extends StatefulWidget {
  final void Function() loggedInCallback;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() toggleNeedRefresh;
  const Profile({
    Key? key,
    required this.loggedInCallback,
    required this.displayName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.backgroundUrl,
    required this.cleanProfileCallback,
    required this.toggleNeedRefresh,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).colorScheme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
    return Scaffold(
      body: CustomScrollView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShortProfile(
                    displayName: widget.displayName,
                    phoneNumber: widget.phoneNumber,
                    profileUrl: widget.profileUrl,
                    backgroundUrl: widget.backgroundUrl,
                  ),
                  _AddPost(user: _user, widget: widget),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHPadding,
                      vertical: kVPadding / 2,
                    ),
                    child: ProfileCategory(
                      icon: Icon(
                        CustomOutlinedIcons.menu,
                        color: Theme.of(context).primaryColor,
                        size: 20.0 * displayScaleFactor,
                      ),
                      title: AppLocalizations.of(context)!.pfAddedPost,
                      trailing: [
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).iconTheme.color,
                          size: 14.0 * displayScaleFactor,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHPadding,
                      vertical: kVPadding / 2,
                    ),
                    child: Column(
                      children: [
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.user,
                            color: Theme.of(context).primaryColor,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfProfile,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.bookmark,
                            color: Theme.of(context).primaryColor,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfSaved,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.star,
                            color: Theme.of(context).primaryColor,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfReviewed,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.setting,
                            color: Theme.of(context).iconTheme.color,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfLanguages,
                          trailing: [
                            Text(
                              AppLocalizations.of(context)!.localeName == 'km'
                                  ? 'English/中文'
                                  : 'ភាសាខ្មែរ/中文',
                              textScaleFactor: displayScaleFactor,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => CustomLanguageDialog(
                              toggleNeedRefresh: widget.toggleNeedRefresh,
                            ),
                          ),
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.warning,
                            color: Theme.of(context).iconTheme.color,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfAboutUs,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.file,
                            color: Theme.of(context).iconTheme.color,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title:
                              AppLocalizations.of(context)!.pfTermsAndPolicies,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.help,
                            color: Theme.of(context).iconTheme.color,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfFAQ,
                          trailing: [
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).iconTheme.color,
                              size: 14.0 * displayScaleFactor,
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        ProfileCategory(
                          icon: Icon(
                            CustomFilledIcons.star,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfRateUs,
                          trailing: [],
                        ),
                        ProfileCategory(
                          icon: Icon(
                            CustomFilledIcons.share,
                            color: Theme.of(context).hintColor,
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfShare,
                          trailing: [],
                        ),
                        const SizedBox(height: 15.0),
                        ProfileCategory(
                          icon: Icon(
                            CustomOutlinedIcons.logout,
                            color: Color(0xFFC23616),
                            size: 20.0 * displayScaleFactor,
                          ),
                          title: AppLocalizations.of(context)!.pfLogOut,
                          textColor: Color(0xFFC23616),
                          trailing: [],
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              await FlutterSecureStorage()
                                  .delete(key: 'userId');
                              await FlutterSecureStorage()
                                  .delete(key: 'isAnonymous');
                              widget.cleanProfileCallback();
                              widget.loggedInCallback();
                              selectedIndex = 0;
                            } catch (_) {
                              print('Cannot Sign User out');
                            }
                          },
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          AppLocalizations.of(context)!.pfVersion,
                          textScaleFactor: displayScaleFactor,
                          style:
                              AppLocalizations.of(context)!.localeName == 'km'
                                  ? Theme.of(context).primaryTextTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
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

class _AddPost extends StatelessWidget {
  final User? user;
  final Profile widget;
  const _AddPost({
    Key? key,
    required this.user,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 5,
        vertical: kVPadding / 2,
      ),
      child: GestureDetector(
        onTap: () => user != null
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddPost()),
              )
            : widget.loggedInCallback(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                size: 20.0 * displayScaleFactor,
              ),
              const SizedBox(width: kHPadding),
              Text(
                AppLocalizations.of(context)!.pfAddPost,
                textScaleFactor: displayScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
