import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show textScaleFactor, descriptionIconSize, detailIconSize, Palette;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class PostHeader extends StatelessWidget {
  final PostObject post;

  const PostHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                post.title,
                maxLines: 2,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.headline1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
                    post.briefDescription!.ratings.toStringAsFixed(1),
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10.0),
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
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          post.price == 0
              ? 'Free'
              : '\$${post.price % 1 == 0 ? post.price.toStringAsFixed(0) : post.price.toStringAsFixed(2)}',
          textScaleFactor: textScaleFactor,
          style:
              Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 22.0),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Icon(
              CustomFilledIcons.location,
              color: Theme.of(context).primaryColor,
              size: detailIconSize,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                post.location,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          children: [
            Icon(
              CustomFilledIcons.left,
              color: Palette.tertiary,
              size: detailIconSize,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'បើកដំណើរការ',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Palette.tertiary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                '12:00ព្រឹក-09:00យប់',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
