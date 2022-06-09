import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize;
import 'package:travenx_loitafoundation/helpers/city_name_translator.dart';
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/services/geolocator_service.dart';
import 'package:travenx_loitafoundation/services/internet_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';

class Nearbys extends StatefulWidget {
  final bool needRefresh;
  const Nearbys({
    Key? key,
    required this.needRefresh,
  }) : super(key: key);

  @override
  _NearbysState createState() => _NearbysState();
}

class _NearbysState extends State<Nearbys> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();

  bool _isRefreshable = true;
  bool _isLoadable = true;

  List<PostObject> postList = [];
  DocumentSnapshot? _lastDoc;

  double _hPadding = 8;

  Widget _buildList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: postList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return Padding(
            padding: const EdgeInsets.only(left: kHPadding),
            child: _NearbyCard(post: postList[index], hPadding: _hPadding),
          );
        else if (index == postList.length - 1)
          return Padding(
            padding: EdgeInsets.only(right: kHPadding - _hPadding),
            child: _NearbyCard(post: postList[index], hPadding: _hPadding),
          );
        else
          return _NearbyCard(post: postList[index], hPadding: _hPadding);
      },
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

  String cityName = '';
  bool hasNoData = false;

  Future<String> _setLocationCity() async {
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final String _owmReverseGeocodingUrl =
        'http://api.openweathermap.org/geo/1.0/reverse?';
    final String _coordination =
        await GeolocatorService.getCurrentCoordination();
    if (_coordination != '') {
      final String _responseBody = await InternetService.httpGetResponseBody(
          url:
              '$_owmReverseGeocodingUrl$_coordination&appid=${await _secureStorage.read(key: 'owmKey')}');
      final String _enCityName =
          jsonDecode(_responseBody)[0]['state'].toString();

      setState(() =>
          cityName = cityNameTranslator(context, enCityName: _enCityName));
      return cityName;
    } else
      setState(() => cityName = 'denied');
    return cityName;
  }

  void _reloadData() async {
    postList = postTranslator(
        context,
        await _firestoreService
            .getProvinceData(
                cityName == 'denied' ? 'ភ្នំពេញ' : cityName, _lastDoc)
            .then((snapshot) {
          setState(() => snapshot.docs.isNotEmpty
              ? _lastDoc = snapshot.docs.last
              : _isLoadable = false);
          return snapshot.docs;
        }));
    if (postList.length == 0) setState(() => hasNoData = true);
  }

  @override
  void initState() {
    super.initState();
    _setLocationCity();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.needRefresh) {
      _isRefreshable = true;
      _isLoadable = true;
      postList = [];
      _lastDoc = null;
      _setLocationCity().whenComplete(() => _reloadData());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        cityName == 'denied'
            ? kIsWeb
                ? Container(
                    height: 40,
                    color: Theme.of(context).disabledColor,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: kHPadding),
                        Center(
                          child: Icon(
                            CustomFilledIcons.location,
                            color: Theme.of(context).iconTheme.color,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.locationClosed +
                                AppLocalizations.of(context)!.locationSet,
                            textScaleFactor: textScaleFactor,
                            style: AppLocalizations.of(context)!.localeName ==
                                    'km'
                                ? Theme.of(context).primaryTextTheme.bodyMedium
                                : Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.locationToOpenWeb,
                            textScaleFactor: textScaleFactor,
                            style:
                                AppLocalizations.of(context)!.localeName == 'km'
                                    ? Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context).hintColor)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context).hintColor),
                          ),
                        ),
                        const SizedBox(width: kHPadding),
                      ],
                    ),
                  )
                : TextButton(
                    onPressed: () async {
                      try {
                        if (await GeolocatorService.openLocationSettings()) {
                          if (await Geolocator.isLocationServiceEnabled()) {
                            setState(() {
                              _isRefreshable = true;
                              _isLoadable = true;
                              cityName = '';
                              postList = [];
                              _lastDoc = null;
                            });

                            //Slowdown the postList state for Smart Refresher
                            Future.delayed(Duration(milliseconds: 250))
                                .whenComplete(() => _setLocationCity());
                          } else
                            print('Location service is still disabled.');
                        } else
                          print('Failed to open Location settings.');
                      } catch (e) {
                        print('Unknown Error: $e');
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 40,
                      color: Theme.of(context).disabledColor,
                      child: ListView(
                        primary: false,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: kHPadding),
                          Center(
                            child: Icon(
                              CustomFilledIcons.location,
                              color: Theme.of(context).iconTheme.color,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.locationClosed +
                                  AppLocalizations.of(context)!.locationSet,
                              textScaleFactor: textScaleFactor,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .locationToOpenMobile,
                              textScaleFactor: textScaleFactor,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context).hintColor)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context).hintColor),
                            ),
                          ),
                          const SizedBox(width: kHPadding),
                        ],
                      ),
                    ),
                  )
            : const SizedBox.shrink(),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: kHPadding),
          child: Text(
            AppLocalizations.of(context)!.nbLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.titleLarge
                : Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10.0),
        cityName == ''
            ? Container(
                alignment: Alignment.center,
                height: 150 + 121 * textScaleFactor,
                child: Loading(color: Theme.of(context).disabledColor))
            : Container(
                height: 150 + 121 * textScaleFactor,
                child: hasNoData
                    ? Center(
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
                              AppLocalizations.of(context)!.nbNoData,
                              textScaleFactor: textScaleFactor,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context).primaryTextTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                          ],
                        ),
                      )
                    : SmartRefresher(
                        controller: _refreshController,
                        physics: const BouncingScrollPhysics(),
                        enablePullDown: _isRefreshable,
                        enablePullUp: _isLoadable,
                        child: _buildList(),
                        header: CustomHeader(
                            builder: (_, __) => const SizedBox.shrink()),
                        footer: CustomFooter(
                          loadStyle: LoadStyle.ShowWhenLoading,
                          builder: _loadingBuilder,
                        ),
                        onRefresh: () async {
                          postList = postTranslator(
                              context,
                              await _firestoreService
                                  .getProvinceData(
                                      cityName == 'denied'
                                          ? 'ភ្នំពេញ'
                                          : cityName,
                                      _lastDoc)
                                  .then((snapshot) {
                                setState(() => snapshot.docs.isNotEmpty
                                    ? _lastDoc = snapshot.docs.last
                                    : _isLoadable = false);
                                return snapshot.docs;
                              }));
                          if (postList.length == 0)
                            setState(() => hasNoData = true);
                          if (mounted) setState(() => _isRefreshable = false);
                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          postList = List.from(postList)
                            ..addAll(postTranslator(
                                context,
                                await _firestoreService
                                    .getProvinceData(
                                        cityName == 'denied'
                                            ? 'ភ្នំពេញ'
                                            : cityName,
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
                      ),
              ),
      ],
    );
  }
}

class _NearbyCard extends StatefulWidget {
  final double hPadding;
  final PostObject post;

  const _NearbyCard({
    Key? key,
    this.hPadding = 10.0,
    required this.post,
  }) : super(key: key);

  @override
  State<_NearbyCard> createState() => _NearbyCardState();
}

class _NearbyCardState extends State<_NearbyCard> {
  int _views = 0;
  double _ratings = 5;

  void _getViews() async {
    _views = await FirestoreService()
        .readViews(widget.post.postId)
        .then((viewers) => viewers.length);
  }

  void _getRatings() async {
    _ratings = await FirestoreService().getRatingRate(widget.post.postId);
  }

  @override
  void initState() {
    super.initState();
    _getViews();
    _getRatings();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(
            post: widget.post,
            views: _views,
            ratings: _ratings,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: widget.hPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child:
                        widget.post.imageUrls.elementAt(0).split('/').first ==
                                'assets'
                            ? Image.asset(
                                widget.post.imageUrls.elementAt(0),
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.post.imageUrls.elementAt(0),
                                fit: BoxFit.cover,
                                placeholder: (context, _) => ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Image.asset(
                                    'assets/images/travenx_180.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                errorWidget: (context, _, __) => Image.asset(
                                  'assets/images/travenx.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.post.price ~/ 100 > 0
                          ? Theme.of(context).errorColor
                          : widget.post.price ~/ 25 > 0
                              ? Theme.of(context).highlightColor
                              : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      widget.post.price == 0
                          ? 'Free'
                          : '\$${widget.post.price % 1 == 0 ? widget.post.price.toStringAsFixed(0) : widget.post.price.toStringAsFixed(1)}',
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 121 * textScaleFactor,
              width: MediaQuery.of(context).size.width / 1.9,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context).primaryTextTheme.titleMedium
                        : Theme.of(context).textTheme.titleMedium,
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(
                        CustomFilledIcons.location,
                        color: Theme.of(context).primaryColor,
                        size: descriptionIconSize,
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: Text(
                          (AppLocalizations.of(context)!.localeName == 'km'
                                  ? widget.post.state == 'ភ្នំពេញ'
                                      ? 'រាជធានី'
                                      : 'ខេត្ត'
                                  : '') +
                              widget.post.state,
                          textScaleFactor: textScaleFactor,
                          style:
                              AppLocalizations.of(context)!.localeName == 'km'
                                  ? Theme.of(context).primaryTextTheme.bodySmall
                                  : Theme.of(context).textTheme.bodySmall,
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomFilledIcons.star,
                            color: Theme.of(context).highlightColor,
                            size: descriptionIconSize,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            _ratings.toStringAsFixed(1),
                            textScaleFactor: textScaleFactor,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            CustomOutlinedIcons.view,
                            color: Theme.of(context).hintColor,
                            size: descriptionIconSize,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            _views.toString(),
                            textScaleFactor: textScaleFactor,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
