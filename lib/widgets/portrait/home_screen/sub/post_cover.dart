import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class PostCover extends StatefulWidget {
  final PostObject post;

  const PostCover({Key? key, required this.post}) : super(key: key);

  @override
  _PostCoverState createState() => _PostCoverState();
}

class _PostCoverState extends State<PostCover> {
  final imagesController = PageController(viewportFraction: 1);

  int _imagesIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 2 * kHPadding,
          child: NotificationListener<ScrollUpdateNotification>(
            child: PageView.builder(
              controller: imagesController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      image: AssetImage(widget.post.imageUrls.elementAt(index)),
                      width: MediaQuery.of(context).size.width - 2 * kHPadding,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: widget.post.imageUrls.length,
            ),
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                setState(() {
                  _imagesIndex = ((imagesController.position.pixels -
                              MediaQuery.of(context).size.width / 1.2) /
                          imagesController.position.viewportDimension)
                      .ceil();
                });
              }
              return true;
            },
          ),
        ),
        Positioned(
          right: 27.0,
          bottom: 7.0,
          child: Container(
            height: 31.0,
            width: 54.0,
            decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  offset: Offset(0, 2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${_imagesIndex + 1}/${widget.post.imageUrls.length}',
                textScaleFactor: textScaleFactor,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
