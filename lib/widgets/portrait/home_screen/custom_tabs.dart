import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart'
    show kCardTileVPadding;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/card_tile_item.dart';

class CustomTabBar extends StatelessWidget {
  final TabController _tabController;

  const CustomTabBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(18.0),
      ),
      indicatorPadding: EdgeInsets.symmetric(vertical: 6.0),
      labelColor: Colors.white,
      labelStyle: Theme.of(context).textTheme.button,
      unselectedLabelColor: Theme.of(context).textTheme.button!.color,
      unselectedLabelStyle: Theme.of(context).textTheme.button,
      tabs: [
        Tab(text: 'កន្លែងថ្មី'),
        Tab(text: 'ព្រឹត្តិការណ៍ថ្មី'),
        Tab(text: 'ច្រើនទស្សនា'),
        Tab(text: 'ល្បីប្រចាំខែ'),
        Tab(text: 'ទាំងអស់'),
      ],
    );
  }
}

class CustomTabBarList extends StatefulWidget {
  final TabController tabController;
  final double vPadding;
  const CustomTabBarList(
      {Key? key,
      required this.tabController,
      this.vPadding = kCardTileVPadding})
      : super(key: key);

  @override
  _CustomTabBarListState createState() => _CustomTabBarListState();
}

class _CustomTabBarListState extends State<CustomTabBarList> {
  final FirestoreService _firestoreService = FirestoreService();

  List<String> tabs = [
    'កន្លែងថ្មី',
    'ព្រឹត្តិការណ៍ថ្មី',
    'ច្រើនទស្សនា',
    'ល្បីប្រចាំខែ',
    'ទាំងអស់',
  ];

  List<List<PostObject>> tabLists = [];
  void setTabBarData() => tabs.forEach((tab) async => tabLists.add(
      postTranslator(await _firestoreService
          .getTabBarData(tab)
          .then((snapshot) => snapshot.docs))));

  @override
  void initState() {
    super.initState();
    setTabBarData();
  }

  List<Column> _buildTabBarLists() {
    List<Column> _tabBarLists = [];
    for (List<PostObject> tabList in tabLists) {
      List<CardTileItem> _tabBarList = [];
      for (PostObject post in tabList)
        _tabBarList.add(
          CardTileItem(
            vPadding: kCardTileVPadding,
            placeObject: post,
          ),
        );

      _tabBarLists.add(Column(children: _tabBarList));
    }

    return _tabBarLists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 5 / 6.16 + kCardTileVPadding * 5,
      child: tabLists.length == 0
          ? Center(child: CircularProgressIndicator.adaptive())
          : TabBarView(
              controller: widget.tabController,
              children: _buildTabBarLists(),
            ),
    );
  }
}
