import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHPadding,
        vertical: kVPadding,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
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

  Widget _loadingBuilder(BuildContext context, LoadStatus? mode) {
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

    if (widget.isLoggedIn == true && widget.displayName != '')
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          shadowColor: Theme.of(context).disabledColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context)!.chatLabel,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.displayLarge
                : Theme.of(context).textTheme.displayMedium,
          ),
          centerTitle: false,
          actions: [_ActionOptions()],
        ),
        body: StreamBuilder(
          stream: _firestoreService.streamProfile(_user!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator.adaptive());
            if (!snapshot.data!.exists)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CustomOutlinedIcons.warning,
                      size: 24.0 * textScaleFactor,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.chatNoData,
                      textScaleFactor: textScaleFactor,
                      style: AppLocalizations.of(context)!.localeName == 'km'
                          ? Theme.of(context).primaryTextTheme.bodyLarge
                          : Theme.of(context).textTheme.bodyLarge,
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
                      0, snapshot!.get('imageUrls')[0].toString());
                  _chatPostsTitle.insert(0, snapshot.get('title').toString());
                  setState(() => addTimes++);
                });
              }
            }
            chatCount = _chats.length;

            return SmartRefresher(
              controller: _refreshController,
              physics: const BouncingScrollPhysics(),
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
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.chatNoData,
                            textScaleFactor: textScaleFactor,
                            style: AppLocalizations.of(context)!.localeName ==
                                    'km'
                                ? Theme.of(context).primaryTextTheme.bodyLarge
                                : Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 10),
                        ],
                      ),
                    )
                  : _buildList(),
              header: CustomHeader(builder: (_, __) => const SizedBox.shrink()),
              footer: CustomFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                builder: _loadingBuilder,
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
                          .add(snapshot!.get('imageUrls')[0].toString());
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
                            .add(snapshot!.get('imageUrls')[0].toString());
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
    else {
      SystemChrome.setSystemUIOverlayStyle(
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light);
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/travenx.png',
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
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
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
}

class _ActionOptions extends StatelessWidget {
  const _ActionOptions({Key? key}) : super(key: key);

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
            .push(MaterialPageRoute(builder: (context) => const Scaffold()));
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
          radius: 20.2 * textScaleFactor,
          backgroundColor: Colors.black26,
          child: CircleAvatar(
            radius: 20.0 * textScaleFactor,
            backgroundColor:
                Theme.of(context).colorScheme.brightness == Brightness.light
                    ? Theme.of(context).canvasColor
                    : Color(0x1AFFFFFF),
            child: Icon(
              Icons.more_horiz,
              color: Theme.of(context).iconTheme.color,
              size: 28.0 * textScaleFactor,
            ),
          ),
        ),
        color: Theme.of(context).canvasColor,
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 0,
            child: _PopUpListTile(
              iconData: Icons.logout,
              title: AppLocalizations.of(context)!.chatPopMarkAsRead,
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 1,
            child: _PopUpListTile(
              iconData: Icons.logout,
              title: AppLocalizations.of(context)!.chatPopArchive,
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 2,
            child: _PopUpListTile(
              iconData: Icons.logout,
              title: AppLocalizations.of(context)!.chatPopReport,
            ),
          ),
        ],
        onSelected: (value) => _selectedItem(context, value),
      ),
    );
  }
}

class _PopUpListTile extends StatelessWidget {
  final IconData iconData;
  final String title;

  const _PopUpListTile({
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
          size: 20.0 * textScaleFactor,
          color: Theme.of(context).primaryIconTheme.color,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryIconTheme.color)
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).primaryIconTheme.color),
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
                    height: 110 * textScaleFactor,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
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
                  height: 110 * textScaleFactor,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    padding: const EdgeInsets.all(kHPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: chatImageUrl.split('/').first == 'assets'
                              ? Image.asset(
                                  chatImageUrl,
                                  height: 50 * textScaleFactor,
                                  width: 50 * textScaleFactor,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: chatImageUrl,
                                  height: 50 * textScaleFactor,
                                  width: 50 * textScaleFactor,
                                  fit: BoxFit.cover,
                                  placeholder: (context, _) => ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
                                    child: Image.asset(
                                      'assets/images/travenx_180.png',
                                      height: 50 * textScaleFactor,
                                      width: 50 * textScaleFactor,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  errorWidget: (context, _, __) => Image.asset(
                                    'assets/images/travenx_180.png',
                                    height: 50 * textScaleFactor,
                                    width: 50 * textScaleFactor,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kHPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    chatTitle,
                                    maxLines: 1,
                                    textScaleFactor: textScaleFactor,
                                    style: AppLocalizations.of(context)!
                                                .localeName ==
                                            'km'
                                        ? Theme.of(context)
                                            .primaryTextTheme
                                            .titleLarge
                                        : Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                    overflow: kIsWeb
                                        ? TextOverflow.clip
                                        : TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chatMessage,
                                        maxLines: 1,
                                        textScaleFactor: textScaleFactor,
                                        style: snapshot.data!.docs.single
                                                    .get('senderUid') ==
                                                _user.uid
                                            ? AppLocalizations.of(context)!
                                                        .localeName ==
                                                    'km'
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                            : AppLocalizations.of(context)!
                                                        .localeName ==
                                                    'km'
                                                ? Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                        overflow: kIsWeb
                                            ? TextOverflow.clip
                                            : TextOverflow.ellipsis,
                                      ),
                                    ),
                                    chatMessage == ''
                                        ? const SizedBox.shrink()
                                        : const SizedBox(width: 20.0),
                                    Text(
                                      '${chatDateTime.hour.toString()}:' +
                                          '${chatDateTime.minute < 10 ? '0' + chatDateTime.minute.toString() : chatDateTime.minute.toString()} ' +
                                          '${chatDateTime.day.toString()}/' +
                                          '${chatDateTime.month.toString()}/' +
                                          '${chatDateTime.year.toString()}',
                                      textScaleFactor: textScaleFactor,
                                      style:
                                          AppLocalizations.of(context)!
                                                      .localeName ==
                                                  'km'
                                              ? Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyLarge
                                              : Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                      overflow: kIsWeb
                                          ? TextOverflow.clip
                                          : TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        snapshot.data!.docs.single.get('senderUid') == _user.uid
                            ? const SizedBox.shrink()
                            : CircleAvatar(
                                radius: 7.0,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
