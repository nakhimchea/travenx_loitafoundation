import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, displayScaleFactor, kCardTileVPadding, Palette;
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
        primary: false,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
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
              AppLocalizations.of(context)!.pvAppBar,
              textScaleFactor: displayScaleFactor,
              style: AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context).primaryTextTheme.titleLarge
                  : Theme.of(context).textTheme.titleLarge,
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
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
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
                      modelProvince: modelProvinces(context).elementAt(index),
                      totalPosts: postCounters == null
                          ? '0'
                          : (postCounters![modelProvinces(context)
                                      .elementAt(index)
                                      .label] ??
                                  '0')
                              .toString(),
                      vPadding: kCardTileVPadding,
                    ),
                  );
                },
                childCount: modelProvinces(context).length - 1,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 14.0)),
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image.asset(
                  modelProvince.imageUrl,
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
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
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
                      textScaleFactor: displayScaleFactor,
                      style: AppLocalizations.of(context)!.localeName == 'km'
                          ? Theme.of(context).primaryTextTheme.displayMedium
                          : Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.pvCountPlaces,
                          textScaleFactor: displayScaleFactor,
                          style: AppLocalizations.of(context)!.localeName ==
                                  'km'
                              ? Theme.of(context).primaryTextTheme.bodyMedium
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          totalPosts,
                          textScaleFactor: displayScaleFactor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kVPadding + kHPadding,
              vertical: kVPadding,
            ),
            child:
                CustomFloatingActionButton(onTap: () => Navigator.pop(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kVPadding + kHPadding,
              vertical: kVPadding,
            ),
            child: CustomFloatingActionButton(
              onTap: () => print('Search'), //TODO: Search Navigation
              iconData: CustomOutlinedIcons.search,
              iconSize: 24.0,
            ),
          ),
        ],
      ),
      body: _ProvinceList(
        modelProvince: modelProvince,
        vPadding: kCardTileVPadding,
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
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kHPadding,
                        right: kHPadding,
                        top: kIsWeb ? 5.0 : 44.0,
                        bottom: kVPadding,
                      ),
                      child: _ProvinceCover(
                          modelProvince: widget.modelProvince,
                          totalPosts: postCounter == null ? '0' : postCounter!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding, vertical: 6.0),
                      child: Text(
                        AppLocalizations.of(context)!.pvTitle,
                        textScaleFactor: displayScaleFactor,
                        style: AppLocalizations.of(context)!.localeName == 'km'
                            ? Theme.of(context).primaryTextTheme.titleLarge
                            : Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    CardTileItem(
                      post: postList.elementAt(index),
                      vPadding: widget.vPadding,
                    ),
                  ],
                );
              else if (index == postList.length - 1)
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CardTileItem(
                    post: postList.elementAt(index),
                    vPadding: widget.vPadding,
                  ),
                );
              else
                return CardTileItem(
                  post: postList.elementAt(index),
                  vPadding: widget.vPadding,
                );
            },
            itemCount: postList.length,
          )
        : Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: kIsWeb ? 5.0 : 44.0,
                  bottom: kVPadding,
                ),
                child: _ProvinceCover(
                  modelProvince: widget.modelProvince,
                  totalPosts: '0',
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CustomOutlinedIcons.warning,
                      size: 24.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.noData,
                      textScaleFactor: displayScaleFactor,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _loadingBuilder(BuildContext context, LoadStatus? mode) {
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
      physics: const BouncingScrollPhysics(),
      enablePullDown: _isRefreshable,
      enablePullUp: _isLoadable,
      child: _buildList(),
      header: CustomHeader(builder: (_, __) => const SizedBox.shrink()),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: _loadingBuilder,
      ),
      onRefresh: () async {
        postList = postTranslator(
            context,
            await _firestoreService
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
          ..addAll(postTranslator(
              context,
              await _firestoreService
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
          child: Image.asset(
            modelProvince.imageUrl,
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
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (AppLocalizations.of(context)!.localeName == 'km'
                        ? modelProvince.label ==
                                AppLocalizations.of(context)!.pvPhnomPenh
                            ? 'រាជធានី'
                            : 'ខេត្ត'
                        : '') +
                    modelProvince.label,
                textScaleFactor: displayScaleFactor,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white, fontSize: 40.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.pvCountPlaces,
                    textScaleFactor: displayScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                  ),
                  Text(
                    totalPosts,
                    textScaleFactor: displayScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).primaryColor),
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
