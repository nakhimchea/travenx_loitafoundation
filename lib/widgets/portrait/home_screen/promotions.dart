import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, descriptionIconSize, Palette;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class Promotions extends StatefulWidget {
  final bool needRefresh;
  const Promotions({
    Key? key,
    required this.needRefresh,
  }) : super(key: key);

  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();
  bool _isRefreshable = true;
  bool _isLoadable = true;

  List<PostObject> postList = [];
  DocumentSnapshot? _lastDoc;

  Widget _buildList() {
    return ListView.builder(
      itemCount: postList.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return Padding(
            padding: const EdgeInsets.only(left: kHPadding),
            child: _PromotionCard(post: postList[index]),
          );
        else if (index == postList.length - 1)
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _PromotionCard(post: postList[index]),
          );
        else
          return _PromotionCard(post: postList[index]);
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

  void _reloadData() async {
    postList = postTranslator(
        context,
        await _firestoreService
            .getPromotionData(
                AppLocalizations.of(context)!.localeName, _lastDoc)
            .then((snapshot) {
          setState(() => snapshot.docs.isNotEmpty
              ? _lastDoc = snapshot.docs.last
              : _isLoadable = false);
          return snapshot.docs;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.needRefresh) {
      _isRefreshable = true;
      _isLoadable = true;
      postList = [];
      _lastDoc = null;
      _reloadData();
    }

    return Container(
      padding: const EdgeInsets.only(top: 6.0, bottom: kVPadding),
      height: MediaQuery.of(context).size.height / 2.8,
      child: SmartRefresher(
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
                  .getPromotionData(
                      AppLocalizations.of(context)!.localeName, _lastDoc)
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
                    .getPromotionData(
                        AppLocalizations.of(context)!.localeName, _lastDoc)
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
    );
  }
}

class _PromotionCard extends StatefulWidget {
  final PostObject post;

  const _PromotionCard({Key? key, required this.post}) : super(key: key);

  @override
  State<_PromotionCard> createState() => _PromotionCardState();
}

class _PromotionCardState extends State<_PromotionCard> {
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
        padding: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: widget.post.imageUrls.elementAt(0).split('/').first ==
                      'assets'
                  ? Image.asset(
                      widget.post.imageUrls.elementAt(0),
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 1.9,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 1.9,
                      imageUrl: widget.post.imageUrls.elementAt(0),
                      fit: BoxFit.cover,
                      placeholder: (context, _) => ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: widget.post.price ~/ 100 > 0
                      ? Theme.of(context).errorColor
                      : widget.post.price ~/ 25 > 0
                          ? Theme.of(context).highlightColor
                          : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  widget.post.price == 0
                      ? 'Free'
                      : '\$${widget.post.price % 1 == 0 ? widget.post.price.toStringAsFixed(0) : widget.post.price.toStringAsFixed(2)}',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 1.9,
              decoration: BoxDecoration(
                gradient: Palette.blackGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    maxLines: 2,
                    textScaleFactor: textScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .displayMedium!
                            .copyWith(color: Colors.white)
                        : Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.white),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: AppLocalizations.of(context)!.localeName == 'km'
                        ? 0
                        : 5,
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
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppLocalizations.of(context)!.localeName == 'km'
                        ? 5
                        : 10,
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
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
