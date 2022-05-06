import 'package:flutter/widgets.dart' show Widget;
import 'package:flutter_svg/flutter_svg.dart';

class PostObject {
  final String clientId;
  final String clientDisplayName;
  final String clientPhoneNumber;
  final String clientProfileUrl;
  final List<String> imageUrls;
  final String title;
  final String state;
  final String country;
  final String positionCoordination;
  final double price;
  final String? openHours;
  final String? announcement;
  final double ratings;
  final List<Activity> activities;
  final Details? details;
  final List<String>? policies;
  final String postId;

  PostObject({
    required this.clientId,
    required this.clientDisplayName,
    required this.clientPhoneNumber,
    required this.clientProfileUrl,
    required this.imageUrls,
    required this.title,
    required this.state,
    required this.country,
    required this.positionCoordination,
    required this.price,
    this.openHours,
    this.announcement,
    required this.ratings,
    required this.activities,
    this.details,
    this.policies,
    required this.postId,
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

class Gallery {
  final String userId;
  final String userProfileUrl;
  final String userDisplayName;
  final String dateTime;
  final String imageUrl;
  final int likes;
  final int dislikes;

  Gallery({
    required this.userId,
    required this.userProfileUrl,
    required this.userDisplayName,
    required this.dateTime,
    required this.imageUrl,
    required this.likes,
    required this.dislikes,
  });
}

class Review {
  final String userId;
  final String userProfileUrl;
  final String userDisplayName;
  final int rating;
  final String dateTime;
  final String? description;
  final int likes;
  final int dislikes;

  Review({
    required this.userId,
    required this.userProfileUrl,
    required this.userDisplayName,
    required this.rating,
    required this.dateTime,
    this.description,
    required this.likes,
    required this.dislikes,
  });
}
