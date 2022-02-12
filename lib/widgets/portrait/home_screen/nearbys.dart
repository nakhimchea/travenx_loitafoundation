import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize, Palette;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class Nearbys extends StatefulWidget {
  const Nearbys({Key? key}) : super(key: key);

  @override
  _NearbysState createState() => _NearbysState();
}

class _NearbysState extends State<Nearbys> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();
  bool _isRefreshable = true;
  bool _isLoadable = true;

  List<PostObject> postList = [];
  DocumentSnapshot? _lastDoc;

  static double _hPadding = 10;

  Widget _buildList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: postList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if (index == postList.length - 1)
          return Padding(
            padding: EdgeInsets.only(right: kHPadding - _hPadding),
            child:
                _NearbyCard(placeObject: postList[index], hPadding: _hPadding),
          );
        if (index == 0)
          return Padding(
            padding: const EdgeInsets.only(left: kHPadding),
            child:
                _NearbyCard(placeObject: postList[index], hPadding: _hPadding),
          );
        else
          return _NearbyCard(placeObject: postList[index], hPadding: _hPadding);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: kHPadding),
          child: Text(
            'ទីតាំងក្បែរៗ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: MediaQuery.of(context).size.height / 3.75 + 10,
          child: SmartRefresher(
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
              //TODO: Change here according to GeoLocator
              postList = postTranslator(await _firestoreService
                  .getPromotionData(_lastDoc)
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
              //TODO: Change here according to GeoLocator
              postList = List.from(postList)
                ..addAll(postTranslator(await _firestoreService
                    .getPromotionData(_lastDoc)
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
  final PostObject placeObject;

  const _NearbyCard({
    Key? key,
    this.hPadding = 10.0,
    required this.placeObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      //TODO: Navigate User to Detail Page
      //     () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => PostDetail(post: nearby),
      //   ),
      // ),
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
                  image: AssetImage(placeObject.imageUrls.elementAt(0)),
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
                        placeObject.title,
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.headline4,
                        overflow: TextOverflow.ellipsis,
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
                              placeObject.location,
                              textScaleFactor: textScaleFactor,
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
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
                                color: Palette.priceColor,
                                size: descriptionIconSize,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  placeObject.briefDescription!.ratings
                                      .toStringAsFixed(1),
                                  textScaleFactor: textScaleFactor,
                                  style: Theme.of(context).textTheme.headline5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                CustomOutlinedIcons.view,
                                color: Palette.tertiary,
                                size: descriptionIconSize,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  placeObject.briefDescription!.views
                                      .toString(),
                                  textScaleFactor: textScaleFactor,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  overflow: TextOverflow.ellipsis,
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
                      '\$${placeObject.price % 1 == 0 ? placeObject.price.toStringAsFixed(0) : placeObject.price.toStringAsFixed(1)}',
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
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
