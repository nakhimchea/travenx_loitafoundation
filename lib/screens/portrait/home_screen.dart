import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding + 6.0,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: IconsMenu(),
          //   ),
          // ),
          // SliverPadding(
          //   padding: const EdgeInsets.only(
          //     top: 6.0,
          //     bottom: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: Promotions(),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Provinces(),
            ),
          ),
        ],
      ),
    );
  }
}
