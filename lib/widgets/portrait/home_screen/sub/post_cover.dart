import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

class PostCover extends StatefulWidget {
  final List<String> imageUrls;

  const PostCover({Key? key, required this.imageUrls}) : super(key: key);

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
                    child: widget.imageUrls.elementAt(index).split('/').first ==
                            'assets'
                        ? Image(
                            width: MediaQuery.of(context).size.width -
                                2 * kHPadding,
                            image:
                                AssetImage(widget.imageUrls.elementAt(index)),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            width: MediaQuery.of(context).size.width -
                                2 * kHPadding,
                            imageUrl: widget.imageUrls.elementAt(index),
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/travenx_180.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/travenx.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                );
              },
              itemCount: widget.imageUrls.length,
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
                '${_imagesIndex + 1}/${widget.imageUrls.length}',
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
