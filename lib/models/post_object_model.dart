import 'package:flutter/widgets.dart' show Widget;

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
