import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
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
          'លំអិត',
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 10.0),
        ReadMoreText(
          this.details.textDetail,
          textScaleFactor: textScaleFactor,
          trimLines: 5,
          textAlign: TextAlign.justify,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'អានបន្ថែម',
          trimExpandedText: 'រួចរាល់',
          style: Theme.of(context).textTheme.bodyText1,
          moreStyle: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Theme.of(context).hintColor),
          lessStyle: Theme.of(context)
              .textTheme
              .headline4!
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
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              'ចូលទៅកាន់ Google Map',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ],
    );
  }
}
