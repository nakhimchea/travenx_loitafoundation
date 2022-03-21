import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, selectedIndex;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/chat_screen/chat.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

final FirestoreService _firestoreService = FirestoreService();

class ChatScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String profileUrl;
  final void Function() loggedInCallback;
  const ChatScreen({
    Key? key,
    required this.isLoggedIn,
    required this.displayName,
    required this.profileUrl,
    required this.loggedInCallback,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static int chatLoadSize = 2;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<String> _chatPostIds = [];
  List<String> _chatPostsImageUrl = [];
  List<String> _chatPostsTitle = [];
  List<String> _chatWithUserIds = [];
  List<String> _chatWithDisplayNames = [];
  List<String> _chatWithPhoneNumbers = [];
  List<String> _chatWithProfileUrls = [];
  List<dynamic> _selfPostIds = [];

  bool _isRefreshable = true;
  int loadingTimes = 1;
  int? chatCount;
  int addTimes = 0;

  List<String> buildChatPostIds = [];

  String _savedUser = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser!.uid
      : '';

  Widget _buildList() {
    if (buildChatPostIds.length != _chatPostsTitle.length ||
        buildChatPostIds.length != _chatPostsImageUrl.length)
      return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHPadding,
        vertical: kVPadding,
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _chatPostsTitle.length,
        itemBuilder: (BuildContext context, int index) {
          return _BuildChatItem(
            postImageUrl: _chatPostsImageUrl.elementAt(index),
            postTitle: _chatPostsTitle.elementAt(index),
            currentUserDisplayName: widget.displayName,
            currentUserProfileUrl: widget.profileUrl,
            postId: buildChatPostIds.elementAt(index),
            withUserId: _chatWithUserIds.elementAt(index),
            withDisplayName: _chatWithDisplayNames.elementAt(index),
            withPhoneNumber: _chatWithPhoneNumbers.elementAt(index),
            withProfileUrl: _chatWithProfileUrls.elementAt(index),
            selfPostIds: _selfPostIds.toString(),
          );
        },
      ),
    );
  }

  Widget loadingBuilder(BuildContext context, LoadStatus? mode) {
    Widget _footer;

    if (mode == LoadStatus.idle)
      _footer = Center(
        child: Icon(
          Icons.keyboard_arrow_up_outlined,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.loading)
      _footer = Center(
        child: SpinKitFadingCircle(
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.failed)
      _footer = Center(
        child: Icon(
          Icons.error_outline_outlined,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else if (mode == LoadStatus.canLoading)
      _footer = Center(
        child: SpinKitFadingCircle(
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    else
      _footer = Center(
        child: Icon(
          Icons.info_outline,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );

    return _footer;
  }

  void refreshChatScreen(User currentUser) => setState(() {
        _chatPostIds = [];
        _chatPostsImageUrl = [];
        _chatPostsTitle = [];
        _chatWithUserIds = [];
        _chatWithDisplayNames = [];
        _chatWithPhoneNumbers = [];
        _chatWithProfileUrls = [];
        _selfPostIds = [];
        _isRefreshable = true;
        loadingTimes = 1;
        chatCount = null;
        addTimes = 0;
        buildChatPostIds = [];
        _savedUser = currentUser.uid;
      });

  @override
  Widget build(BuildContext context) {
    final User? _user = FirebaseAuth.instance.currentUser;
    if (_user != null) if (_user.uid != _savedUser) refreshChatScreen(_user);

    if (widget.isLoggedIn == true && widget.displayName != '') {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          shadowColor: Theme.of(context).disabledColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'សារ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: false,
          actions: [ActionOptions()],
        ),
        body: StreamBuilder(
          stream: _firestoreService.streamProfile(_user!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator.adaptive());
            if (!snapshot.data!.exists)
              return Center(
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
                      'មិនមានទិន្នន័យសារ។',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                  ],
                ),
              );

            final List<dynamic> _chats = snapshot.data!.get('chats');
            final List<Map<String, dynamic>> _reversedChats =
                _chats.cast<Map<String, dynamic>>().reversed.toList();

            _selfPostIds = snapshot.data!.get('postIds');

            _chatPostIds =
                _reversedChats.map<String>((chat) => chat['postId']).toList();
            _chatWithUserIds = _reversedChats
                .map<String>((chat) => chat['withUserId'])
                .toList();
            _chatWithDisplayNames = _reversedChats
                .map<String>((chat) => chat['withDisplayName'])
                .toList();
            _chatWithPhoneNumbers = _reversedChats
                .map<String>((chat) => chat['withPhoneNumber'])
                .toList();
            _chatWithProfileUrls = _reversedChats
                .map<String>((chat) => chat['withProfileUrl'])
                .toList();

            if (chatCount != null) {
              if (chatCount != _chats.length) {
                buildChatPostIds.insert(0, _chatPostIds.first);
                _firestoreService
                    .getPostData(_chatPostIds.first)
                    .then((snapshot) {
                  _chatPostsImageUrl.insert(
                      0, snapshot.get('imageUrls')[0].toString());
                  _chatPostsTitle.insert(0, snapshot.get('title').toString());
                  setState(() => addTimes++);
                });
              }
            }
            chatCount = _chats.length;

            return SmartRefresher(
              controller: _refreshController,
              physics: BouncingScrollPhysics(),
              enablePullDown: _isRefreshable,
              enablePullUp: true,
              child: _chatPostIds.length == 0
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
                            'មិនមានទិន្នន័យសារ។',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 10),
                        ],
                      ),
                    )
                  : _buildList(),
              header: CustomHeader(builder: (_, __) => SizedBox.shrink()),
              footer: CustomFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                builder: loadingBuilder,
              ),
              onRefresh: () async {
                assert(_chatPostIds.length == _chatWithUserIds.length);
                for (int index = 0; index < _chatPostIds.length; index++)
                  if (index < chatLoadSize) {
                    buildChatPostIds.add(_chatPostIds.elementAt(index));
                    await _firestoreService
                        .getPostData(_chatPostIds.elementAt(index))
                        .then((snapshot) {
                      _chatPostsImageUrl
                          .add(snapshot.get('imageUrls')[0].toString());
                      _chatPostsTitle.add(snapshot.get('title').toString());
                    });
                  }

                if (mounted) setState(() => _isRefreshable = false);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (loadingTimes * chatLoadSize + addTimes <
                    _chatPostIds.length) {
                  setState(() => loadingTimes++);
                  for (int index = (loadingTimes - 1) * chatLoadSize + addTimes;
                      index < _chatPostIds.length;
                      index++)
                    if (index < loadingTimes * chatLoadSize + addTimes) {
                      buildChatPostIds.add(_chatPostIds.elementAt(index));
                      await _firestoreService
                          .getPostData(_chatPostIds.elementAt(index))
                          .then((snapshot) {
                        _chatPostsImageUrl
                            .add(snapshot.get('imageUrls')[0].toString());
                        _chatPostsTitle.add(snapshot.get('title').toString());
                      });
                    }
                }
                if (mounted) setState(() {});
                _refreshController.loadComplete();
              },
            );
          },
        ),
      );
    } else
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile_screen/scaffold_background.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Screen is logged.'),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedIndex = 3;
                      if (widget.isLoggedIn != false) widget.loggedInCallback();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login Now',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                ],
              ),
            ),
          ],
        ),
      );
  }
}

class ActionOptions extends StatelessWidget {
  const ActionOptions({Key? key}) : super(key: key);

  void _selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("First item Clicked...");
        break;
      case 1:
        print("Second item Clicked...");
        break;
      case 2:
        print("Third item Clicked...");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Scaffold()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kHPadding - 5),
      child: PopupMenuButton<int>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.zero,
        icon: CircleAvatar(
          radius: 20.2,
          backgroundColor: Colors.black26,
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor:
                Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Colors.white
                    : Color(0x1AFFFFFF),
            child: Icon(
              Icons.more_horiz,
              color: Theme.of(context).primaryIconTheme.color,
              size: 28.0,
            ),
          ),
        ),
        color: Theme.of(context).bottomAppBarColor,
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 0,
            child: PopUpListTile(
              iconData: Icons.logout,
              title: 'សន្មត់ថាបានអានទាំងអស់',
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 1,
            child: PopUpListTile(
              iconData: Icons.logout,
              title: 'សារដែលបានខ្ចប់',
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 2,
            child: PopUpListTile(
              iconData: Icons.logout,
              title: 'រាយការណ៍បញ្ហា',
            ),
          ),
        ],
        onSelected: (value) => _selectedItem(context, value),
      ),
    );
  }
}

class PopUpListTile extends StatelessWidget {
  final IconData iconData;
  final String title;

  const PopUpListTile({
    Key? key,
    required this.iconData,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 16.0,
          color: Theme.of(context).iconTheme.color,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).iconTheme.color),
            overflow: kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _BuildChatItem extends StatelessWidget {
  final String postImageUrl;
  final String postTitle;
  final String currentUserDisplayName;
  final String currentUserProfileUrl;
  final String postId;
  final String withUserId;
  final String withDisplayName;
  final String withPhoneNumber;
  final String withProfileUrl;
  final String selfPostIds;

  const _BuildChatItem({
    Key? key,
    required this.postImageUrl,
    required this.postTitle,
    required this.currentUserDisplayName,
    required this.currentUserProfileUrl,
    required this.postId,
    required this.withUserId,
    required this.withDisplayName,
    required this.withPhoneNumber,
    required this.withProfileUrl,
    required this.selfPostIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? _user = FirebaseAuth.instance.currentUser;

    final String chatImageUrl =
        selfPostIds.contains(postId) ? withProfileUrl : postImageUrl;
    final String chatTitle =
        selfPostIds.contains(postId) ? withDisplayName : postTitle;

    return _user != null
        ? GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chat(
                    postTitle: postTitle,
                    postImageUrl: postImageUrl,
                    userId: _user.uid,
                    userDisplayName: currentUserDisplayName,
                    userProfileUrl: currentUserProfileUrl,
                    postId: postId,
                    withUserId: withUserId,
                    withDisplayName: withDisplayName,
                    withPhoneNumber: withPhoneNumber,
                    withProfileUrl: withProfileUrl),
              ),
            ),
            child: StreamBuilder(
              stream: _firestoreService.getMessages(
                  _user.uid, postId, withUserId,
                  messageQuantity: 1),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    height: MediaQuery.of(context).size.height / 9,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).bottomAppBarColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const SizedBox.shrink(),
                    ),
                  );
                else if (snapshot.data!.docs.isEmpty)
                  return const SizedBox.shrink();

                final String chatMessage =
                    snapshot.data!.docs.single.get('message').toString();
                final DateTime chatDateTime =
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(snapshot.data!.docs.single.get('dateTime')));
                return Container(
                  height: MediaQuery.of(context).size.height / 9,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      dense: true,
                      leading: ClipOval(
                        child: chatImageUrl.split('/').first == 'assets'
                            ? Image.asset(
                                chatImageUrl,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: chatImageUrl,
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
                                  'assets/images/travenx_180.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: Text(
                          chatTitle,
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.headline3,
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatMessage,
                              textScaleFactor: textScaleFactor,
                              style: snapshot.data!.docs.single
                                          .get('senderUid') ==
                                      _user.uid
                                  ? Theme.of(context).textTheme.bodyText1
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                              overflow: kIsWeb
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                          chatMessage == ''
                              ? SizedBox.shrink()
                              : SizedBox(width: 20.0),
                          Text(
                            '${chatDateTime.hour.toString()}:' +
                                '${chatDateTime.minute < 10 ? '0' + chatDateTime.minute.toString() : chatDateTime.minute.toString()} ' +
                                '${chatDateTime.day.toString()}/' +
                                '${chatDateTime.month.toString()}/' +
                                '${chatDateTime.year.toString()}',
                            textScaleFactor: textScaleFactor,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: kIsWeb
                                ? TextOverflow.clip
                                : TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: snapshot.data!.docs.single.get('senderUid') ==
                              _user.uid
                          ? SizedBox.shrink()
                          : CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
