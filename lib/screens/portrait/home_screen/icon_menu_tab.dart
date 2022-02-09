import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, kCardTileVPadding;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/card_tile_item.dart';

class IconMenuTab extends StatefulWidget {
  final int initIndex;
  const IconMenuTab({Key? key, required this.initIndex}) : super(key: key);
  @override
  _IconMenuTabState createState() => _IconMenuTabState();
}

class _IconMenuTabState extends State<IconMenuTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: modelIconMenus.length,
      initialIndex: widget.initIndex,
      child: Scaffold(
        appBar: AppBar(
          brightness: Theme.of(context).colorScheme.brightness,
          elevation: 0.7,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color,
              size: 18.0,
            ),
            hoverColor: Colors.transparent,
          ),
          title: Text(
            'តំបន់នីមួយៗ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              //TODO: Send user to search screen
              //     () => Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => SearchSubscreen()),
              // ),
              hoverColor: Colors.transparent,
              icon: Icon(
                CustomOutlinedIcons.search,
                size: 28.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(43.0),
            child: Column(
              children: [
                Divider(height: 0.0, thickness: 0.5),
                CustomTabBar(),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: _buildIconMenusList(vPadding: kCardTileVPadding),
        ),
      ),
    );
  }

  List<_BuildIconMenuList> _buildIconMenusList({required double vPadding}) {
    List<_BuildIconMenuList> tabBarListItems = [];

    for (int i = 0; i < modelIconMenus.length; i++) {
      tabBarListItems.add(_BuildIconMenuList(vPadding: vPadding));
    }
    return tabBarListItems;
  }
}

class _BuildIconMenuList extends StatefulWidget {
  final double vPadding;
  const _BuildIconMenuList({Key? key, required this.vPadding})
      : super(key: key);

  @override
  _BuildIconMenuListState createState() => _BuildIconMenuListState();
}

class _BuildIconMenuListState extends State<_BuildIconMenuList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();
  bool _isRefreshable = true;

  List<PostObject> postList = [];

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: kHPadding,
        right: kHPadding,
        top: kVPadding + 2.0,
        bottom: kVPadding + 6.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CardTileItem(
          placeObject: postList.elementAt(index),
          vPadding: widget.vPadding,
        );
      },
      itemCount: postList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: _isRefreshable,
      enablePullUp: true,
      child: _buildList(),
      physics: BouncingScrollPhysics(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      onRefresh: () async {
        assert(DefaultTabController.of(context) != null);
        postList = postTranslator(await _firestoreService
            .getIconMenuData(modelIconMenus
                .elementAt(DefaultTabController.of(context)!.index)
                .label)
            .then((snapshot) => snapshot.docs));
        if (mounted) setState(() => _isRefreshable = false);
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        assert(DefaultTabController.of(context) != null);
        postList = List.from(postList)
          ..addAll(postTranslator(await _firestoreService
              .getIconMenuData(modelIconMenus
                  .elementAt(DefaultTabController.of(context)!.index)
                  .label)
              .then((snapshot) => snapshot.docs)));
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  List<Tab> _buildTabs() {
    List<Tab> _tabItems = [];
    for (ModelIconMenu modelIconMenu in modelIconMenus)
      _tabItems.add(Tab(text: modelIconMenu.label));

    return _tabItems;
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(18.0),
      ),
      indicatorPadding: const EdgeInsets.symmetric(vertical: 6.0),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      labelColor: Colors.white,
      labelStyle: Theme.of(context).textTheme.button,
      unselectedLabelColor: Theme.of(context).textTheme.button!.color,
      unselectedLabelStyle: Theme.of(context).textTheme.button,
      tabs: _buildTabs(),
    );
  }
}
