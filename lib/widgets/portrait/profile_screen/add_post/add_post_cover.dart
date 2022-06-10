import 'dart:io' show Platform, File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;

class AddPostCover extends StatefulWidget {
  final List<XFile> imagesFile;
  const AddPostCover({Key? key, required this.imagesFile}) : super(key: key);

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
                            widget.imagesFile.elementAt(index).path,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          )
                        : Platform.isIOS
                            ? Image.asset(
                                widget.imagesFile.elementAt(index).path,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              )
                            : Image.file(
                                File(widget.imagesFile.elementAt(index).path),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                  ),
                );
              },
              itemCount: widget.imagesFile.length,
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
              color: Theme.of(context).canvasColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${_imagesIndex + 1}/${widget.imagesFile.length}',
                textScaleFactor: displayScaleFactor,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
