import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show displayScaleFactor, descriptionIconSize, detailIconSize;
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
                textScaleFactor: displayScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.displayLarge
                    : Theme.of(context).textTheme.displayLarge,
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
                const SizedBox(width: 5),
                Text(
                  this.ratings.toStringAsFixed(1),
                  textScaleFactor: displayScaleFactor,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(width: 16.0),
            Row(
              children: [
                Icon(
                  CustomOutlinedIcons.view,
                  color: Theme.of(context).hintColor,
                  size: descriptionIconSize,
                ),
                const SizedBox(width: 5),
                Text(
                  this.views.toString(),
                  textScaleFactor: displayScaleFactor,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ],
        ),
        Text(
          this.price == 0
              ? 'Free'
              : '\$${this.price % 1 == 0 ? this.price.toStringAsFixed(0) : this.price.toStringAsFixed(2)}',
          textScaleFactor: displayScaleFactor,
          style: Theme.of(context)
              .primaryTextTheme
              .displayMedium!
              .copyWith(color: Theme.of(context).highlightColor),
          overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Icon(
              CustomFilledIcons.location,
              color: Theme.of(context).primaryColor,
              size: detailIconSize,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                (AppLocalizations.of(context)!.localeName == 'km'
                        ? this.state == 'ភ្នំពេញ'
                            ? 'រាជធានី'
                            : 'ខេត្ត'
                        : '') +
                    this.state +
                    ', ' +
                    this.country,
                textScaleFactor: displayScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.bodyLarge
                    : Theme.of(context).textTheme.bodyLarge,
                overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        this.openHours == null || this.openHours == ''
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Icon(
                    CustomFilledIcons.left,
                    color: Theme.of(context).hintColor,
                    size: detailIconSize,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppLocalizations.of(context)!.pdBusinessHourLabel,
                    textScaleFactor: displayScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).hintColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Theme.of(context).hintColor),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    this.openHours!,
                    textScaleFactor: displayScaleFactor,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w400)
                        : Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ],
              ),
      ],
    );
  }
}
