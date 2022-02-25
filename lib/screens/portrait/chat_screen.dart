import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, selectedIndex;
import 'package:travenx_loitafoundation/models/chat_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class ChatScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final void Function() loggedInCallback;
  const ChatScreen({
    Key? key,
    required this.isLoggedIn,
    required this.displayName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.loggedInCallback,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final FirestoreService _firestoreService = FirestoreService();

  bool _isRefreshable = true;
  bool _isLoadable = true;

  List<ChatObject> chatList = [];
  DocumentSnapshot? _lastDoc;

  Widget _buildList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHPadding,
        vertical: kVPadding,
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: chatList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height / 9,
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: _BuildChatItem(
              message: chatList.elementAt(index),
            ),
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
          Icons.keyboard_arrow_left_outlined,
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

  @override
  Widget build(BuildContext context) {
    if (widget.isLoggedIn == true && widget.phoneNumber != '')
      return Scaffold(
        appBar: AppBar(
          brightness: Theme.of(context).colorScheme.brightness,
          elevation: 0.5,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'សារ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: false,
          actions: [ActionOptions()],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          physics: BouncingScrollPhysics(),
          enablePullDown: _isRefreshable,
          enablePullUp: _isLoadable,
          child: _buildList(),
          header: CustomHeader(builder: (_, __) => SizedBox.shrink()),
          footer: CustomFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            builder: loadingBuilder,
          ),
          onRefresh: () async {
            // _firestoreService
            //     .getChatList(FirebaseAuth.instance.currentUser!.uid);
            if (mounted) setState(() => _isRefreshable = false);
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            //TODO: get more chat to list
            if (mounted) setState(() {});
            _refreshController.loadComplete();
          },
        ),
      );
    else
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
                  TextButton(
                    onPressed: () {
                      selectedIndex = 3;
                      if (widget.isLoggedIn != false) widget.loggedInCallback();
                    },
                    child: Center(
                      child: Text('Login Now'),
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
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _BuildChatItem extends StatelessWidget {
  final ChatObject message;

  const _BuildChatItem({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      //TODO: Route User to Chat screen
      //     () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChatRoomSubscreen(message: message),
      //   ),
      // ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          dense: true,
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage(message.imageUrl),
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 9.0),
            child: Text(
              message.title,
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  message.latestMessage,
                  textScaleFactor: textScaleFactor,
                  style: message.read
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              message.latestMessage == ''
                  ? SizedBox.shrink()
                  : SizedBox(width: 20.0),
              Text(
                '${message.dateTime.hour.toString()}:'
                '${message.dateTime.minute.toString()} '
                '${message.dateTime.day.toString()}-'
                '${message.dateTime.month.toString()}-'
                '${message.dateTime.year.toString()}',
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: message.read
              ? SizedBox.shrink()
              : CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
        ),
      ),
    );
  }
}
