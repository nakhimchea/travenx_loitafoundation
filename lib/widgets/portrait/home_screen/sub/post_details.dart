import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:readmore/readmore.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class PostDetails extends StatelessWidget {
  final Details details;

  const PostDetails({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.pdDetailsLabel,
          textScaleFactor: displayScaleFactor,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.titleLarge
              : Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10.0),
        ReadMoreText(
          this.details.textDetail,
          textScaleFactor: displayScaleFactor,
          trimLines: 5,
          textAlign: TextAlign.justify,
          trimMode: TrimMode.Line,
          trimCollapsedText: AppLocalizations.of(context)!.pdReadmore,
          trimExpandedText: AppLocalizations.of(context)!.doneLabel,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.bodyLarge
              : Theme.of(context).textTheme.bodyLarge,
          moreStyle: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context)
                  .primaryTextTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).hintColor)
              : Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).hintColor),
          lessStyle: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context)
                  .primaryTextTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).hintColor)
              : Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 20.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            'assets/images/travenx.png',
            height: MediaQuery.of(context).size.height / 5.125,
            width: MediaQuery.of(context).size.width - 2 * kHPadding,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: InkWell(
            onTap: () {},
            hoverColor: Theme.of(context).hoverColor,
            splashColor: Theme.of(context).splashColor,
            highlightColor: Theme.of(context).highlightColor,
            child: Text(
              AppLocalizations.of(context)!.pdDetailsGetDirection +
                  ' Google Map',
              textScaleFactor: displayScaleFactor,
              style: AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context)
                      .primaryTextTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).hintColor)
                  : Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ],
    );
  }
}
