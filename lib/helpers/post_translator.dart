import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';

List<PostObject> postTranslator(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> posts) {
  List<PostObject> _postObjects = [];

  List<String> _imageUrls = [];
  String _title = '';
  String _location = '';
  double _price = 0;
  List<Activity> _activities = [];
  Details? _details = Details(textDetail: '', mapImageUrl: '');
  BriefDescription? _briefDescription =
      BriefDescription(ratings: 5, distance: 500, temperature: 32, views: 0);
  List<String>? _policies = [];
  List<String>? _galleryUrls = [];

  for (var post in posts) {
    if (post.get('imageUrls') != null)
      for (var imageUrl in post.get('imageUrls'))
        _imageUrls.add(imageUrl.toString());

    _title = post.get('title').toString();
    _location = post.get('location').toString();
    _price = post.get('price');

    if (post.get('activities') != null)
      for (var activity in post.get('activities')) {
        switch (activity.toString()) {
          case 'boating':
            _activities.add(boating);
            break;
          case 'diving':
            _activities.add(diving);
            break;
          case 'fishing':
            _activities.add(fishing);
            break;
          case 'relaxing':
            _activities.add(relaxing);
            break;
          case 'swimming':
            _activities.add(swimming);
            break;
          default:
            break;
        }
      }

    try {
      if (post.get('details') != null)
        _details = Details(
            textDetail: post.get('details')['textDetail'].toString(),
            mapImageUrl: post.get('details')['mapImageUrl'].toString());

      if (post.get('briefDescription') != null)
        _briefDescription = BriefDescription(
            ratings: post.get('briefDescription')['ratings'],
            distance: post.get('briefDescription')['distance'],
            temperature: post.get('briefDescription')['temperature'],
            views: post.get('briefDescription')['views']);

      if (post.get('policies') != null)
        for (var policy in post.get('policies'))
          _policies.add(policy.toString());

      if (post.get('galleryUrls') != null)
        for (var galleryUrl in post.get('galleryUrls'))
          _galleryUrls.add(galleryUrl.toString());
    } catch (e) {
      print('Data\'s unavailable: $e');
    }
    _postObjects.add(PostObject(
        imageUrls: _imageUrls,
        title: _title,
        location: _location,
        price: _price,
        activities: _activities,
        details: _details,
        briefDescription: _briefDescription,
        policies: _policies,
        galleryUrls: _galleryUrls));
  }

  return _postObjects;
}
