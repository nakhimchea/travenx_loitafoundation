import 'dart:io' show Platform, File;
import 'dart:ui' show ImageFilter;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/services/image_picker_service.dart';
import 'package:travenx_loitafoundation/services/storage_service.dart';
import 'package:travenx_loitafoundation/widgets/loading_dialog.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/stepper_navigation_button.dart';

class PostGallery extends StatefulWidget {
  final String currentPostId;
  const PostGallery({Key? key, required this.currentPostId}) : super(key: key);

  @override
  State<PostGallery> createState() => _PostGalleryState();
}

class _PostGalleryState extends State<PostGallery> {
  List<XFile> _imagesFile = [];

  void _imagePicker(XFile file, {bool? isRemoved}) => setState(() {
        isRemoved == null
            ? _imagesFile.add(file)
            : !isRemoved
                ? _imagesFile = []
                : _imagesFile.remove(file);
      });

  List<String> _imageUrls = [];

  void retrieveGallery() async {
    _imageUrls =
        await FirestoreService().readGallery(widget.currentPostId).then((list) {
      List<String> convertedList = [];
      list.forEach((element) => convertedList.add(element.toString()));
      return convertedList;
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retrieveGallery();
  }

  Widget _imageCard(BuildContext context, String imageUrl,
          {required double hPadding}) =>
      Padding(
        padding: EdgeInsets.only(right: hPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: imageUrl.split('/').first == 'assets'
              ? Image.asset(
                  imageUrl,
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.cover,
                  placeholder: (context, _) => ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.asset(
                      'assets/images/travenx_180.png',
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  errorWidget: (context, _, __) => Image.asset(
                    'assets/images/travenx.png',
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kHPadding, vertical: kVPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.pdGalleryLabel,
                textScaleFactor: textScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.titleLarge
                    : Theme.of(context).textTheme.titleLarge,
              ),
              Visibility(
                visible: _imageUrls.length != 0,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => _CustomDialog(
                        postId: widget.currentPostId,
                        refreshCallback: retrieveGallery,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        CustomOutlinedIcons.new_icon,
                        color: Theme.of(context).hintColor,
                        size: 18,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        AppLocalizations.of(context)!.pdGalleryUploadLabel,
                        textScaleFactor: textScaleFactor,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: _imageUrls.length > 0
              ? MediaQuery.of(context).size.width / 3
              : null,
          child: _imageUrls.length > 0
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _imageUrls.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final double _hPadding = 8;
                    if (index == 0)
                      return Padding(
                        padding: const EdgeInsets.only(left: kHPadding),
                        child: _imageCard(context, _imageUrls.elementAt(index),
                            hPadding: _hPadding),
                      );
                    else if (index == _imageUrls.length - 1)
                      return Padding(
                        padding: EdgeInsets.only(right: kHPadding - _hPadding),
                        child: _imageCard(context, _imageUrls.elementAt(index),
                            hPadding: _hPadding),
                      );
                    else
                      return _imageCard(context, _imageUrls.elementAt(index),
                          hPadding: _hPadding);
                  },
                )
              : _PostGalleryPicker(
                  postId: widget.currentPostId,
                  refreshCallback: retrieveGallery,
                  imagesFile: _imagesFile,
                  pickerCallback: _imagePicker,
                ),
        ),
        _imageUrls.length > 0
            ? GestureDetector(
                onTap: () => print('Button clicked....'),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: kVPadding),
                  child: Text(
                    AppLocalizations.of(context)!.pdShowAllLabel,
                    textScaleFactor: textScaleFactor,
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
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _CustomDialog extends StatefulWidget {
  final String postId;
  final void Function() refreshCallback;
  const _CustomDialog({
    Key? key,
    required this.postId,
    required this.refreshCallback,
  }) : super(key: key);

  @override
  State<_CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<_CustomDialog> {
  List<XFile> _imagesFile = [];

  void _imagePicker(XFile file, {bool? isRemoved}) => setState(() {
        isRemoved == null
            ? _imagesFile.add(file)
            : !isRemoved
                ? _imagesFile = []
                : _imagesFile.remove(file);
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            child: _PostGalleryPicker(
              isDialog: true,
              postId: widget.postId,
              refreshCallback: widget.refreshCallback,
              imagesFile: _imagesFile,
              pickerCallback: _imagePicker,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostGalleryPicker extends StatelessWidget {
  final bool isDialog;
  final String postId;
  final void Function() refreshCallback;
  final List<XFile> imagesFile;
  final void Function(XFile, {bool? isRemoved}) pickerCallback;
  const _PostGalleryPicker({
    Key? key,
    this.isDialog = false,
    required this.postId,
    required this.refreshCallback,
    required this.imagesFile,
    required this.pickerCallback,
  }) : super(key: key);

  final double _spacing = 10.0;

  List<Widget> _buildPicker(BuildContext context, double imageSize) {
    return List.generate(
      imagesFile.length + 1,
      (index) {
        if (index == imagesFile.length)
          return GestureDetector(
            onTap: () async =>
                await ImagePickerService.addImage(pickerCallback),
            child: Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(
                CustomOutlinedIcons.add,
                size: imageSize / 2,
                color: Theme.of(context).disabledColor,
              ),
            ),
          );
        else {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(1.0),
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: kIsWeb
                      ? Image.network(
                          imagesFile.elementAt(index).path,
                          fit: BoxFit.cover,
                        )
                      : Platform.isIOS
                          ? Image.asset(
                              imagesFile.elementAt(index).path,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagesFile.elementAt(index).path),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: GestureDetector(
                  onTap: () => pickerCallback(
                    imagesFile.elementAt(index),
                    isRemoved: true,
                  ),
                  child: Container(
                    height:
                        (MediaQuery.of(context).size.width - (4 * kHPadding)) /
                            18,
                    width:
                        (MediaQuery.of(context).size.width - (4 * kHPadding)) /
                            18,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Icon(
                      CustomOutlinedIcons.delete,
                      size: (MediaQuery.of(context).size.width -
                              (4 * kHPadding)) /
                          18,
                      color: Theme.of(context).errorColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kHPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: kHPadding, vertical: kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.pdGalleryUploadLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.displayMedium
                : Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: kVPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: _spacing,
              runSpacing: _spacing,
              children: _buildPicker(
                  context,
                  (MediaQuery.of(context).size.width -
                          4 * kHPadding -
                          3 * _spacing) /
                      4),
            ),
          ),
          const SizedBox(height: kVPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kVPadding),
              child: Text(
                AppLocalizations.of(context)!.pdGallerySharePublic,
                textScaleFactor: textScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.bodyMedium
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 3 * kHPadding,
                child: StepperNavigationButton(
                  backgroundColor: Theme.of(context).disabledColor,
                  label: AppLocalizations.of(context)!.pdCancelLabel,
                  textStyle: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyLarge,
                  onPressed: () {
                    pickerCallback(XFile(''), isRemoved: false);
                    if (isDialog) Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 3 * kHPadding,
                child: StepperNavigationButton(
                  backgroundColor: imagesFile.length == 0
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).primaryColor,
                  label: AppLocalizations.of(context)!.pdUploadLabel,
                  textStyle: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                          color: imagesFile.length != 0 ? Colors.white : null)
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: imagesFile.length != 0 ? Colors.white : null),
                  onPressed: () async {
                    final User? _currentUser =
                        FirebaseAuth.instance.currentUser;
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => LoadingDialog(),
                    );
                    if (imagesFile.length != 0) {
                      try {
                        final List<String> imageUrls = await StorageService()
                            .uploadGalleryImages(
                                ownerId: _currentUser!.uid,
                                postId: postId,
                                imagesFile: imagesFile);
                        await FirestoreService().setGalleryImages(
                            postId, _currentUser.uid, imageUrls);
                      } catch (e) {
                        print('Unknown error: $e');
                      }
                    }
                    refreshCallback();
                    Navigator.pop(context);
                    if (isDialog) Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
