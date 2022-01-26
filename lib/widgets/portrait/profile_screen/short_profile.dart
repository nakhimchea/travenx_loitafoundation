import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
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
                    ? Image(
                        height: constraints.maxWidth * 9 / 16,
                        width: double.infinity,
                        image: AssetImage(_anonymous.imageBackgroundUrl),
                        fit: BoxFit.cover)
                    : backgroundUrl.split('/').first == 'assets'
                        ? Image(
                            height: constraints.maxWidth * 9 / 16,
                            width: double.infinity,
                            image: AssetImage(backgroundUrl),
                            fit: BoxFit.cover)
                        : CachedNetworkImage(
                            height: constraints.maxWidth * 9 / 16,
                            width: double.infinity,
                            imageUrl: backgroundUrl,
                            placeholder: (context, _) => Image(
                                height: constraints.maxWidth * 9 / 16,
                                width: double.infinity,
                                image: AssetImage(
                                    'assets/images/profile_screen/dummy_background.png'),
                                fit: BoxFit.cover),
                            errorWidget: (context, _, __) => Container(
                                height: constraints.maxWidth * 9 / 16,
                                width: double.infinity,
                                child: Center(
                                    child: Text('Unable to Load Images'))),
                            fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0.0,
                child: ClipOval(
                  child: profileUrl == ''
                      ? Image(
                          height: profilePictureDiameter,
                          width: profilePictureDiameter,
                          image: AssetImage(_anonymous.imageProfileUrl),
                          fit: BoxFit.contain)
                      : profileUrl.split('/').first == 'assets'
                          ? Image(
                              height: profilePictureDiameter,
                              width: profilePictureDiameter,
                              image: AssetImage(profileUrl),
                              fit: BoxFit.contain)
                          : CachedNetworkImage(
                              height: profilePictureDiameter,
                              width: profilePictureDiameter,
                              imageUrl: profileUrl,
                              placeholder: (context, _) => Image(
                                  height: profilePictureDiameter,
                                  width: profilePictureDiameter,
                                  image: AssetImage(
                                      'assets/images/profile_screen/dummy_profile.png'),
                                  fit: BoxFit.contain),
                              errorWidget: (context, _, __) => Container(
                                  height: profilePictureDiameter,
                                  width: profilePictureDiameter,
                                  child: Center(
                                      child: Text('Unable to Load Images'))),
                              fit: BoxFit.contain),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kHPadding,
            ),
            child: Column(
              children: [
                Text(
                  '${displayName != '' ? displayName : _anonymous.displayName}',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5.0),
                Text(
                  phoneNumber != '' ? phoneNumber : _anonymous.phoneNumber,
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
