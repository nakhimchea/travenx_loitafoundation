import 'dart:convert' show jsonDecode;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart' show Geolocator;
import 'package:image_picker/image_picker.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/activity_type.dart';
import 'package:travenx_loitafoundation/helpers/category_type.dart';
import 'package:travenx_loitafoundation/helpers/city_name_translator.dart';
import 'package:travenx_loitafoundation/helpers/country_name_translator.dart';
import 'package:travenx_loitafoundation/helpers/post_uploader.dart';
import 'package:travenx_loitafoundation/helpers/time_translator.dart';
import 'package:travenx_loitafoundation/helpers/weather_forecast_extractor.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/models/weather_forecast_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/user_posts.dart';
import 'package:travenx_loitafoundation/services/geolocator_service.dart';
import 'package:travenx_loitafoundation/services/internet_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_divider.dart';
import 'package:travenx_loitafoundation/widgets/loading_dialog.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/post_detail_widgets.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/add_post.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/add_post_cover.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/category_selection.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/stepper_navigation_button.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool timeOpenEnabled = false;
  bool timeCloseEnabled = false;

  int currentStep = 0;
  bool _isAgreementHighlight = false;
  bool _agreementChecked = false;
  String _state = '';
  String _country = '';
  String _positionCoordination = '';
  bool _isTitleHighlight = false;
  String _title = '';
  TextEditingController _titleController = TextEditingController();
  double _price = 0;
  TextEditingController _priceController = TextEditingController();
  bool _isCategoryHighlight = false;
  List<String> _categories = [];
  List<CategoryType> _categoryTypes = [];
  bool _isImagePathHighlight = false;
  List<XFile> _imagesFile = [];
  String _openHours = '';
  DateTime _openHour = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
  DateTime _closeHour = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 21);
  ModelWeatherForecast? _weatherForecast;
  List<Activity> _activities = [];
  List<ActivityType> _activityTypes = [];
  Details _details = Details(textDetail: '', mapImageUrl: '');
  TextEditingController _detailsController = TextEditingController();
  List<String> _policies = [];
  List<TextEditingController> _policyControllers = [TextEditingController()];
  String _announcement = '';
  TextEditingController _announcementController = TextEditingController();

  void _toggleTimeOpen({bool isDisabled = false}) => setState(
      () => !isDisabled ? timeOpenEnabled = true : timeOpenEnabled = false);
  void _toggleTimeClose({bool isDisabled = false}) => setState(
      () => !isDisabled ? timeCloseEnabled = true : timeCloseEnabled = false);

  void _toggleCheckedBox() {
    _setLocationCity();
    setState(() {
      _isAgreementHighlight = false;
      _agreementChecked = !_agreementChecked;
    });
  }

  void _disableHighlight() => setState(() => _isTitleHighlight = false);

  void _categoryPicker(CategoryType categoryType, {bool isRemoved = false}) =>
      setState(() {
        _isCategoryHighlight = false;
        !isRemoved
            ? _categoryTypes.length >= 3
                ? _categoryTypes.clear()
                : _categoryTypes.add(categoryType)
            : _categoryTypes.remove(categoryType);
      });

  void _imagePicker(XFile file, {bool? isRemoved}) => setState(() {
        _isImagePathHighlight = false;
        isRemoved == null
            ? _imagesFile.add(file)
            : !isRemoved
                ? _imagesFile = []
                : _imagesFile.remove(file);
      });

  void _changeOpenHour(DateTime dateTime) =>
      setState(() => _openHour = dateTime);
  void _changeCloseHour(DateTime dateTime) =>
      setState(() => _closeHour = dateTime);

  void _activityPicker(ActivityType activityType, {bool isRemoved = false}) =>
      setState(() => !isRemoved
          ? _activityTypes.add(activityType)
          : _activityTypes.remove(activityType));

  void _changePolicyControllers({bool isRemoved = false, int index = 0}) =>
      setState(() => !isRemoved
          ? _policyControllers.add(TextEditingController())
          : _policyControllers.removeAt(index));

  void _setLocationCity() async {
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final String _owmReverseGeocodingUrl =
        'http://api.openweathermap.org/geo/1.0/reverse?';
    final String _coordination =
        await GeolocatorService.getCurrentCoordination();
    if (_coordination != '') {
      final String _responseBody = await InternetService.httpGetResponseBody(
          url:
              '$_owmReverseGeocodingUrl$_coordination&appid=${await _secureStorage.read(key: 'owmKey')}');
      final String _enStateName =
          jsonDecode(_responseBody)[0]['state'].toString();
      final String _enCountryName =
          jsonDecode(_responseBody)[0]['country'].toString();

      if (mounted)
        setState(() {
          _state = cityNameTranslator(context, enCityName: _enStateName);
          _country =
              countryNameTranslator(context, enCountryName: _enCountryName);
          _positionCoordination = _coordination;
        });
      if (_weatherForecast == null) _getWeatherForecast();
    } else {
      if (mounted) setState(() => _state = 'denied');
    }
  }

  void _getWeatherForecast() async {
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    final String _owmWeatherForecastUrl =
        'http://api.openweathermap.org/data/2.5/forecast?';
    final String _responseBody = await InternetService.httpGetResponseBody(
        url:
            '$_owmWeatherForecastUrl$_positionCoordination&appid=${await _secureStorage.read(key: 'owmKey')}&units=metric');
    if (mounted)
      setState(() => _weatherForecast =
          weatherForecastExtractor(context, data: _responseBody));
  }

  @override
  void initState() {
    super.initState();
    _setLocationCity();
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
            CustomOutlinedIcons.close,
            size: 26.0,
            color: Theme.of(context).errorColor,
          ),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        title: Text(
          AppLocalizations.of(context)!.pfAddPost,
          textScaleFactor: textScaleFactor,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.titleLarge
              : Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Visibility(
            visible: currentStep == 2,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  timeOpenEnabled = false;
                  timeCloseEnabled = false;
                  _activityTypes = [];
                  _detailsController = TextEditingController();
                  _policyControllers = [TextEditingController()];
                  _announcementController = TextEditingController();
                  currentStep++;
                });
              },
              child: Text(
                AppLocalizations.of(context)!.skipLabel,
                textScaleFactor: textScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context).primaryTextTheme.bodyMedium
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: !kIsWeb && Platform.isIOS
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: currentStep > 0,
              child: Expanded(
                child: StepperNavigationButton(
                  backgroundColor: Theme.of(context).disabledColor,
                  label: AppLocalizations.of(context)!.backLabel,
                  textStyle: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyLarge,
                  onPressed: () => setState(() => currentStep--),
                ),
              ),
            ),
            SizedBox(width: currentStep > 0 ? 10.0 : 0),
            Expanded(
              child: StepperNavigationButton(
                backgroundColor: _agreementChecked
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
                label: currentStep == 3
                    ? AppLocalizations.of(context)!.postLabel
                    : AppLocalizations.of(context)!.nextLabel,
                textStyle: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                onPressed: _agreementChecked
                    ? () async {
                        switch (currentStep) {
                          case 0:
                            if (_state == 'denied')
                              setState(() {
                                _isAgreementHighlight = true;
                                _agreementChecked = false;
                              });
                            else
                              setState(() => currentStep++);
                            break;
                          case 1:
                            if (_titleController.text.trim() == '')
                              setState(() => _isTitleHighlight = true);
                            if (_categoryTypes.length < 1)
                              setState(() => _isCategoryHighlight = true);
                            if (_imagesFile.length < 1)
                              setState(() => _isImagePathHighlight = true);

                            if (_titleController.text.trim() != '' &&
                                _categoryTypes.length >= 1 &&
                                _imagesFile.length >= 1)
                              setState(() => currentStep++);
                            break;
                          case 2:
                            setState(() => currentStep++);
                            break;
                          case 3:
                            final PostUploader _postUploader = PostUploader(
                              categories: _categories,
                              imagesFile: _imagesFile,
                              title: _title,
                              state: _state,
                              country: _country,
                              positionCoordination: _positionCoordination,
                              price: _price,
                              openHours: _openHours,
                              announcement: _announcement,
                              activities: _activities,
                              details: _details,
                              policies: _policies,
                            );
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => LoadingDialog(),
                            );
                            await _postUploader.pushPostObject(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => UserPosts()),
                            );
                            break;
                          default:
                            print('Out of steps');
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        slivers: _contentDecision(),
      ),
    );
  }

  List<Widget> _contentDecision() {
    if (currentStep == 0)
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 1,
          actions: [],
          title: _Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _state == 'denied'
                    ? kIsWeb
                        ? Container(
                            height: 40,
                            color: Theme.of(context).disabledColor,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(width: kHPadding),
                                Center(
                                  child: Icon(
                                    CustomFilledIcons.location,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .locationClosed,
                                    textScaleFactor: textScaleFactor,
                                    style: AppLocalizations.of(context)!
                                                .localeName ==
                                            'km'
                                        ? Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .locationToOpenWeb,
                                    textScaleFactor: textScaleFactor,
                                    style: AppLocalizations.of(context)!
                                                .localeName ==
                                            'km'
                                        ? Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color:
                                                    Theme.of(context).hintColor)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .hintColor),
                                  ),
                                ),
                                const SizedBox(width: kHPadding),
                              ],
                            ),
                          )
                        : TextButton(
                            onPressed: () async {
                              try {
                                if (await GeolocatorService
                                    .openLocationSettings()) {
                                  if (await Geolocator
                                      .isLocationServiceEnabled()) {
                                    Future.delayed(
                                            const Duration(milliseconds: 250))
                                        .whenComplete(() => _setLocationCity());
                                  } else
                                    print(
                                        'Location service is still disabled.');
                                } else
                                  print('Failed to open Location settings.');
                              } catch (e) {
                                print('Unknown Error: $e');
                              }
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Container(
                              height: 40,
                              color: Theme.of(context).disabledColor,
                              child: ListView(
                                primary: false,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: kHPadding),
                                  Center(
                                    child: Icon(
                                      CustomFilledIcons.location,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .locationClosed,
                                      textScaleFactor: textScaleFactor,
                                      style: AppLocalizations.of(context)!
                                                  .localeName ==
                                              'km'
                                          ? Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .locationToOpenMobile,
                                      textScaleFactor: textScaleFactor,
                                      style: AppLocalizations.of(context)!
                                                  .localeName ==
                                              'km'
                                          ? Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor)
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor),
                                    ),
                                  ),
                                  const SizedBox(width: kHPadding),
                                ],
                              ),
                            ),
                          )
                    : const SizedBox.shrink(),
                const SizedBox(height: kHPadding),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: StepOneDescription(
                    isAgreementHighlight: _isAgreementHighlight,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
                  child: CustomDivider(
                    color: Theme.of(context).primaryColor,
                    dashWidth: 6,
                    dashHeight: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: StepOneCheckedBox(
                    isAgreementHighlight: _isAgreementHighlight,
                    isChecked: _agreementChecked,
                    isCheckedCallback: _toggleCheckedBox,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    else if (currentStep == 1)
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 1,
          actions: [],
          title: _Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kHPadding),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: StepTwoFields(
                    isTitleHighlight: _isTitleHighlight,
                    disableHighlight: _disableHighlight,
                    titleController: _titleController,
                    priceController: _priceController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
                  child: CustomDivider(
                    color: Theme.of(context).primaryColor,
                    dashWidth: 6,
                    dashHeight: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: CategorySelection(
                    isCategoryHighlight: _isCategoryHighlight,
                    categories: _categoryTypes,
                    categoryPickerCallback: _categoryPicker,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
                  child: CustomDivider(
                    color: Theme.of(context).primaryColor,
                    dashWidth: 6,
                    dashHeight: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                  child: PostImagePicker(
                    isImagePathHighlight: _isImagePathHighlight,
                    imagesFile: _imagesFile,
                    imagePickerCallback: _imagePicker,
                  ),
                ),
                const SizedBox(height: 110)
              ],
            ),
          ),
        ),
      ];
    else if (currentStep == 2)
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 1,
          actions: [],
          title: _Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kHPadding),
                BusinessTime(
                  openEnabled: timeOpenEnabled,
                  openEnabledCallback: _toggleTimeOpen,
                  closeEnabled: timeCloseEnabled,
                  closeEnabledCallback: _toggleTimeClose,
                  openHour: _openHour,
                  openHourCallback: _changeOpenHour,
                  closeHour: _closeHour,
                  closeHourCallback: _changeCloseHour,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? kHPadding
                        : 0,
                  ),
                  child: CustomDivider(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    dashWidth: 6,
                    dashHeight: 1,
                  ),
                ),
                ActivityPicker(
                  activities: _activityTypes,
                  activityPickerCallback: _activityPicker,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? kHPadding
                        : 0,
                  ),
                  child: CustomDivider(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    dashWidth: 6,
                    dashHeight: 1,
                  ),
                ),
                StepThreeFields(
                  policyControllers: _policyControllers,
                  detailsController: _detailsController,
                  policiesCallback: _changePolicyControllers,
                  announcementController: _announcementController,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ];
    else if (currentStep == 3) {
      _title = _titleController.text.trim();
      _price = double.parse(_priceController.text.trim() != ''
          ? _priceController.text.trim()
          : '0');
      _categories = [];
      for (CategoryType categoryType in _categoryTypes)
        switch (categoryType) {
          case CategoryType.camping:
            _categories.add(AppLocalizations.of(context)!.icCamping);
            break;
          case CategoryType.sea:
            _categories.add(AppLocalizations.of(context)!.icSea);
            break;
          case CategoryType.temple:
            _categories.add(AppLocalizations.of(context)!.icTemple);
            break;
          case CategoryType.mountain:
            _categories.add(AppLocalizations.of(context)!.icMountain);
            break;
          case CategoryType.park:
            _categories.add(AppLocalizations.of(context)!.icPark);
            break;
          case CategoryType.resort:
            _categories.add(AppLocalizations.of(context)!.icResort);
            break;
          case CategoryType.zoo:
            _categories.add(AppLocalizations.of(context)!.icZoo);
            break;
          case CategoryType.locations:
            _categories.add(AppLocalizations.of(context)!.icLocations);
            break;
          default:
            break;
        }
      _openHours = timeOpenEnabled && timeCloseEnabled
          ? '${timeTranslator(context, _openHour)} - ${timeTranslator(context, _closeHour)}'
          : timeOpenEnabled
              ? AppLocalizations.of(context)!.pfApFromTime +
                  '${timeTranslator(context, _openHour)}'
              : timeCloseEnabled
                  ? AppLocalizations.of(context)!.pfApToTime +
                      '${timeTranslator(context, _closeHour)}'
                  : '';
      _announcement = _announcementController.text.trim();
      _activities = [];
      for (ActivityType activityType in _activityTypes)
        switch (activityType) {
          case ActivityType.boating:
            _activities.add(boating(context));
            break;
          case ActivityType.diving:
            _activities.add(diving(context));
            break;
          case ActivityType.fishing:
            _activities.add(fishing(context));
            break;
          case ActivityType.relaxing:
            _activities.add(relaxing(context));
            break;
          case ActivityType.swimming:
            _activities.add(swimming(context));
            break;
          default:
            break;
        }
      _details = Details(
          textDetail: _detailsController.text.trim(),
          mapImageUrl: 'assets/images/travenx_180.png');
      _policies = [];
      for (TextEditingController policyController in _policyControllers)
        if (policyController.text.trim() != '')
          _policies.add(policyController.text.trim());
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          leading: null,
          actions: [],
          title: _Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kHPadding),
                AddPostCover(imagesFile: _imagesFile),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kHPadding,
                    right: kHPadding,
                    top: 25.0,
                  ),
                  child: PostHeader(
                    title: _title,
                    ratings: 5.0,
                    views: 999,
                    price: _price,
                    state: _state,
                    country: _country,
                    openHours: _openHours,
                  ),
                ),
                _weatherForecast != null
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kHPadding),
                        child: WeatherAlerts(
                          forecast: _weatherForecast!.forecast,
                          sunrise: _weatherForecast!.sunrise,
                          sunset: _weatherForecast!.sunset,
                        ),
                      )
                    : const SizedBox.shrink(),
                _announcement != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding,
                          vertical: kVPadding,
                        ),
                        child: AnnouncementCard(
                          announcement: _announcement,
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHPadding,
                    vertical: kVPadding,
                  ),
                  child: BriefDescriptionCard(
                    ratings: 5.0,
                    views: 999,
                    temperature: 30,
                  ),
                ),
                _activities.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kVPadding),
                        child: Activities(activities: _activities),
                      )
                    : const SizedBox.shrink(),
                _details.textDetail != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHPadding,
                          vertical: kVPadding,
                        ),
                        child: PostDetails(
                          details: Details(
                            textDetail: _details.textDetail,
                            mapImageUrl: _details.mapImageUrl,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                _policies.isNotEmpty
                    ? Policies(policies: _policies)
                    : const SizedBox.shrink(),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ];
    } else
      return [];
  }
}

class _Steps extends StatelessWidget {
  final int currentStep;
  const _Steps({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.pfApLocation,
                  textScaleFactor: textScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                            color: currentStep == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 0
                                ? FontWeight.w700
                                : FontWeight.w400,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: currentStep == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 0
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: currentStep >= 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: kHPadding / 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.pfApBasic,
                  textScaleFactor: textScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                            color: currentStep == 1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 1
                                ? FontWeight.w700
                                : FontWeight.w400,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: currentStep == 1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 1
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: currentStep >= 1
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: kHPadding / 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.pfApAdditional,
                  textScaleFactor: textScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                            color: currentStep == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 2
                                ? FontWeight.w700
                                : FontWeight.w400,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: currentStep == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 2
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: currentStep >= 2
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: kHPadding / 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kHPadding),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.pfApPreview,
                  textScaleFactor: textScaleFactor,
                  style: AppLocalizations.of(context)!.localeName == 'km'
                      ? Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(
                            color: currentStep == 3
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 3
                                ? FontWeight.w700
                                : FontWeight.w400,
                          )
                      : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: currentStep == 3
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                            fontWeight: currentStep == 3
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                ),
                const SizedBox(height: 5.0),
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: currentStep >= 3
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
