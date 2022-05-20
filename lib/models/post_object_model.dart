import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    required this.activities,
    this.details,
    this.policies,
    required this.postId,
  });
}

Activity boating(BuildContext context) => Activity(
      image: SvgPicture.asset('assets/images/home_screen/sub/boating.svg'),
      label: AppLocalizations.of(context)!.pdActivityBoating,
    );

Activity diving(BuildContext context) => Activity(
      image: SvgPicture.asset('assets/images/home_screen/sub/diving.svg'),
      label: AppLocalizations.of(context)!.pdActivityDiving,
    );

Activity fishing(BuildContext context) => Activity(
      image: SvgPicture.asset('assets/images/home_screen/sub/fishing.svg'),
      label: AppLocalizations.of(context)!.pdActivityFishing,
    );

Activity relaxing(BuildContext context) => Activity(
      image: SvgPicture.asset('assets/images/home_screen/sub/relaxing.svg'),
      label: AppLocalizations.of(context)!.pdActivityRelaxing,
    );

Activity swimming(BuildContext context) => Activity(
      image: SvgPicture.asset('assets/images/home_screen/sub/swimming.svg'),
      label: AppLocalizations.of(context)!.pdActivitySwimming,
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
