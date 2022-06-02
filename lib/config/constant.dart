import 'package:flutter/material.dart' show FontWeight, TextStyle;

const double kHPadding = 16.0;
const double kVPadding = 10.0;

const double kCardTileVPadding = 8.0;

const double iconSize = 36.0;
const double briefIconSize = 32.0;

const double descriptionIconSize = 14.0;
const double detailIconSize = 16.0;

const double profilePictureDiameter = 100.0;

//Add font color : font family
const TextStyle kPTextStyle = const TextStyle(fontFamily: 'Sowannaphum');
TextStyle kDisplayPTextStyle = kPTextStyle.copyWith(
  fontWeight: FontWeight.w900,
);
TextStyle kTitlePTextStyle = kPTextStyle.copyWith(
  fontWeight: FontWeight.w800,
);
TextStyle kHeadlinePTextStyle = kPTextStyle.copyWith(
  fontWeight: FontWeight.w700,
);
TextStyle kLabelPTextStyle = kPTextStyle.copyWith(
  fontWeight: FontWeight.w500,
);
TextStyle kBodyPTextStyle = kPTextStyle.copyWith(
  fontWeight: FontWeight.w400,
);

//Add font color : font family
const TextStyle kTextStyle = const TextStyle(fontFamily: 'SanFrancisco');
TextStyle kDisplayTextStyle = kTextStyle.copyWith(
  fontWeight: FontWeight.w900,
);
TextStyle kTitleTextStyle = kTextStyle.copyWith(
  fontWeight: FontWeight.w800,
);
TextStyle kHeadlineTextStyle = kTextStyle.copyWith(
  fontWeight: FontWeight.w700,
);
TextStyle kLabelTextStyle = kTextStyle.copyWith(
  fontWeight: FontWeight.w500,
);
TextStyle kBodyTextStyle = kTextStyle.copyWith(
  fontWeight: FontWeight.w400,
);
