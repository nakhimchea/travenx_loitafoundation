import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;

class AnnouncementCard extends StatelessWidget {
  final String announcement;
  const AnnouncementCard({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('សេចក្ដីជូនដំណឹង ReadMore Clicked...'),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        padding: const EdgeInsets.all(kHPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xFFFA8231)),
        ),
        child: SingleChildScrollView(
          primary: false,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.pdAnnouncementLabel,
                textScaleFactor: displayScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context)
                        .primaryTextTheme
                        .titleLarge!
                        .copyWith(color: Color(0xFFFA8231))
                    : Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Color(0xFFFA8231)),
              ),
              const SizedBox(height: 5.0),
              RichText(
                textAlign: TextAlign.justify,
                maxLines: 6,
                textScaleFactor: displayScaleFactor,
                overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                text: TextSpan(
                  text: '    ',
                  children: [
                    TextSpan(
                      text: this.announcement.length < 75
                          ? this.announcement
                          : this.announcement.substring(0, 75),
                      style: AppLocalizations.of(context)!.localeName == 'km'
                          ? Theme.of(context).primaryTextTheme.bodyLarge
                          : Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: this.announcement.length < 75 ? '' : ' ...',
                          style:
                              AppLocalizations.of(context)!.localeName == 'km'
                                  ? Theme.of(context).primaryTextTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: this.announcement.length < 75
                                  ? ''
                                  : AppLocalizations.of(context)!.pdReadmore,
                              style: AppLocalizations.of(context)!.localeName ==
                                      'km'
                                  ? Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context).hintColor)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context).hintColor),
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
      ),
    );
  }
}
