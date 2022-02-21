import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/constant.dart'
    show kHPadding, kVPadding;
import 'package:travenx_loitafoundation/helpers/weather_forecast_extractor.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/models/weather_forecast_model.dart';
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // SliverPadding(
          //   padding: EdgeInsets.only(top: 44.0),
          //   sliver: SliverToBoxAdapter(
          //     child: PostCover(imageUrls: widget.post.imageUrls),
          //   ),
          // ),
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
          // _weatherForecast != null
          //     ? SliverPadding(
          //         padding: EdgeInsets.symmetric(horizontal: kHPadding),
          //         sliver: SliverToBoxAdapter(
          //           child: WeatherAlerts(
          //             forecast: _weatherForecast!.forecast,
          //             sunrise: _weatherForecast!.sunrise,
          //             sunset: _weatherForecast!.sunset,
          //           ),
          //         ),
          //       )
          //     : SliverToBoxAdapter(child: SizedBox.shrink()),
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
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: BriefDescriptionCard(
          //       post: widget.post,
          //       temperature: _weatherForecast == null
          //           ? 30
          //           : _weatherForecast!.temperature,
          //     ),
          //   ),
          // ),
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
          // SliverToBoxAdapter(
          //   child: Policies(post: widget.post),
          // ),
          SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
        ],
      ),
    );
  }
}
