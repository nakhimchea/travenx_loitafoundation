import 'dart:async' show StreamSubscription;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  late TabController _tabController;
  late StreamSubscription subscription;
  bool _hasInternet = true;

  bool _needRefresh = false;
  void _toggleNeedRefresh() => _needRefresh = !_needRefresh;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb)
      subscription = InternetConnectionChecker().onStatusChange.listen(
          (status) => setState(() =>
              _hasInternet = status == InternetConnectionStatus.connected));
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: SmartRefresher(
          controller: _refreshController,
          physics: BouncingScrollPhysics(),
          header: ClassicHeader(
            refreshingText: 'កំពុងទាញយកទិន្នន័យ',
            failedText: 'ទាញយកទិន្នន័យបរាជ័យ',
            completeText: 'ទាញយកទិន្នន័យរួចរាល់',
            idleText: 'ទាញចុះក្រោមទៀត',
            releaseText: 'កំពុងទាញយកទិន្នន័យ',
          ),
          onRefresh: () {
            _needRefresh = true;
            if (mounted) setState(() {});
            _refreshController.refreshCompleted();
          },
          onLoading: null,
          child: CustomScrollView(
            primary: false,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Visibility(
                  visible: !_hasInternet,
                  child: NetworkRequestFailed(),
                ),
              ),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBar(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding,
                          vertical: kVPadding + 6.0,
                        ),
                        child: IconsMenu(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 6.0,
                          bottom: kVPadding,
                        ),
                        child: Promotions(
                          needRefresh: _needRefresh,
                          callback: _toggleNeedRefresh,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding,
                          vertical: kVPadding,
                        ),
                        child: Provinces(),
                      ),
                      Nearbys(),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentHeader(
                  tabBar: CustomTabBar(tabController: _tabController),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  bottom: kVPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: CustomTabBarList(tabController: _tabController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget tabBar;

  PersistentHeader({required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHPadding),
      width: MediaQuery.of(context).size.width - 2 * kHPadding,
      height: 55.0,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => 55.0;

  @override
  double get minExtent => 55.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
