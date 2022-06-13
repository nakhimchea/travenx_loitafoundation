import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show descriptionIconSize, kHPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class CardTileItem extends StatefulWidget {
  final double vPadding;
  final PostObject post;
  const CardTileItem({
    Key? key,
    this.vPadding = 8.0,
    required this.post,
  }) : super(key: key);

  @override
  State<CardTileItem> createState() => _CardTileItemState();
}

class _CardTileItemState extends State<CardTileItem> {
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
    final double _imageSize = MediaQuery.of(context).size.height / 5.95;
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
        padding: EdgeInsets.symmetric(
            horizontal: kHPadding, vertical: widget.vPadding / 2),
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
                child: widget.post.imageUrls.elementAt(0).split('/').first ==
                        'assets'
                    ? Image.asset(
                        widget.post.imageUrls.elementAt(0),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.post.title,
                            textScaleFactor: displayScaleFactor,
                            style: AppLocalizations.of(context)!.localeName ==
                                    'km'
                                ? Theme.of(context).primaryTextTheme.titleMedium
                                : Theme.of(context).textTheme.titleMedium,
                            overflow: kIsWeb
                                ? TextOverflow.clip
                                : TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.post.price == 0
                              ? 'Free'
                              : '\$${widget.post.price % 1 == 0 ? widget.post.price.toStringAsFixed(0) : widget.post.price.toStringAsFixed(1)}',
                          textScaleFactor: displayScaleFactor,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(
                          CustomFilledIcons.location,
                          color: Theme.of(context).primaryColor,
                          size: descriptionIconSize,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              (AppLocalizations.of(context)!.localeName == 'km'
                                      ? widget.post.state == 'ភ្នំពេញ'
                                          ? 'រាជធានី'
                                          : 'ខេត្ត'
                                      : '') +
                                  widget.post.state,
                              textScaleFactor: displayScaleFactor,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context).primaryTextTheme.bodySmall
                                  : Theme.of(context).textTheme.bodySmall,
                              overflow: kIsWeb
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Expanded(
                      child: Text(
                        (widget.post.details != null)
                            ? widget.post.details!.textDetail
                            : '',
                        textAlign: TextAlign.justify,
                        textScaleFactor: displayScaleFactor,
                        maxLines: 3,
                        style: AppLocalizations.of(context)!.localeName == 'km'
                            ? Theme.of(context).primaryTextTheme.bodySmall
                            : Theme.of(context).textTheme.bodySmall,
                        overflow:
                            kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CustomFilledIcons.star,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: descriptionIconSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                _ratings.toStringAsFixed(1),
                                textScaleFactor: displayScaleFactor,
                                style: Theme.of(context).textTheme.titleSmall,
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
                                _views.toString(),
                                textScaleFactor: displayScaleFactor,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
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
