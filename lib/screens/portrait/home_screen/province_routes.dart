import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, kCardTileVPadding, Palette;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/card_tile_item.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/custom_floating_action_button.dart';

class ProvinceRoutes extends StatefulWidget {
  const ProvinceRoutes({Key? key}) : super(key: key);

  @override
  _ProvinceRoutesState createState() => _ProvinceRoutesState();
}

class _ProvinceRoutesState extends State<ProvinceRoutes> {
  final FirestoreService _firestoreService = FirestoreService();

  Map<String, dynamic>? postCounters;

  void setPostCounters() async {
    Map<String, dynamic> _data = await _firestoreService.getProvinceCounter();
    setState(() => postCounters = _data);
  }

  @override
  void initState() {
    super.initState();
    setPostCounters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            brightness: Theme.of(context).colorScheme.brightness,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).iconTheme.color,
                size: 18.0,
              ),
            ),
            title: Text(
              'ខេត្ត/ក្រុងទាំងអស់',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.headline3,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                //TODO: Navigate user to Search screen
                //     ()=> Navigator.push(
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
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kHPadding - kCardTileVPadding / 2,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 8.12 +
                        kCardTileVPadding,
                    child: _ProvincesItem(
                      modelProvince: modelProvinces.elementAt(index),
                      totalPosts: postCounters == null
                          ? '0'
                          : postCounters![modelProvinces.elementAt(index).label]
                              .toString(),
                      vPadding: kCardTileVPadding,
                    ),
                  );
                },
                childCount: modelProvinces.length - 1,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 14.0)),
        ],
      ),
    );
  }
}

class _ProvincesItem extends StatelessWidget {
  final ModelProvince modelProvince;
  final String totalPosts;
  final double vPadding;

  const _ProvincesItem({
    Key? key,
    required this.modelProvince,
    required this.totalPosts,
    required this.vPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _imageSize = MediaQuery.of(context).size.height / 8.12;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProvinceRoute(modelProvince: modelProvince),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vPadding / 2),
        child: Row(
          children: [
            Container(
              height: _imageSize,
              width: _imageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image(
                  image: AssetImage(modelProvince.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: _imageSize,
              width: MediaQuery.of(context).size.width -
                  2 * kHPadding -
                  _imageSize,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelProvince.label,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.headline2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Row(
                      children: [
                        Text(
                          'ទីតាំងសរុប៖ ',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button,
                        ),
                        Text(
                          totalPosts,
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvinceRoute extends StatelessWidget {
  final ModelProvince modelProvince;
  const ProvinceRoute({Key? key, required this.modelProvince})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomFloatingActionButton(onTap: () => Navigator.pop(context)),
          CustomFloatingActionButton(
            onTap: () => print('Search'), //TODO: Search Navigation
            iconData: CustomOutlinedIcons.search,
            iconSize: 24.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHPadding),
        child: _ProvinceList(
          modelProvince: modelProvince,
          vPadding: kCardTileVPadding,
        ),
      ),
    );
  }
}

class _ProvinceList extends StatefulWidget {
  final ModelProvince modelProvince;
  final double vPadding;
  const _ProvinceList({
    Key? key,
    required this.modelProvince,
    required this.vPadding,
  }) : super(key: key);

  @override
  _ProvinceListState createState() => _ProvinceListState();
}

class _ProvinceListState extends State<_ProvinceList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();
  bool _isRefreshable = true;
  bool _isLoadable = true;

  String? postCounter;

  void setPostCounters() async {
    Map<String, dynamic> _data = await _firestoreService.getProvinceCounter();
    setState(() => postCounter = _data[widget.modelProvince.label].toString());
  }

  @override
  void initState() {
    super.initState();
    setPostCounters();
  }

  List<PostObject> postList = [];
  DocumentSnapshot? _lastDoc;

  Widget _buildList() {
    return postList.length != 0
        ? ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: kIsWeb
                            ? 5.0
                            : 44.0, //TODO: This according to devices
                        bottom: kVPadding,
                      ),
                      child: _ProvinceCover(
                          modelProvince: widget.modelProvince,
                          totalPosts: postCounter == null ? '0' : postCounter!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        'ទីតាំងទាំងអស់',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    CardTileItem(
                      placeObject: postList.elementAt(index),
                      vPadding: widget.vPadding,
                    ),
                  ],
                );
              else if (index == postList.length - 1)
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CardTileItem(
                    placeObject: postList.elementAt(index),
                    vPadding: widget.vPadding,
                  ),
                );
              else
                return CardTileItem(
                  placeObject: postList.elementAt(index),
                  vPadding: widget.vPadding,
                );
            },
            itemCount: postList.length,
          )
        : Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: kIsWeb ? 5.0 : 44.0, //TODO: This according to devices
                  bottom: kVPadding,
                ),
                child: _ProvinceCover(
                  modelProvince: widget.modelProvince,
                  totalPosts: '0',
                ),
              ),
            ],
          );
  }

  Widget loadingBuilder(BuildContext context, LoadStatus? mode) {
    Widget _footer;

    if (mode == LoadStatus.idle)
      _footer = Center(
        child: Icon(
          Icons.keyboard_arrow_left_outlined,
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
      enablePullDown: _isRefreshable,
      enablePullUp: _isLoadable,
      child: _buildList(),
      header: CustomHeader(builder: (_, __) => SizedBox.shrink()),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: loadingBuilder,
      ),
      onRefresh: () async {
        postList = postTranslator(await _firestoreService
            .getProvinceData(widget.modelProvince.label, _lastDoc)
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
        postList = List.from(postList)
          ..addAll(postTranslator(await _firestoreService
              .getProvinceData(widget.modelProvince.label, _lastDoc)
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

class _ProvinceCover extends StatelessWidget {
  final ModelProvince modelProvince;
  final String totalPosts;
  const _ProvinceCover({
    Key? key,
    required this.modelProvince,
    required this.totalPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image(
            image: AssetImage(modelProvince.imageUrl),
            height: MediaQuery.of(context).size.width - 2 * kHPadding,
            width: MediaQuery.of(context).size.width - 2 * kHPadding,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width - 2 * kHPadding,
          width: MediaQuery.of(context).size.width - 2 * kHPadding,
          decoration: BoxDecoration(
            gradient: Palette.blackGradient,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                modelProvince.label,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 40.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ទីតាំងសរុប៖ ',
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    totalPosts,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
