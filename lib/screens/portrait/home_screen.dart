import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();

  List<PostObject> promotions = [];

  void assignPromotionData() async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> _promotions =
        await _firestoreService
            .getPromotionData()
            .then((snapshot) => snapshot.docs);

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

    // Data translation
    for (var promotion in _promotions) {
      if (promotion.get('imageUrls') != null)
        for (var imageUrl in promotion.get('imageUrls'))
          _imageUrls.add(imageUrl.toString());

      _title = promotion.get('title').toString();
      _location = promotion.get('location').toString();
      _price = promotion.get('price');

      if (promotion.get('activities') != null)
        for (var activity in promotion.get('activities')) {
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
        if (promotion.get('details') != null)
          _details = Details(
              textDetail: promotion.get('details')['textDetail'].toString(),
              mapImageUrl: promotion.get('details')['mapImageUrl'].toString());

        if (promotion.get('briefDescription') != null)
          _briefDescription = BriefDescription(
              ratings: promotion.get('briefDescription')['ratings'],
              distance: promotion.get('briefDescription')['distance'],
              temperature: promotion.get('briefDescription')['temperature'],
              views: promotion.get('briefDescription')['views']);

        if (promotion.get('policies') != null)
          for (var policy in promotion.get('policies'))
            _policies.add(policy.toString());

        if (promotion.get('galleryUrls') != null)
          for (var galleryUrl in promotion.get('galleryUrls'))
            _galleryUrls.add(galleryUrl.toString());
      } catch (e) {
        print('Data\'s unavailable: $e');
      }
      promotions.add(PostObject(
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
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    assignPromotionData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.7,
            shadowColor: Theme.of(context).disabledColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Travenx',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: false,
            floating: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: kHPadding),
                child: ChangeThemeButton(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SearchBar(),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 6.0,
              bottom: kVPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Promotions(promotions: promotions),
            ),
          ),
        ],
      ),
    );
  }
}
