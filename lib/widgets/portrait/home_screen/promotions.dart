import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize, Palette;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class Promotions extends StatelessWidget {
  final List<PostObject> promotions;

  const Promotions({Key? key, required this.promotions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (promotions.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height / 3.15,
        child: Center(child: CircularProgressIndicator(color: Colors.white54)),
      );
    } else {
      promotions.shuffle();
      return Container(
        height: MediaQuery.of(context).size.height / 3.15,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: promotions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            if (index == promotions.length - 1)
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: _PromotionCard(promotion: promotions[index]),
              );
            else if (index == 0)
              return Padding(
                padding: const EdgeInsets.only(left: kHPadding),
                child: _PromotionCard(promotion: promotions[index]),
              );
            else
              return _PromotionCard(promotion: promotions[index]);
          },
        ),
      );
    }
  }
}

class _PromotionCard extends StatelessWidget {
  final PostObject promotion;

  const _PromotionCard({Key? key, required this.promotion}) : super(key: key);

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
              child: promotion.imageUrls.elementAt(0).split('/').first ==
                      'assets'
                  ? Image(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 2,
                      image: AssetImage(promotion.imageUrls.elementAt(0)),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 2,
                      imageUrl: promotion.imageUrls.elementAt(0),
                      fit: BoxFit.cover,
                      placeholder: (context, _) => ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.asset('assets/images/travenx_180.png'),
                      ),
                      errorWidget: (context, _, __) => Center(
                        child: Text('Unable to Load Image...'),
                      ),
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
                        promotion.title,
                        maxLines: 2,
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
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
                              promotion.location,
                              textScaleFactor: textScaleFactor,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      '\$${promotion.price % 1 == 0 ? promotion.price.toStringAsFixed(0) : promotion.price.toStringAsFixed(1)}',
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
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
                                promotion.briefDescription!.ratings
                                    .toStringAsFixed(1),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
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
                                promotion.briefDescription!.views.toString(),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
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
