import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/user_posts.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/stepper_navigation_button.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  static int customDisableColor = 0xFFDADADA;
  int currentStep = 0;

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
                //TODO: Remove input before continue
                setState(() => currentStep++);
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
                backgroundColor: Theme.of(context).primaryColor,
                label: currentStep == 3 ? 'បង្ហោះ' : 'បន្ទាប់',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
                onPressed: () {
                  if (currentStep == 3) {
                    //TODO: Take time to upload user's post to cloud
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => UserPosts()));
                  } else
                    setState(() => currentStep++);
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHPadding),
        child: Column(
          children: [
            Row(
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: currentStep == 0
                                        ? Theme.of(context).primaryColor
                                        : Color(customDisableColor),
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
                                : Color(customDisableColor),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: currentStep == 1
                                        ? Theme.of(context).primaryColor
                                        : Color(customDisableColor),
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
                                : Color(customDisableColor),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: currentStep == 2
                                        ? Theme.of(context).primaryColor
                                        : Color(customDisableColor),
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
                                : Color(customDisableColor),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: currentStep == 3
                                        ? Theme.of(context).primaryColor
                                        : Color(customDisableColor),
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
                                : Color(customDisableColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
