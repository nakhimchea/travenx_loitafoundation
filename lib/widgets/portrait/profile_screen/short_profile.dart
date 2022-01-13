import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/helpers/profile_clipper.dart';
import 'package:travenx_loitafoundation/models/profile_object_model.dart';

class ShortProfile extends StatelessWidget {
  final ProfileObject userProfile;

  const ShortProfile({Key? key, required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    height: constraints.maxWidth * 9 / 16,
                    width: double.infinity,
                    image: AssetImage(userProfile.imageBackgroundUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: ClipOval(
                  child: Image(
                    height: 100.0,
                    width: 100.0,
                    image: AssetImage(userProfile.imageProfileUrl),
                    fit: BoxFit.contain,
                  ),
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
                  '${userProfile.firstName} ${userProfile.lastName}',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5.0),
                Text(
                  '+855 ${userProfile.phoneNumber[0] == '0' ? userProfile.phoneNumber.substring(1) : userProfile.phoneNumber}',
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
