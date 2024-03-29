import 'dart:ui' show ImageFilter;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/rating_uploader.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/loading_dialog.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/stepper_navigation_button.dart';

class PostRatings extends StatefulWidget {
  final String currentPostId;
  const PostRatings({Key? key, required this.currentPostId}) : super(key: key);

  @override
  State<PostRatings> createState() => _PostRatingsState();
}

class _PostRatingsState extends State<PostRatings> {
  final FirestoreService _firestoreService = FirestoreService();
  final double _vPadding = 10;

  List<String> _profileUrls = [];
  List<String> _displayNames = [];
  List<int> _ratings = [];
  List<DateTime> _dateTimes = [];
  List<String> _comments = [];
  List<List<int>> _expressions = [];

  void getRatings() async {
    await _firestoreService
        .readRatings(widget.currentPostId)
        .then((ratings) async {
      for (int index = 0; index < ratings.length; index++)
        if (index < 2) {
          await _firestoreService
              .getProfileData(ratings.elementAt(index)['uid'])
              .then((documentSnapshot) {
            _profileUrls.add(documentSnapshot.get('profileUrl'));
            _displayNames.add(documentSnapshot.get('displayName'));
          });
          _ratings
              .add(int.parse(ratings.elementAt(index)['rating'].toString()));
          _dateTimes.add(DateTime.fromMillisecondsSinceEpoch(
              int.parse(ratings.elementAt(index)['dateTime'].toString())));
          _comments.add(ratings.elementAt(index)['comment'].toString());
          _expressions.add(_firestoreService.getRatingExpression(
              ratings, ratings.elementAt(index)['uid'].toString()));
          setState(() {});
        }
    });
  }

  @override
  void initState() {
    super.initState();
    getRatings();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kHPadding, vertical: _vPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.pdReviewLabel,
                textScaleFactor: textScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.titleLarge
                    : Theme.of(context).textTheme.titleLarge,
              ),
              Visibility(
                visible: _ratings.isNotEmpty,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => _CustomDialog(
                        postId: widget.currentPostId,
                        refreshCallback: getRatings,
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
                        AppLocalizations.of(context)!.pdReviewAddLabel,
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
        _ratings.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: kVPadding),
                child: _PostRatingFields(
                    refreshCallback: getRatings,
                    currentPostId: widget.currentPostId),
              )
            : Column(
                children: [
                  _RatingCard(
                      profileUrl: _profileUrls.first,
                      displayName: _displayNames.first,
                      rating: _ratings.first,
                      date: _dateTimes.first,
                      comment: _comments.first,
                      imageUrls: [],
                      likes:
                          _expressions.isEmpty ? 0 : _expressions.first.first,
                      dislikes:
                          _expressions.isEmpty ? 0 : _expressions.first.last),
                  SizedBox(height: _ratings.length != 1 ? _vPadding : 0),
                  _ratings.length != 1
                      ? _RatingCard(
                          profileUrl: _profileUrls.last,
                          displayName: _displayNames.last,
                          rating: _ratings.last,
                          date: _dateTimes.last,
                          comment: _comments.last,
                          imageUrls: [],
                          likes: _expressions.isEmpty
                              ? 0
                              : _expressions.last.first,
                          dislikes:
                              _expressions.isEmpty ? 0 : _expressions.last.last)
                      : const SizedBox.shrink(),
                  GestureDetector(
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
                  ),
                ],
              ),
      ],
    );
  }
}

class _CustomDialog extends StatelessWidget {
  final String postId;
  final void Function() refreshCallback;
  const _CustomDialog({
    Key? key,
    required this.postId,
    required this.refreshCallback,
  }) : super(key: key);

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
            child: _PostRatingFields(
              isDialog: true,
              currentPostId: postId,
              refreshCallback: refreshCallback,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostRatingFields extends StatefulWidget {
  final bool isDialog;
  final void Function() refreshCallback;
  final String currentPostId;
  const _PostRatingFields({
    Key? key,
    this.isDialog = false,
    required this.refreshCallback,
    required this.currentPostId,
  }) : super(key: key);

  @override
  State<_PostRatingFields> createState() => _PostRatingFieldsState();
}

class _PostRatingFieldsState extends State<_PostRatingFields> {
  TextEditingController _commentController = TextEditingController();

  int currentRatings = 0;

  void _updateRatings(int ratings) => setState(() => currentRatings = ratings);

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
            AppLocalizations.of(context)!.pdReviewAddLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.displayMedium
                : Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 5.0),
          Text(
            AppLocalizations.of(context)!.pdReviewInstruction,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyLarge
                : Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: kVPadding),
          _RateButton(
              currentRatings: currentRatings, ratingCallback: _updateRatings),
          const SizedBox(height: kVPadding),
          TextField(
            controller: _commentController,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryIconTheme.color,
                    fontSize: 14 * textScaleFactor)
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryIconTheme.color,
                    fontSize: 14 * textScaleFactor),
            minLines: 5,
            maxLines: 24,
            textAlign: TextAlign.justify,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
              hintText: AppLocalizations.of(context)!.pdReviewCommentHint,
              hintStyle: AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14 * textScaleFactor)
                  : Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14 * textScaleFactor),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kVPadding),
              child: Text(
                AppLocalizations.of(context)!.pdReviewSharePublic,
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
                    _updateRatings(0);
                    _commentController.clear();
                    if (widget.isDialog) Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 3 * kHPadding,
                child: StepperNavigationButton(
                  backgroundColor: currentRatings == 0
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).primaryColor,
                  label: AppLocalizations.of(context)!.postLabel,
                  textStyle: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                          color: currentRatings != 0 ? Colors.white : null)
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: currentRatings != 0 ? Colors.white : null),
                  onPressed: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => LoadingDialog(),
                    );
                    if (currentRatings != 0) {
                      final RatingUploader _uploader = RatingUploader(
                          comment: _commentController.text.trim(),
                          rating: currentRatings,
                          postId: widget.currentPostId);
                      await _uploader.pushRating();
                    }
                    _updateRatings(0);
                    _commentController.clear();
                    widget.refreshCallback();
                    Navigator.pop(context);
                    if (widget.isDialog) Navigator.pop(context);
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

class _RateButton extends StatelessWidget {
  final int currentRatings;
  final void Function(int) ratingCallback;
  const _RateButton({
    Key? key,
    required this.currentRatings,
    required this.ratingCallback,
  }) : super(key: key);

  _buildRates(BuildContext context) {
    return List.generate(
      currentRatings,
      (index) => GestureDetector(
        onTap: () => ratingCallback(index + 1),
        child: Icon(
          CustomFilledIcons.star,
          size: 45 * textScaleFactor,
          color: Theme.of(context).highlightColor,
        ),
      ),
    )..addAll(
        List.generate(
          5 - currentRatings,
          (index) => GestureDetector(
            onTap: () => ratingCallback(currentRatings + index + 1),
            child: Icon(
              CustomFilledIcons.star,
              size: 45 * textScaleFactor,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRates(context),
    );
  }
}

class _RatingCard extends StatelessWidget {
  final String profileUrl;
  final String displayName;
  final int rating;
  final DateTime date;
  final String comment;
  final List<String> imageUrls;
  final int likes;
  final int dislikes;
  const _RatingCard({
    Key? key,
    required this.profileUrl,
    required this.displayName,
    required this.rating,
    required this.date,
    required this.comment,
    required this.imageUrls,
    required this.likes,
    required this.dislikes,
  }) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () => print('Profile Clicked...'),
                  child: ClipOval(
                    child: profileUrl.split('/').first == 'assets'
                        ? Image.asset(
                            profileUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: profileUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/travenx_180.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/travenx_180.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      textScaleFactor: textScaleFactor,
                      style: AppLocalizations.of(context)!.localeName == 'km'
                          ? Theme.of(context).primaryTextTheme.titleLarge
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            rating,
                            (index) => Icon(
                              CustomFilledIcons.star,
                              color: Theme.of(context).highlightColor,
                              size: 16,
                            ),
                          )..addAll(
                              List.generate(
                                5 - rating,
                                (index) => Icon(
                                  CustomOutlinedIcons.star,
                                  color: Theme.of(context).highlightColor,
                                  size: 16,
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '០២-០៧-២០២១',
                          textScaleFactor: textScaleFactor,
                          style: AppLocalizations.of(context)!.localeName ==
                                  'km'
                              ? Theme.of(context).primaryTextTheme.bodyMedium
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_horiz,
                size: 32,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ],
          ),
          SizedBox(height: comment == '' ? 0 : kVPadding),
          Text(
            comment,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyLarge
                : Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: comment == '' ? 0 : kVPadding),
          Row(
            children: [
              _ExpressionButton(
                number: likes,
                isLikeButton: true,
                isClicked: true,
              ),
              const SizedBox(width: kHPadding),
              _ExpressionButton(
                number: dislikes,
                isLikeButton: false,
                isClicked: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpressionButton extends StatelessWidget {
  final int number;
  final bool isLikeButton;
  final bool isClicked;
  const _ExpressionButton({
    Key? key,
    required this.number,
    required this.isLikeButton,
    required this.isClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isClicked
            ? isLikeButton
                ? Theme.of(context).primaryColor
                : Theme.of(context).errorColor
            : Theme.of(context).disabledColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 40,
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLikeButton
                ? CustomOutlinedIcons.like
                : CustomOutlinedIcons.dislike,
            size: 20,
            color: isClicked
                ? Theme.of(context).canvasColor
                : Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 5),
          Text(
            number.toString(),
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                    color: isClicked
                        ? Theme.of(context).bottomAppBarColor
                        : Theme.of(context).iconTheme.color)
                : Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isClicked
                        ? Theme.of(context).bottomAppBarColor
                        : Theme.of(context).iconTheme.color),
          ),
        ],
      ),
    );
  }
}
