import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

List<PostObject> postTranslator(
    BuildContext context, List<DocumentSnapshot<Map<String, dynamic>>> posts) {
  List<PostObject> _postObjects = [];

  for (var post in posts) {
    String _clientId = '';
    String _clientDisplayName = '';
    String _clientPhoneNumber = '';
    String _clientProfileUrl = '';
    List<String> _imageUrls = [];
    String _title = '';
    String _state = '';
    String _country = '';
    String _positionCoordination = '';
    double _price = 0;
    String? _openHours;
    String? _announcement;
    List<Activity> _activities = [];
    Details? _details;
    List<String>? _policies = [];
    String _postId = '';

    _clientId = post.get('clientId').toString();
    _clientDisplayName = post.get('clientDisplayName').toString();
    _clientPhoneNumber = post.get('clientPhoneNumber').toString();
    _clientProfileUrl = post.get('clientProfileUrl').toString();

    if (post.get('imageUrls') != null)
      for (var imageUrl in post.get('imageUrls'))
        _imageUrls.add(imageUrl.toString());

    _title = post.get('title').toString();
    _state = post.get('state').toString();
    _country = post.get('country').toString();
    _positionCoordination = post.get('positionCoordination').toString();
    _price = double.parse(post.get('price').toString());

    try {
      if (post.get('openHours') != null)
        _openHours = post.get('openHours').toString();

      if (post.get('announcement') != null)
        _announcement = post.get('announcement').toString();
    } catch (e) {
      print('Data\'s unavailable: $e');
    }

    if (post.get('activities') !=
        null) //TODO: Activity add in English than Khmer
      for (var activity in post.get('activities')) {
        switch (activity.toString()) {
          case 'ជិះទូក':
            _activities.add(boating(context));
            break;
          case 'មើលផ្កាថ្ម':
            _activities.add(diving(context));
            break;
          case 'ស្ទូចត្រី':
            _activities.add(fishing(context));
            break;
          case 'លំហែកាយ':
            _activities.add(relaxing(context));
            break;
          case 'ហែលទឹក':
            _activities.add(swimming(context));
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

      if (post.get('policies') != null)
        for (var policy in post.get('policies'))
          _policies.add(policy.toString());
    } catch (e) {
      print('Data\'s unavailable: $e');
    }
    _postId = post.get('postId').toString();

    _postObjects.add(PostObject(
        clientId: _clientId,
        clientDisplayName: _clientDisplayName,
        clientPhoneNumber: _clientPhoneNumber,
        clientProfileUrl: _clientProfileUrl,
        imageUrls: _imageUrls,
        title: _title,
        state: _state,
        country: _country,
        positionCoordination: _positionCoordination,
        price: _price,
        openHours: _openHours,
        announcement: _announcement,
        activities: _activities,
        details: _details,
        policies: _policies,
        postId: _postId));
  }

  return _postObjects;
}
