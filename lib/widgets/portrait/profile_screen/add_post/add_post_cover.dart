import 'dart:io' show Platform, File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

class AddPostCover extends StatefulWidget {
  final List<String> imageUrls;
  const AddPostCover({Key? key, required this.imageUrls}) : super(key: key);

  @override
  State<AddPostCover> createState() => _AddPostCoverState();
}

class _AddPostCoverState extends State<AddPostCover> {
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
                    child: kIsWeb
                        ? Image.network(
                            widget.imageUrls.elementAt(index),
                            fit: BoxFit.cover,
                          )
                        : Platform.isIOS
                            ? Image.asset(
                                widget.imageUrls.elementAt(index),
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(widget.imageUrls.elementAt(index)),
                                fit: BoxFit.cover,
                              ),
                  ),
                );
              },
              itemCount: widget.imageUrls.length,
            ),
            onNotification: (notification) {
              // ignore: unnecessary_type_check
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
