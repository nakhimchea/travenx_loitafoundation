import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/add_post.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/custom_floating_action_button.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  final FirestoreService _firestoreService = FirestoreService();

  List<PostObject> postList = [];

  double _spacing = 10.0;
  bool _isLoading = true;

  void getData() async {
    postList = postTranslator(await _firestoreService
        .getUserPosts(FirebaseAuth.instance.currentUser!.uid));
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
            size: 18.0,
          ),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        title: Text(
          'ទីតាំង ឬអាជីវកម្មបានបង្ហោះ',
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            onPressed: () {}, //TODO: Stack user to Delete Icon
            padding: const EdgeInsets.symmetric(horizontal: kHPadding),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              CustomOutlinedIcons.trash,
              size: 24.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHPadding),
        child: _isLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : postList.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CustomOutlinedIcons.warning,
                          size: 24.0,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'មិនមានទិន្នន័យអំពីទីតាំង ឬអាជិវកម្មរបស់អ្នក។',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10),
                      ],
                    ),
                  )
                : _buildPostList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddPost()));
        },
        iconData: Icons.add,
        iconColor: Colors.white,
        iconSize: 28.0,
        buttonColor: Theme.of(context).primaryColor,
        buttonSize: 48.0,
      ),
    );
  }

  Widget _buildPostList() => postList.length % 2 == 1
      ? ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: postList.length ~/ 2 + 1,
          itemBuilder: (BuildContext context, int index) =>
              index == 0 && postList.length == 1
                  ? Padding(
                      padding: EdgeInsets.only(top: kHPadding),
                      child: _PostCard(
                        post: postList.elementAt(index * 2),
                        spacing: _spacing,
                      ),
                    )
                  : index == 0 && postList.length > 1
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: kHPadding, bottom: _spacing),
                          child: Row(
                            children: [
                              _PostCard(
                                post: postList.elementAt(index * 2),
                                spacing: _spacing,
                              ),
                              SizedBox(width: _spacing),
                              _PostCard(
                                post: postList.elementAt(index * 2 + 1),
                                spacing: _spacing,
                              ),
                            ],
                          ),
                        )
                      : index == (postList.length - 1) ~/ 2
                          ? Padding(
                              padding: EdgeInsets.only(bottom: kHPadding),
                              child: _PostCard(
                                post: postList.elementAt(index * 2),
                                spacing: _spacing,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(bottom: _spacing),
                              child: Row(
                                children: [
                                  _PostCard(
                                    post: postList.elementAt(index * 2),
                                    spacing: _spacing,
                                  ),
                                  SizedBox(width: _spacing),
                                  _PostCard(
                                    post: postList.elementAt(index * 2 + 1),
                                    spacing: _spacing,
                                  ),
                                ],
                              ),
                            ),
        )
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: postList.length ~/ 2,
          itemBuilder: (BuildContext context, int index) => index == 0
              ? Padding(
                  padding: EdgeInsets.only(top: kHPadding, bottom: _spacing),
                  child: Row(
                    children: [
                      _PostCard(
                        post: postList.elementAt(index * 2),
                        spacing: _spacing,
                      ),
                      SizedBox(width: _spacing),
                      _PostCard(
                        post: postList.elementAt(index * 2 + 1),
                        spacing: _spacing,
                      ),
                    ],
                  ),
                )
              : index == postList.length ~/ 2 - 1
                  ? Padding(
                      padding: EdgeInsets.only(bottom: kHPadding),
                      child: Row(
                        children: [
                          _PostCard(
                            post: postList.elementAt(index * 2),
                            spacing: _spacing,
                          ),
                          SizedBox(width: _spacing),
                          _PostCard(
                            post: postList.elementAt(index * 2 + 1),
                            spacing: _spacing,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(bottom: _spacing),
                      child: Row(
                        children: [
                          _PostCard(
                            post: postList.elementAt(index * 2),
                            spacing: _spacing,
                          ),
                          SizedBox(width: _spacing),
                          _PostCard(
                            post: postList.elementAt(index * 2 + 1),
                            spacing: _spacing,
                          ),
                        ],
                      ),
                    ),
        );
}

class _PostCard extends StatefulWidget {
  final PostObject post;
  final double spacing;
  const _PostCard({Key? key, required this.post, this.spacing = 10})
      : super(key: key);

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  int _views = 0;
  double _ratings = 5;

  void _getViews() async {
    _views = await FirestoreService()
        .readViews(widget.post.postId)
        .then((viewers) => viewers.length);
  }

  void _getRatings() async {
    _ratings = await FirestoreService().getRatingRate(widget.post.postId);
  }

  @override
  void initState() {
    super.initState();
    _getViews();
    _getRatings();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(
            post: widget.post,
            views: _views,
            ratings: _ratings,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6.16,
            width: ((MediaQuery.of(context).size.width - widget.spacing) / 2) -
                kHPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: widget.post.imageUrls.elementAt(0).split('/').first ==
                      'assets'
                  ? Image.asset(
                      widget.post.imageUrls.elementAt(0),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.post.imageUrls.elementAt(0),
                      fit: BoxFit.cover,
                      placeholder: (context, _) => ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height / 9.8,
            width: ((MediaQuery.of(context).size.width - widget.spacing) / 2) -
                kHPadding,
            decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.headline4,
                      overflow:
                          kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          CustomFilledIcons.location,
                          color: Theme.of(context).primaryColor,
                          size: descriptionIconSize,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            (widget.post.state == 'ភ្នំពេញ'
                                    ? 'រាជធានី'
                                    : 'ខេត្ត') +
                                widget.post.state +
                                ' ' +
                                widget.post.country,
                            textScaleFactor: textScaleFactor,
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: kIsWeb
                                ? TextOverflow.clip
                                : TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CustomFilledIcons.star,
                              color: Theme.of(context).highlightColor,
                              size: descriptionIconSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                _ratings.toStringAsFixed(1),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context).textTheme.headline5,
                                overflow: kIsWeb
                                    ? TextOverflow.clip
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              CustomOutlinedIcons.view,
                              color: Theme.of(context).hintColor,
                              size: descriptionIconSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                _views.toString(),
                                textScaleFactor: textScaleFactor,
                                style: Theme.of(context).textTheme.subtitle2,
                                overflow: kIsWeb
                                    ? TextOverflow.clip
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 40.0,
                  right: 0.0,
                  child: Text(
                    widget.post.price == 0
                        ? 'Free'
                        : '\$${widget.post.price % 1 == 0 ? widget.post.price.toStringAsFixed(0) : widget.post.price.toStringAsFixed(1)}',
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
