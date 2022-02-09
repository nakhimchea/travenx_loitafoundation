import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/widgets/portrait/card_tile_item.dart';

class IconMenuTab extends StatefulWidget {
  final int initIndex;
  final List<List<PostObject>> iconMenus;

  const IconMenuTab({
    Key? key,
    required this.initIndex,
    required this.iconMenus,
  }) : super(key: key);

  @override
  _IconMenuTabState createState() => _IconMenuTabState();
}

class _IconMenuTabState extends State<IconMenuTab> {
  List<ListView> _buildIconMenusList() {
    const double _vPadding = 8;
    List<ListView> tabBarListItems = [];

    List<PostObject> allPlaces = [];
    widget.iconMenus
        .forEach((list) => list.forEach((element) => allPlaces.add(element)));

    for (int i = 0; i < widget.iconMenus.length; i++) {
      tabBarListItems.add(
        ListView.builder(
          padding: const EdgeInsets.only(
            left: kHPadding,
            right: kHPadding,
            top: kVPadding + 2.0,
            bottom: kVPadding + 6.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CardTileItem(
              placeObject: widget.iconMenus[i].elementAt(index),
              vPadding: _vPadding,
            );
          },
          itemCount: widget.iconMenus[i].length,
        ),
      );
    }
    tabBarListItems.add(
      ListView.builder(
        padding: const EdgeInsets.only(
          left: kHPadding,
          right: kHPadding,
          top: kVPadding + 2.0,
          bottom: kVPadding + 6.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CardTileItem(
            placeObject: allPlaces.elementAt(index),
            vPadding: _vPadding,
          );
        },
        itemCount: allPlaces.length,
      ),
    );
    return tabBarListItems;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
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
        body: TabBarView(children: _buildIconMenusList()),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  List<Tab> _buildTabs() {
    List<Tab> _tabItems = [];

    for (ModelIconMenu modelIconMenu in modelIconMenus)
      _tabItems.add(Tab(text: modelIconMenu.label));
    _tabItems.add(Tab(text: 'តំបន់ទាំងអស់'));

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
