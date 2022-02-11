import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize, Palette;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class Promotions extends StatefulWidget {
  const Promotions({Key? key}) : super(key: key);

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
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == postList.length - 1)
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _PromotionCard(post: postList[index]),
          );
        else if (index == 0)
          return Padding(
            padding: const EdgeInsets.only(left: kHPadding),
            child: _PromotionCard(post: postList[index]),
          );
        else
          return _PromotionCard(post: postList[index]);
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
    return Container(
      height: MediaQuery.of(context).size.height / 3.15,
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
    );
  }
}

class _PromotionCard extends StatelessWidget {
  final PostObject post;

  const _PromotionCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      //TODO: Navigate User to Detail Screen
      //     () => Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) => PostDetail(post: promotion)),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: post.imageUrls.elementAt(0).split('/').first == 'assets'
                  ? Image(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 2,
                      image: AssetImage(post.imageUrls.elementAt(0)),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 2,
                      imageUrl: post.imageUrls.elementAt(0),
                      fit: BoxFit.cover,
                      placeholder: (context, _) => ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.asset('assets/images/travenx_180.png'),
                      ),
                      errorWidget: (context, _, __) =>
                          Image.asset('assets/images/travenx_180.png'),
                    ),
            ),
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient: Palette.blackGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    dense: true,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        post.title,
                        maxLines: 2,
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                        overflow:
                            kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            CustomFilledIcons.location,
                            color: Theme.of(context).primaryColor,
                            size: descriptionIconSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              post.location,
                              textScaleFactor: textScaleFactor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                              overflow: kIsWeb
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      '\$${post.price % 1 == 0 ? post.price.toStringAsFixed(0) : post.price.toStringAsFixed(1)}',
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Row(
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
                                post.briefDescription!.ratings
                                    .toStringAsFixed(1),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
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
                              color: Palette.tertiary,
                              size: descriptionIconSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                post.briefDescription!.views.toString(),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: Colors.white),
                                overflow: kIsWeb
                                    ? TextOverflow.clip
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
