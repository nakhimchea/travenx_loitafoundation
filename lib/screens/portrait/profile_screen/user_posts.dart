import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, descriptionIconSize;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/post_detail.dart';
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
  DocumentSnapshot? _lastDoc; //TODO

  double _spacing = 10.0;
  bool _isLoading = true;

  void getData() async {
    postList = postTranslator(await _firestoreService
        .getProvinceData('ភ្នំពេញ', _lastDoc)
        .then((snapshot) => snapshot.docs));
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
            onPressed: () {}, //TODO: Push user to Edit Screen
            padding: const EdgeInsets.symmetric(horizontal: kHPadding),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              CustomFilledIcons.new_icon,
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
            : _buildPostList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFloatingActionButton(
        onTap: () {}, //TODO: Push user to Add Post
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

class _PostCard extends StatelessWidget {
  final PostObject post;
  final double spacing;
  const _PostCard({Key? key, required this.post, this.spacing = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetail(post: post),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6.16,
            width:
                ((MediaQuery.of(context).size.width - spacing) / 2) - kHPadding,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image(
                image: AssetImage(post.imageUrls.elementAt(0)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height / 9.8,
            width:
                ((MediaQuery.of(context).size.width - spacing) / 2) - kHPadding,
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
                      post.title,
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
                            (post.state == 'ភ្នំពេញ' ? 'រាជធានី' : 'ខេត្ត') +
                                post.state +
                                ' ' +
                                post.country,
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
                                post.ratings.toStringAsFixed(1),
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
                                post.views.toString(),
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
                    post.price == 0
                        ? 'Free'
                        : '\$${post.price % 1 == 0 ? post.price.toStringAsFixed(0) : post.price.toStringAsFixed(1)}',
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