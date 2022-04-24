import 'dart:convert' show jsonDecode;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart' show Geolocator;
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/activity_type.dart';
import 'package:travenx_loitafoundation/helpers/category_type.dart';
import 'package:travenx_loitafoundation/helpers/city_name_translator.dart';
import 'package:travenx_loitafoundation/helpers/country_name_translator.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/user_posts.dart';
import 'package:travenx_loitafoundation/services/geolocator_service.dart';
import 'package:travenx_loitafoundation/services/internet_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_divider.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/add_post/add_post.dart';
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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool _isCategoryHighlight = false;
  List<CategoryType> _categories = [];
  bool _isImagePathHighlight = false;
  List<String> _imagesPath = [];
  DateTime _openHour = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 8);
  DateTime _closeHour = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 21);
  List<ActivityType> _activities = [];
  TextEditingController _detailsController = TextEditingController();
  List<TextEditingController> _policies = [TextEditingController()];
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
            ? _categories.length >= 3
                ? _categories.clear()
                : _categories.add(categoryType)
            : _categories.remove(categoryType);
      });

  void _imagePicker(String filePath, {bool isRemoved = false}) => setState(() {
        _isImagePathHighlight = false;
        !isRemoved ? _imagesPath.add(filePath) : _imagesPath.remove(filePath);
      });

  void _changeOpenHour(DateTime dateTime) =>
      setState(() => _openHour = dateTime);
  void _changeCloseHour(DateTime dateTime) =>
      setState(() => _closeHour = dateTime);

  void _activityPicker(ActivityType activityType, {bool isRemoved = false}) =>
      setState(() => !isRemoved
          ? _activities.add(activityType)
          : _activities.remove(activityType));

  void _changePolicyControllers({bool isRemoved = false, int index = 0}) =>
      setState(() => !isRemoved
          ? _policies.add(TextEditingController())
          : _policies.removeAt(index));

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

      setState(() {
        _state = cityNameTranslator(enCityName: _enStateName);
        _country = countryNameTranslator(enCountryName: _enCountryName);
        _positionCoordination = _coordination;
      });
    } else
      setState(() => _state = 'denied');
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
            size: 24.0,
            color: Theme.of(context).errorColor,
          ),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        title: Text(
          'បង្ហោះទីតាំង ឬអាជីវកម្ម',
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.headline3,
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
                  _activities = [];
                  _detailsController = TextEditingController();
                  _policies = [TextEditingController()];
                  _announcementController = TextEditingController();
                  currentStep++;
                });
              },
              child: Text(
                'រំលង',
                style: Theme.of(context).textTheme.bodyText1,
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
                  label: 'ថយក្រោយ',
                  textStyle: Theme.of(context).textTheme.bodyText1,
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
                label: currentStep == 3 ? 'បង្ហោះ' : 'បន្ទាប់',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
                onPressed: _agreementChecked
                    ? () {
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
                            if (_categories.length < 1)
                              setState(() => _isCategoryHighlight = true);
                            if (_imagesPath.length < 1)
                              setState(() => _isImagePathHighlight = true);

                            if (_titleController.text.trim() != '' &&
                                _categories.length >= 1 &&
                                _imagesPath.length >= 1)
                              setState(() => currentStep++);
                            break;
                          case 2:
                            setState(() => currentStep++);
                            break;
                          case 3:
                            //TODO: Take time to upload user's post to cloud
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
        physics: BouncingScrollPhysics(),
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
          title: Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(
          child: _state == 'denied'
              ? kIsWeb
                  ? Container(
                      height: 40,
                      color: Theme.of(context).disabledColor,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: kHPadding),
                          Center(
                            child: Icon(
                              CustomFilledIcons.location,
                              color: Theme.of(context).primaryIconTheme.color,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Center(
                            child: Text(
                              'សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ។ ',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          Center(
                            child: Text(
                              'ចុចលើនិមិត្តសញ្ញាទីតាំងខាងលើ ដើម្បីបើកឡើងវិញ!',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Theme.of(context).hintColor),
                            ),
                          ),
                          const SizedBox(width: kHPadding),
                        ],
                      ),
                    )
                  : TextButton(
                      onPressed: () async {
                        try {
                          if (await GeolocatorService.openLocationSettings()) {
                            if (await Geolocator.isLocationServiceEnabled()) {
                              Future.delayed(Duration(milliseconds: 250))
                                  .whenComplete(() => _setLocationCity());
                            } else
                              print('Location service is still disabled.');
                          } else
                            print('Failed to open Location settings.');
                        } catch (e) {
                          print('Unknown Error: $e');
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Container(
                        height: 40,
                        color: Theme.of(context).disabledColor,
                        child: ListView(
                          primary: false,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(width: kHPadding),
                            Center(
                              child: Icon(
                                CustomFilledIcons.location,
                                color: Theme.of(context).primaryIconTheme.color,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Center(
                              child: Text(
                                'សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ។ ',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            Center(
                              child: Text(
                                'ចុចទីនេះដើម្បីបើកឡើងវិញ!',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                            const SizedBox(width: kHPadding),
                          ],
                        ),
                      ),
                    )
              : SizedBox.shrink(),
        ),
        SliverToBoxAdapter(child: const SizedBox(height: kHPadding)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHPadding),
          sliver: SliverToBoxAdapter(
            child: StepOneDescription(
              isAgreementHighlight: _isAgreementHighlight,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
          sliver: SliverToBoxAdapter(
            child: CustomDivider(
              color: Theme.of(context).primaryColor,
              dashWidth: 6,
              dashHeight: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHPadding),
          sliver: SliverToBoxAdapter(
            child: StepOneCheckedBox(
              isAgreementHighlight: _isAgreementHighlight,
              isChecked: _agreementChecked,
              isCheckedCallback: _toggleCheckedBox,
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
          title: Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(child: const SizedBox(height: kHPadding)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHPadding),
          sliver: SliverToBoxAdapter(
            child: StepTwoFields(
              isTitleHighlight: _isTitleHighlight,
              disableHighlight: _disableHighlight,
              titleController: _titleController,
              priceController: _priceController,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
          sliver: SliverToBoxAdapter(
            child: CustomDivider(
              color: Theme.of(context).primaryColor,
              dashWidth: 6,
              dashHeight: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHPadding),
          sliver: SliverToBoxAdapter(
            child: CategorySelection(
              isCategoryHighlight: _isCategoryHighlight,
              categories: _categories,
              categoryPickerCallback: _categoryPicker,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: kHPadding + 12.0),
          sliver: SliverToBoxAdapter(
            child: CustomDivider(
              color: Theme.of(context).primaryColor,
              dashWidth: 6,
              dashHeight: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kHPadding),
          sliver: SliverToBoxAdapter(
            child: PostImagePicker(
              isImagePathHighlight: _isImagePathHighlight,
              imagesPath: _imagesPath,
              imagePickerCallback: _imagePicker,
            ),
          ),
        ),
        SliverToBoxAdapter(child: const SizedBox(height: 100)),
      ];
    else if (currentStep == 2)
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 1,
          actions: [],
          title: Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(child: const SizedBox(height: kHPadding)),
        SliverToBoxAdapter(
          child: BusinessTime(
            openEnabled: timeOpenEnabled,
            openEnabledCallback: _toggleTimeOpen,
            closeEnabled: timeCloseEnabled,
            closeEnabledCallback: _toggleTimeClose,
            openHour: _openHour,
            openHourCallback: _changeOpenHour,
            closeHour: _closeHour,
            closeHourCallback: _changeCloseHour,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal:
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? kHPadding
                    : 0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomDivider(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              dashWidth: 6,
              dashHeight: 1,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ActivityPicker(
            activities: _activities,
            activityPickerCallback: _activityPicker,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal:
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? kHPadding
                    : 0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomDivider(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              dashWidth: 6,
              dashHeight: 1,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: StepThreeFields(
            policyControllers: _policies,
            detailsController: _detailsController,
            policiesCallback: _changePolicyControllers,
            announcementController: _announcementController,
          ),
        ),
      ];
    else if (currentStep == 3)
      return [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 1,
          leading: null,
          actions: [],
          title: Steps(currentStep: currentStep),
          toolbarHeight: 56 + kHPadding,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        SliverToBoxAdapter(child: const SizedBox(height: kHPadding)),
        SliverToBoxAdapter(
          child: Container(
            height: 50,
            color: Theme.of(context).bottomAppBarColor,
          ),
        ),
      ];
    else
      return [];
  }
}

class Steps extends StatelessWidget {
  final int currentStep;
  const Steps({Key? key, required this.currentStep}) : super(key: key);

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
                  'ទីតាំង',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  'ចាំបាច់',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  'បន្ថែម',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                  'ពិនិត្យ',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
