import 'dart:async' show StreamSubscription;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/change_theme_button.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/widgets.dart';

class HomeScreen extends StatefulWidget {
  final bool needRefresh;
  final void Function() toggleNeedRefresh;
  const HomeScreen(
      {Key? key, required this.needRefresh, required this.toggleNeedRefresh})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  late TabController _tabController;
  late StreamSubscription subscription;
  bool _hasInternet = true;

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
          physics: const BouncingScrollPhysics(),
          header: ClassicHeader(
            refreshingText: AppLocalizations.of(context)!.rRefreshingText,
            failedText: AppLocalizations.of(context)!.rFailedText,
            completeText: AppLocalizations.of(context)!.rCompleteText,
            idleText: AppLocalizations.of(context)!.rIdleText,
            releaseText: AppLocalizations.of(context)!.loadingText,
          ),
          onRefresh: () {
            widget.toggleNeedRefresh();
            if (mounted) setState(() {});
            _refreshController.refreshCompleted();
          },
          onLoading: null,
          child: CustomScrollView(
            primary: false,
            physics: const BouncingScrollPhysics(),
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
                  textScaleFactor: displayScaleFactor,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                centerTitle: false,
                floating: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: kHPadding),
                    child: ChangeLanguageButton(
                      toggleNeedRefresh: widget.toggleNeedRefresh,
                    ),
                  ),
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
                      Promotions(needRefresh: widget.needRefresh),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding,
                          vertical: kVPadding,
                        ),
                        child: Provinces(),
                      ),
                      Nearbys(needRefresh: widget.needRefresh),
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
                padding: const EdgeInsets.only(bottom: kVPadding),
                sliver: SliverToBoxAdapter(
                  child: CustomTabBarList(
                    context: context,
                    tabController: _tabController,
                    needRefresh: widget.needRefresh,
                    toggleNeedRefresh: widget.toggleNeedRefresh,
                  ),
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
      width: MediaQuery.of(context).size.width - 2 * kHPadding,
      height: 58.0,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => 58.0;

  @override
  double get minExtent => 58.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
