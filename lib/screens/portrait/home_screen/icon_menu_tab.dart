import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kVPadding, textScaleFactor, kCardTileVPadding;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
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
      length: modelIconMenus(context).length,
      initialIndex: widget.initIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.7,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color,
              size: 18.0,
            ),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          title: Text(
            AppLocalizations.of(context)!.icAppBar,
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
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
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
                const Divider(height: 0.0, thickness: 0.5),
                _CustomTabBar(),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _buildIconMenusList(vPadding: kCardTileVPadding),
        ),
      ),
    );
  }

  List<_BuildIconMenuList> _buildIconMenusList({required double vPadding}) {
    List<_BuildIconMenuList> tabBarListItems = [];

    for (int i = 0; i < modelIconMenus(context).length; i++) {
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
  bool _isLoadable = true;

  List<PostObject> postList = [];
  DocumentSnapshot? _lastDoc;

  Widget _buildList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: kVPadding + 2.0,
        bottom: kVPadding + 6.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CardTileItem(
          post: postList.elementAt(index),
          vPadding: widget.vPadding,
        );
      },
      itemCount: postList.length,
    );
  }

  Widget _loadingBuilder(BuildContext context, LoadStatus? mode) {
    Widget _footer;

    if (mode == LoadStatus.idle)
      _footer = Center(
        child: Icon(
          Icons.keyboard_arrow_up_outlined,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.loading)
      _footer = Center(
        child: SpinKitFadingCircle(
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.failed)
      _footer = Center(
        child: Icon(
          Icons.error_outline_outlined,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.canLoading)
      _footer = Center(
        child: SpinKitFadingCircle(
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else
      _footer = Center(
        child: Icon(
          Icons.info_outline,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );

    return _footer;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      physics: const BouncingScrollPhysics(),
      enablePullDown: _isRefreshable,
      enablePullUp: _isLoadable,
      child: _buildList(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: _loadingBuilder,
      ),
      onRefresh: () async {
        assert(DefaultTabController.of(context) != null);
        postList = postTranslator(await _firestoreService
            .getIconMenuData(
                modelIconMenus(context)
                    .elementAt(DefaultTabController.of(context)!.index)
                    .label,
                _lastDoc)
            .then((snapshot) {
          setState(() => snapshot.docs.isNotEmpty
              ? _lastDoc = snapshot.docs.last
              : _isLoadable = false);
          return snapshot.docs;
        }));
        if (mounted) setState(() => _isRefreshable = false);
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        assert(DefaultTabController.of(context) != null);
        postList = List.from(postList)
          ..addAll(postTranslator(await _firestoreService
              .getIconMenuData(
                  modelIconMenus(context)
                      .elementAt(DefaultTabController.of(context)!.index)
                      .label,
                  _lastDoc)
              .then((snapshot) {
            setState(() => snapshot.docs.isNotEmpty
                ? _lastDoc = snapshot.docs.last
                : _isLoadable = false);
            return snapshot.docs;
          })));
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  const _CustomTabBar({Key? key}) : super(key: key);

  List<Tab> _buildTabs(BuildContext context) {
    List<Tab> _tabItems = [];
    for (ModelIconMenu modelIconMenu in modelIconMenus(context))
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
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      labelColor: Colors.white,
      labelStyle: Theme.of(context).textTheme.button,
      unselectedLabelColor: Theme.of(context).textTheme.button!.color,
      unselectedLabelStyle: Theme.of(context).textTheme.button,
      tabs: _buildTabs(context),
    );
  }
}
