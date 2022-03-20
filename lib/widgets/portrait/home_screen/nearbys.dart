import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
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

class Nearbys extends StatefulWidget {
  const Nearbys({Key? key}) : super(key: key);

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

  double _hPadding = 10;

  Widget _buildList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: postList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if (index == postList.length - 1)
          return Padding(
            padding: EdgeInsets.only(right: kHPadding - _hPadding),
            child: _NearbyCard(post: postList[index], hPadding: _hPadding),
          );
        if (index == 0)
          return Padding(
            padding: const EdgeInsets.only(left: kHPadding),
            child: _NearbyCard(post: postList[index], hPadding: _hPadding),
          );
        else
          return _NearbyCard(post: postList[index], hPadding: _hPadding);
      },
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

  String cityName = '';

  void _setLocationCity() async {
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

      setState(() => cityName = cityNameTranslator(enCityName: _enCityName));
    } else
      setState(() => cityName = 'denied');
  }

  @override
  void initState() {
    super.initState();
    _setLocationCity();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        cityName == 'denied'
            ? kIsWeb
                ? Container(
                    height: 40,
                    color: Theme.of(context).disabledColor,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: kHPadding),
                        Center(
                          child: Icon(
                            CustomFilledIcons.location,
                            color: Theme.of(context).primaryIconTheme.color,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Center(
                          child: Text(
                            'សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ។ ទីតាំងបានកំណត់នៅភ្នំពេញ។ ',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Center(
                          child: Text(
                            'ចុចលើនិមិត្តសញ្ញាទីតាំងខាងលើ ដើម្បីបើកឡើងវិញ!',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Theme.of(context).hintColor),
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
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: kHPadding),
                          Center(
                            child: Icon(
                              CustomFilledIcons.location,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Center(
                            child: Text(
                              'សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ។ ទីតាំងបានកំណត់នៅភ្នំពេញ។ ',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          Center(
                            child: Text(
                              'ចុចទីនេះដើម្បីបើកឡើងវិញ!',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Theme.of(context).hintColor),
                            ),
                          ),
                          const SizedBox(width: kHPadding),
                        ],
                      ),
                    ),
                  )
            : SizedBox.shrink(),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: kHPadding),
          child: Text(
            'ទីតាំងក្បែរៗ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 10.0),
        cityName == ''
            ? Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 3.75 + 10,
                child: CircularProgressIndicator.adaptive())
            : Container(
                height: MediaQuery.of(context).size.height / 3.75 + 10,
                child: SmartRefresher(
                  controller: _refreshController,
                  physics: BouncingScrollPhysics(),
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
                        .getProvinceData(
                            cityName == 'denied' ? 'ភ្នំពេញ' : cityName,
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
                    postList = List.from(postList)
                      ..addAll(postTranslator(await _firestoreService
                          .getProvinceData(
                              cityName == 'denied' ? 'ភ្នំពេញ' : cityName,
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

class _NearbyCard extends StatelessWidget {
  final double hPadding;
  final PostObject post;

  const _NearbyCard({
    Key? key,
    this.hPadding = 10.0,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(post: post),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: hPadding),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6.16,
              width: ((MediaQuery.of(context).size.width - hPadding) / 2) -
                  kHPadding,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image(
                  image: AssetImage(post.imageUrls.elementAt(0)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height / 9.8,
              width: ((MediaQuery.of(context).size.width - hPadding) / 2) -
                  kHPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.headline4,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              (post.state == 'ភ្នំពេញ' ? 'រាជធានី' : 'ខេត្ត') +
                                  post.state +
                                  ' ' +
                                  post.country,
                              textScaleFactor: textScaleFactor,
                              style: Theme.of(context).textTheme.bodyText2,
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
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  post.ratings.toStringAsFixed(1),
                                  textScaleFactor: textScaleFactor,
                                  style: Theme.of(context).textTheme.headline5,
                                  overflow: kIsWeb
                                      ? TextOverflow.clip
                                      : TextOverflow.ellipsis,
                                ),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  post.views.toString(),
                                  textScaleFactor: textScaleFactor,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  overflow: kIsWeb
                                      ? TextOverflow.clip
                                      : TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 40.0,
                    right: 0.0,
                    child: Text(
                      post.price == 0
                          ? 'Free'
                          : '\$${post.price % 1 == 0 ? post.price.toStringAsFixed(0) : post.price.toStringAsFixed(1)}',
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
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
