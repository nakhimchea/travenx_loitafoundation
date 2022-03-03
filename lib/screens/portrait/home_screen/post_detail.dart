import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, selectedIndex;
import 'package:travenx_loitafoundation/helpers/weather_forecast_extractor.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/models/weather_forecast_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/chat_screen/chat.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/services/internet_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/custom_floating_action_button.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/post_detail_widgets.dart';

class PostDetail extends StatefulWidget {
  final PostObject post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  ModelWeatherForecast? _weatherForecast;
  bool get _isSelfPost {
    return FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser!.uid == widget.post.clientId
        : false;
  }

  void getWeatherForecast() async {
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final String _owmWeatherForecastUrl =
        'http://api.openweathermap.org/data/2.5/forecast?';
    final String _responseBody = await InternetService.httpGetResponseBody(
        url:
            '$_owmWeatherForecastUrl${widget.post.positionCoordination}&appid=${await _secureStorage.read(key: 'owmKey')}&units=metric');
    setState(
        () => _weatherForecast = weatherForecastExtractor(data: _responseBody));
  }

  @override
  void initState() {
    super.initState();
    getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomFloatingActionButton(onTap: () => Navigator.pop(context)),
          CustomFloatingActionButton(
            onTap: () => print('Save Button Clicked ... '),
            //ToDo: change function when button save is clicked
            iconData: CustomFilledIcons.bookmark,
            iconColor: Theme.of(context).primaryColor,
            iconSize: 24.0,
          ),
        ],
      ),
      bottomNavigationBar: _isSelfPost
          ? Container(
              height: MediaQuery.of(context).size.height / 10,
              padding: const EdgeInsets.only(
                left: kHPadding,
                right: kHPadding,
                top: kVPadding,
                bottom: kVPadding + 16.0,
              ),
              color: Theme.of(context).bottomAppBarColor,
              child: Center(
                child: Text('កន្លែងនេះជារបស់អ្នក!'),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height / 10,
              padding: const EdgeInsets.only(
                left: kHPadding,
                right: kHPadding,
                top: kVPadding,
                bottom: kVPadding + 16.0,
              ),
              color: Theme.of(context).bottomAppBarColor,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final User? _user = FirebaseAuth.instance.currentUser;
                      final FirestoreService _firestoreService =
                          FirestoreService();

                      if (_user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Chat(
                              postTitle: widget.post.title,
                              postImageUrl: widget.post.imageUrls.first,
                              userId: _user.uid,
                              withUserId: widget.post.clientId,
                              postId: widget.post.postId,
                            ),
                          ),
                        );

                        await _firestoreService.addChat2Profile(_user.uid,
                            widget.post.postId, widget.post.clientId);
                      } else {
                        selectedIndex = 1;
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height / 20 -
                          kVPadding -
                          16.0 / 2,
                      backgroundColor: Theme.of(context).hintColor,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 20 -
                            kVPadding -
                            10,
                        backgroundColor: Theme.of(context).bottomAppBarColor,
                        child: Icon(
                          CustomFilledIcons.message,
                          size: 24.0,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: kVPadding),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height / 20 -
                        kVPadding -
                        16.0 / 2,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height / 20 -
                          kVPadding -
                          10,
                      backgroundColor: Theme.of(context).bottomAppBarColor,
                      child: Icon(
                        Icons.call_rounded,
                        size: 24.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: kVPadding),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10 -
                          2 * kVPadding -
                          16.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'ផលិតផល និង សេវាកម្ម',
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                        overflow:
                            kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 44.0),
            sliver: SliverToBoxAdapter(
              child: PostCover(imageUrls: widget.post.imageUrls),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: kHPadding,
              right: kHPadding,
              top: 25.0,
            ),
            sliver: SliverToBoxAdapter(
              child: PostHeader(
                title: widget.post.title,
                ratings: widget.post.ratings,
                views: widget.post.views,
                price: widget.post.price,
                state: widget.post.state,
                country: widget.post.country,
                openHours: widget.post.openHours,
              ),
            ),
          ),
          _weatherForecast != null
              ? SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: kHPadding),
                  sliver: SliverToBoxAdapter(
                    child: WeatherAlerts(
                      forecast: _weatherForecast!.forecast,
                      sunrise: _weatherForecast!.sunrise,
                      sunset: _weatherForecast!.sunset,
                    ),
                  ),
                )
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          widget.post.announcement != null
              ? SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kHPadding,
                    vertical: kVPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: AnnouncementCard(
                      announcement: widget.post.announcement!,
                    ),
                  ),
                )
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: BriefDescriptionCard(
                post: widget.post,
                temperature: _weatherForecast == null
                    ? 30
                    : _weatherForecast!.temperature,
              ),
            ),
          ),
          widget.post.activities.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: kVPadding),
                  sliver: SliverToBoxAdapter(
                    child: Activities(activities: widget.post.activities),
                  ),
                )
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          widget.post.details != null
              ? SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kHPadding,
                    vertical: kVPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: PostDetails(details: widget.post.details!),
                  ),
                )
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          widget.post.policies != null
              ? SliverToBoxAdapter(
                  child: Policies(policies: widget.post.policies!),
                )
              : SliverToBoxAdapter(child: SizedBox.shrink()),
          SliverToBoxAdapter(
            child: PostNearbys(
              cityName: widget.post.state,
              currentPostId: widget.post.postId,
            ),
          ),
        ],
      ),
    );
  }
}
