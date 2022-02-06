import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_svg/flutter_svg.dart';

class PostObject {
  final List<String> imageUrls;
  final String title;
  final String location;
  final double price;
  final List<Activity> activities;
  final Details? details;
  final BriefDescription? briefDescription;
  final List<String>? policies;
  final List<String>? galleryUrls;

  PostObject({
    required this.imageUrls,
    required this.title,
    required this.location,
    required this.price,
    required this.activities,
    this.details,
    this.briefDescription,
    this.policies,
    this.galleryUrls,
  });
}

final Activity boating = Activity(
  image: SvgPicture.asset('assets/images/home_screen/sub/boating.svg'),
  label: 'ជិះទូក',
);

final Activity diving = Activity(
  image: SvgPicture.asset('assets/images/home_screen/sub/diving.svg'),
  label: 'មើលផ្កាថ្ម',
);

final Activity fishing = Activity(
  image: SvgPicture.asset('assets/images/home_screen/sub/fishing.svg'),
  label: 'ស្ទូចត្រី',
);

final Activity relaxing = Activity(
  image: SvgPicture.asset('assets/images/home_screen/sub/relaxing.svg'),
  label: 'លំហែកាយ',
);

final Activity swimming = Activity(
  image: SvgPicture.asset('assets/images/home_screen/sub/swimming.svg'),
  label: 'ហែលទឹក',
);

class Activity {
  final Widget image;
  final String label;

  Activity({
    required this.image,
    required this.label,
  });
}

class Details {
  final String textDetail;
  final String mapImageUrl;

  Details({
    required this.textDetail,
    required this.mapImageUrl,
  });
}

class BriefDescription {
  final double ratings;
  final int distance;
  final int temperature;
  final int views;

  BriefDescription({
    required this.ratings,
    required this.distance,
    required this.temperature,
    required this.views,
  });
}
