import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show textScaleFactor, descriptionIconSize, detailIconSize;
import 'package:travenx_loitafoundation/icons/icons.dart';

class PostHeader extends StatelessWidget {
  final String title;
  final double ratings;
  final int views;
  final double price;
  final String state;
  final String country;
  final String? openHours;

  const PostHeader({
    Key? key,
    required this.title,
    required this.ratings,
    required this.views,
    required this.price,
    required this.state,
    required this.country,
    required this.openHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                this.title,
                maxLines: 2,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.headline1,
                overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
              ),
            ),
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
                    this.ratings.toStringAsFixed(1),
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.headline5,
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10.0),
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
                    this.views.toString(),
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          this.price == 0
              ? 'Free'
              : '\$${this.price % 1 == 0 ? this.price.toStringAsFixed(0) : this.price.toStringAsFixed(2)}',
          textScaleFactor: textScaleFactor,
          style:
              Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 22.0),
          overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
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
                (this.state == 'ភ្នំពេញ' ? 'រាជធានី' : 'ខេត្ត') +
                    this.state +
                    ' ' +
                    this.country,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        this.openHours == null
            ? SizedBox.shrink()
            : Row(
                children: [
                  Icon(
                    CustomFilledIcons.left,
                    color: Theme.of(context).hintColor,
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
                          .copyWith(color: Theme.of(context).hintColor),
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      this.openHours!,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).iconTheme.color),
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
