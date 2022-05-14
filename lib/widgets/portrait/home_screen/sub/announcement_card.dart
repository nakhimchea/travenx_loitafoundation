import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

class AnnouncementCard extends StatelessWidget {
  final String announcement;
  const AnnouncementCard({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('សេចក្ដីជូនដំណឹង ReadMore Clicked...'),
      child: Container(
        height: MediaQuery.of(context).size.height / 5.58,
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
                'សេចក្ដីជូនដំណឹង',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 16.0,
                      fontFamily: 'Nokora',
                    ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                textAlign: TextAlign.justify,
                maxLines: 6,
                textScaleFactor: textScaleFactor,
                overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                text: TextSpan(
                  text: '    ',
                  children: [
                    TextSpan(
                      text: this.announcement.length < 200
                          ? this.announcement
                          : this.announcement.substring(0, 200),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: ' ...',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: ' អានបន្ថែម',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Theme.of(context).hintColor),
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
