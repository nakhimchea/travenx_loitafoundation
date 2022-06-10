import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, profilePictureDiameter, displayScaleFactor;
import 'package:travenx_loitafoundation/helpers/profile_clipper.dart';
import 'package:travenx_loitafoundation/models/profile_object_model.dart';

class ShortProfile extends StatelessWidget {
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;

  const ShortProfile(
      {Key? key,
      required this.displayName,
      required this.phoneNumber,
      required this.profileUrl,
      required this.backgroundUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileObject _anonymous = ProfileObject();

    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipPath(
                clipper: ProfileClipper(),
                child: backgroundUrl == ''
                    ? Image.asset(
                        _anonymous.imageBackgroundUrl,
                        height:
                            constraints.maxWidth * 9 / 16 * displayScaleFactor,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : backgroundUrl.split('/').first == 'assets'
                        ? Image.asset(
                            backgroundUrl,
                            height: constraints.maxWidth *
                                9 /
                                16 *
                                displayScaleFactor,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            height: constraints.maxWidth *
                                9 /
                                16 *
                                displayScaleFactor,
                            width: double.infinity,
                            imageUrl: backgroundUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/profile_screen/dummy_background.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/profile_screen/dummy_background.png',
                              fit: BoxFit.cover,
                            ),
                          ),
              ),
              Positioned(
                bottom: 0.0,
                child: ClipOval(
                  child: profileUrl == ''
                      ? Image.asset(
                          _anonymous.imageProfileUrl,
                          height: profilePictureDiameter * displayScaleFactor,
                          width: profilePictureDiameter * displayScaleFactor,
                          fit: BoxFit.contain,
                        )
                      : profileUrl.split('/').first == 'assets'
                          ? Image.asset(
                              profileUrl,
                              height:
                                  profilePictureDiameter * displayScaleFactor,
                              width:
                                  profilePictureDiameter * displayScaleFactor,
                              fit: BoxFit.contain,
                            )
                          : CachedNetworkImage(
                              height:
                                  profilePictureDiameter * displayScaleFactor,
                              width:
                                  profilePictureDiameter * displayScaleFactor,
                              imageUrl: profileUrl,
                              fit: BoxFit.contain,
                              placeholder: (context, _) => ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Image.asset(
                                  'assets/images/profile_screen/dummy_profile.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              errorWidget: (context, _, __) => Image.asset(
                                'assets/images/profile_screen/dummy_profile.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kHPadding,
            ),
            child: Column(
              children: [
                Text(
                  '${displayName != '' ? displayName : _anonymous.displayName}',
                  textScaleFactor: displayScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.displayMedium
                      : Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 5.0),
                Text(
                  phoneNumber != '' ? phoneNumber : _anonymous.phoneNumber,
                  textScaleFactor: displayScaleFactor,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
