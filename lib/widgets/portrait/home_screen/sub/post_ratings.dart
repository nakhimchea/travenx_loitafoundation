import 'dart:ui' show ImageFilter;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                'វាយតម្លៃ',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.headline3,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CustomOutlinedIcons.new_icon,
                        color: Theme.of(context).hintColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'ដាក់វាយតម្លៃ',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
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
                child: PostRatingFields(
                    refreshCallback: getRatings,
                    currentPostId: widget.currentPostId),
              )
            : Column(
                children: [
                  RatingCard(
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
                      ? RatingCard(
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
                        'បង្ហាញទាំងអស់',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
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
            child: PostRatingFields(
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

class PostRatingFields extends StatefulWidget {
  final bool isDialog;
  final void Function() refreshCallback;
  final String currentPostId;
  const PostRatingFields({
    Key? key,
    this.isDialog = false,
    required this.refreshCallback,
    required this.currentPostId,
  }) : super(key: key);

  @override
  State<PostRatingFields> createState() => _PostRatingFieldsState();
}

class _PostRatingFieldsState extends State<PostRatingFields> {
  TextEditingController _commentController = TextEditingController();

  int currentRatings = 0;

  void _updateRatings(int ratings) => setState(() => currentRatings = ratings);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kHPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: kHPadding, vertical: kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Text(
            'ដាក់វាយតម្លៃ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 5.0),
          Text(
            'ចុចលើរូបផ្កាយដើម្បីវាយតម្លៃ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: kVPadding),
          RateButton(
              currentRatings: currentRatings, ratingCallback: _updateRatings),
          const SizedBox(height: kVPadding),
          TextField(
            controller: _commentController,
            style: Theme.of(context).textTheme.button!.copyWith(
                color: Theme.of(context).iconTheme.color,
                fontSize: 14 * textScaleFactor),
            minLines: 5,
            maxLines: 24,
            textAlign: TextAlign.justify,
            cursorColor: Theme.of(context).primaryColor,
            cursorHeight: 14 * textScaleFactor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
              hintText: 'បញ្ចេញមតិ',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
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
                'ការបញ្ចេញមតិនឹងត្រូវបង្ហោះជាសាធារណៈ។',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.bodyText1,
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
                  label: 'លុបចោល',
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  onPressed: () {
                    _updateRatings(0);
                    _commentController.clear();
                    if (widget.isDialog) Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: 44,
                width: MediaQuery.of(context).size.width / 2 - 3 * kHPadding,
                child: StepperNavigationButton(
                  backgroundColor: currentRatings == 0
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).primaryColor,
                  label: 'បង្ហោះ',
                  textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
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

class RateButton extends StatelessWidget {
  final int currentRatings;
  final void Function(int) ratingCallback;
  const RateButton({
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
          size: 42,
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
              size: 42,
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

class RatingCard extends StatelessWidget {
  final String profileUrl;
  final String displayName;
  final int rating;
  final DateTime date;
  final String comment;
  final List<String> imageUrls;
  final int likes;
  final int dislikes;
  const RatingCard({
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
      margin: EdgeInsets.symmetric(horizontal: kHPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: kHPadding, vertical: kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
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
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: profileUrl,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/travenx_180.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/travenx_180.png',
                              width: 35,
                              height: 35,
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
                      style: Theme.of(context).textTheme.headline3,
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
                              size: 12,
                            ),
                          )..addAll(
                              List.generate(
                                5 - rating,
                                (index) => Icon(
                                  CustomOutlinedIcons.star,
                                  color: Theme.of(context).highlightColor,
                                  size: 12,
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '០២-០៧-២០២១',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_horiz,
                size: 24,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ],
          ),
          SizedBox(height: comment == '' ? 0 : kVPadding),
          Text(
            comment,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: comment == '' ? 0 : kVPadding),
          Row(
            children: [
              ExpressionButton(
                number: likes,
                isLikeButton: true,
                isClicked: true,
              ),
              const SizedBox(width: kHPadding),
              ExpressionButton(
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

class ExpressionButton extends StatelessWidget {
  final int number;
  final bool isLikeButton;
  final bool isClicked;
  const ExpressionButton({
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
        borderRadius: BorderRadius.circular(15),
      ),
      height: 30,
      width: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLikeButton
                ? CustomOutlinedIcons.like
                : CustomOutlinedIcons.dislike,
            size: 15,
            color: isClicked
                ? Theme.of(context).bottomAppBarColor
                : Theme.of(context).primaryIconTheme.color,
          ),
          const SizedBox(width: 5),
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: isClicked
                    ? Theme.of(context).bottomAppBarColor
                    : Theme.of(context).primaryIconTheme.color),
          ),
        ],
      ),
    );
  }
}
