import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, Palette;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class AnnouncementCard extends StatelessWidget {
  final PostObject post;
  const AnnouncementCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('សេចក្ដីជូនដំណឹង ReadMore Clicked...'),
      child: Container(
        height: MediaQuery.of(context).size.height / 5.58,
        padding: const EdgeInsets.all(kHPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xFFFA8231)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: '    ',
                  children: [
                    TextSpan(
                      text: post.announcement!.substring(0, 200),
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: ' ∙∙∙',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: '   អានបន្ថែម',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Palette.tertiary),
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
