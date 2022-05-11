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
  final int views;
  final double ratings;
  const PostDetail({
    Key? key,
    required this.post,
    required this.views,
    required this.ratings,
  }) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  ModelWeatherForecast? _weatherForecast;
  final User? _user = FirebaseAuth.instance.currentUser;
  bool get _isSelfPost {
    return _user != null ? _user!.uid == widget.post.clientId : false;
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

  void isViewed() async {
    if (_user != null && !_isSelfPost)
      await FirestoreService().setViews4Post(widget.post.postId, _user!.uid);
  }

  @override
  void initState() {
    super.initState();
    isViewed();
    getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kVPadding + kHPadding,
              vertical: kVPadding,
            ),
            child:
                CustomFloatingActionButton(onTap: () => Navigator.pop(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kVPadding + kHPadding,
              vertical: kVPadding,
            ),
            child: CustomFloatingActionButton(
              onTap: () => print('Save Button Clicked ... '),
              //ToDo: change function when button save is clicked
              iconData: CustomFilledIcons.bookmark,
              iconColor: Theme.of(context).primaryColor,
              iconSize: 24.0,
            ),
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
                      if (_user != null) {
                        final FirestoreService _firestoreService =
                            FirestoreService();
                        String? userDisplayName;
                        String? userPhoneNumber;
                        String? userProfileUrl;
                        await _firestoreService
                            .getProfileData(_user!.uid)
                            .then((snapshot) {
                          userDisplayName =
                              snapshot.get('displayName').toString();
                          userPhoneNumber =
                              snapshot.get('phoneNumber').toString();
                          userProfileUrl =
                              snapshot.get('profileUrl').toString();
                        });

                        if (userDisplayName != null &&
                            userPhoneNumber != null &&
                            userProfileUrl != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Chat(
                                  postTitle: widget.post.title,
                                  postImageUrl: widget.post.imageUrls.first,
                                  userId: _user!.uid,
                                  userDisplayName: userDisplayName!,
                                  userProfileUrl: userProfileUrl!,
                                  postId: widget.post.postId,
                                  withUserId: widget.post.clientId,
                                  withDisplayName:
                                      widget.post.clientDisplayName,
                                  withPhoneNumber:
                                      widget.post.clientPhoneNumber,
                                  withProfileUrl: widget.post.clientProfileUrl),
                            ),
                          );

                          await _firestoreService.addChat2Profile(
                            _user!.uid,
                            userDisplayName!,
                            userPhoneNumber!,
                            userProfileUrl!,
                            widget.post.postId,
                            widget.post.clientId,
                            widget.post.clientDisplayName,
                            widget.post.clientPhoneNumber,
                            widget.post.clientProfileUrl,
                          );
                        }
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
        primary: false,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 44.0),
                    child: PostCover(imageUrls: widget.post.imageUrls),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: kHPadding,
                      right: kHPadding,
                      top: 25.0,
                    ),
                    child: PostHeader(
                      title: widget.post.title,
                      ratings: widget.ratings,
                      views: widget.views,
                      price: widget.post.price,
                      state: widget.post.state,
                      country: widget.post.country,
                      openHours: widget.post.openHours,
                    ),
                  ),
                  _weatherForecast != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: kHPadding),
                          child: WeatherAlerts(
                            forecast: _weatherForecast!.forecast,
                            sunrise: _weatherForecast!.sunrise,
                            sunset: _weatherForecast!.sunset,
                          ),
                        )
                      : const SizedBox.shrink(),
                  widget.post.announcement != null &&
                          widget.post.announcement != ''
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kHPadding,
                            vertical: kVPadding,
                          ),
                          child: AnnouncementCard(
                            announcement: widget.post.announcement!,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kHPadding,
                      vertical: kVPadding,
                    ),
                    child: BriefDescriptionCard(
                      ratings: widget.ratings,
                      views: widget.views,
                      temperature: _weatherForecast == null
                          ? 30
                          : _weatherForecast!.temperature,
                    ),
                  ),
                  widget.post.activities.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: kVPadding),
                          child: Activities(activities: widget.post.activities),
                        )
                      : const SizedBox.shrink(),
                  widget.post.details != null &&
                          widget.post.details!.textDetail != ''
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kHPadding,
                            vertical: kVPadding,
                          ),
                          child: PostDetails(details: widget.post.details!),
                        )
                      : const SizedBox.shrink(),
                  widget.post.policies != null &&
                          widget.post.policies!.isNotEmpty
                      ? Policies(policies: widget.post.policies!)
                      : const SizedBox.shrink(),
                  PostGallery(currentPostId: widget.post.postId),
                  PostRatings(currentPostId: widget.post.postId),
                  PostNearbys(
                    cityName: widget.post.state,
                    currentPostId: widget.post.postId,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
