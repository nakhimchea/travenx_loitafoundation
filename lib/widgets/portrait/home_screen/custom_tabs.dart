import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kCardTileVPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: kHPadding),
      indicatorPadding: const EdgeInsets.symmetric(vertical: 6.0),
      labelColor: Colors.white,
      labelStyle: AppLocalizations.of(context)!.localeName == 'km'
          ? Theme.of(context)
              .primaryTextTheme
              .bodyMedium!
              .copyWith(fontSize: 14 * displayScaleFactor)
          : Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14 * displayScaleFactor),
      unselectedLabelColor: Theme.of(context).iconTheme.color,
      unselectedLabelStyle: AppLocalizations.of(context)!.localeName == 'km'
          ? Theme.of(context)
              .primaryTextTheme
              .bodyMedium!
              .copyWith(fontSize: 14 * displayScaleFactor)
          : Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14 * displayScaleFactor),
      tabs: [
        Tab(text: AppLocalizations.of(context)!.tbNewPlacesLabel),
        Tab(text: AppLocalizations.of(context)!.tbNewEventsLabel),
        Tab(text: AppLocalizations.of(context)!.tbMostVisitsLabel),
        Tab(text: AppLocalizations.of(context)!.tbMostFamousLabel),
        Tab(text: AppLocalizations.of(context)!.tbAllPlacesLabel),
      ],
    );
  }
}

class CustomTabBarList extends StatefulWidget {
  final BuildContext context;
  final TabController tabController;
  final double vPadding;
  final bool needRefresh;
  final void Function() toggleNeedRefresh;
  const CustomTabBarList({
    Key? key,
    required this.context,
    required this.tabController,
    this.vPadding = kCardTileVPadding,
    required this.needRefresh,
    required this.toggleNeedRefresh,
  }) : super(key: key);

  @override
  _CustomTabBarListState createState() => _CustomTabBarListState();
}

class _CustomTabBarListState extends State<CustomTabBarList> {
  final FirestoreService _firestoreService = FirestoreService();

  List<List<PostObject>> tabLists = [];

  void setTabBarData() async {
    final List<String> _tabs = [
      AppLocalizations.of(widget.context)!.tbNewPlacesLabel,
      AppLocalizations.of(widget.context)!.tbNewEventsLabel,
      AppLocalizations.of(widget.context)!.tbMostVisitsLabel,
      AppLocalizations.of(widget.context)!.tbMostFamousLabel,
      AppLocalizations.of(widget.context)!.tbAllPlacesLabel,
    ];
    for (String tab in _tabs)
      tabLists.add(postTranslator(
          widget.context,
          await _firestoreService
              .getTabBarData(tab)
              .then((snapshot) => snapshot.docs)));
  }

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
            post: post,
          ),
        );

      _tabBarLists.add(Column(children: _tabBarList));
    }

    return _tabBarLists;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.needRefresh) {
      tabLists = [];
      setTabBarData();
      widget.toggleNeedRefresh();
    }

    return Container(
      height:
          MediaQuery.of(context).size.height * 5 / 6.16 + kCardTileVPadding * 5,
      child: tabLists.length < 5
          ? Loading(color: Theme.of(context).disabledColor)
          : TabBarView(
              controller: widget.tabController,
              children: _buildTabBarLists(),
            ),
    );
  }
}
