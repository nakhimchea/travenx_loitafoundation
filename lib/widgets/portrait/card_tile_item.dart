import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';

class CardTileItem extends StatelessWidget {
  final double vPadding;
  final PostObject post;
  const CardTileItem({
    Key? key,
    this.vPadding = 8.0,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _imageSize = MediaQuery.of(context).size.height / 6.16;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(post: post),
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
                child: post.imageUrls.elementAt(0).split('/').first == 'assets'
                    ? Image.asset(
                        post.imageUrls.elementAt(0),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: post.imageUrls.elementAt(0),
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
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 14.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post.title,
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.headline4,
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                        Text(
                          post.price == 0
                              ? 'Free'
                              : '\$${post.price % 1 == 0 ? post.price.toStringAsFixed(0) : post.price.toStringAsFixed(1)}',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
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
                    Expanded(
                      child: Center(
                        child: Text(
                          (post.details != null)
                              ? post.details!.textDetail
                              : '',
                          textScaleFactor: textScaleFactor,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
