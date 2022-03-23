import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
            size: 18.0,
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
          IconButton(
            onPressed: () => Navigator.pop(context), //TODO: Prompt before pop
            padding: const EdgeInsets.symmetric(horizontal: kHPadding),
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              CustomOutlinedIcons.close,
              size: 24.0,
              color: Theme.of(context).errorColor,
            ),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.light(primary: Theme.of(context).primaryColor),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        child: Stepper(
          physics: BouncingScrollPhysics(),
          currentStep: currentStep,
          steps: _buildSteps(),
          controlsBuilder:
              (BuildContext context, ControlsDetails controlsDetails) {
            return currentStep == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StepperNavigationButton(
                        backgroundColor:
                            Theme.of(context).errorColor.withOpacity(0.2),
                        label: 'ចាកចេញ',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).errorColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10.0),
                      StepperNavigationButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: 'បន្ទាប់',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                        onPressed: controlsDetails.onStepContinue,
                      ),
                    ],
                  )
                : currentStep == 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StepperNavigationButton(
                            backgroundColor: Colors.transparent,
                            label: 'រំលង',
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            onPressed: () {
                              //TODO: Remove input before continue
                              controlsDetails.onStepContinue!();
                            },
                          ),
                          Row(
                            children: [
                              StepperNavigationButton(
                                backgroundColor:
                                    Theme.of(context).disabledColor,
                                label: 'ថយក្រោយ',
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                onPressed: controlsDetails.onStepCancel,
                              ),
                              const SizedBox(width: 10.0),
                              StepperNavigationButton(
                                backgroundColor: Theme.of(context).primaryColor,
                                label: 'បន្ទាប់',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                                onPressed: controlsDetails.onStepContinue,
                              ),
                            ],
                          ),
                        ],
                      )
                    : currentStep == _buildSteps().length - 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              StepperNavigationButton(
                                backgroundColor:
                                    Theme.of(context).disabledColor,
                                label: 'ថយក្រោយ',
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                onPressed: controlsDetails.onStepCancel,
                              ),
                              const SizedBox(width: 10.0),
                              StepperNavigationButton(
                                backgroundColor: Theme.of(context).primaryColor,
                                label: 'រួចរាល់',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                                onPressed: controlsDetails.onStepContinue,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              StepperNavigationButton(
                                backgroundColor:
                                    Theme.of(context).disabledColor,
                                label: 'ថយក្រោយ',
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                onPressed: controlsDetails.onStepCancel,
                              ),
                              const SizedBox(width: 10.0),
                              StepperNavigationButton(
                                backgroundColor: Theme.of(context).primaryColor,
                                label: 'បន្ទាប់',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                                onPressed: controlsDetails.onStepContinue,
                              ),
                            ],
                          );
          },
          onStepContinue: () {
            if (currentStep == _buildSteps().length - 1) {
              print('Completed');
            } else
              setState(() => currentStep++);
          },
          onStepCancel: () =>
              currentStep == 0 ? null : setState(() => currentStep--),
          onStepTapped: null,
        ),
      ),
    );
  }

  List<Step> _buildSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'សេវាប្រាប់ទិសតំបន់ទីតាំង ឬអាជីវកម្ម',
            textScaleFactor: textScaleFactor,
            style: currentStep == 0
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context).textTheme.bodyText1,
          ),
          content: Container(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            'ពត៍មានចាំបាច់',
            textScaleFactor: textScaleFactor,
            style: currentStep == 1
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context).textTheme.bodyText1,
          ),
          content: Container(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text(
            'ពត៍មានបន្ថែម',
            textScaleFactor: textScaleFactor,
            style: currentStep == 2
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context).textTheme.bodyText1,
          ),
          content: Container(),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text(
            'បទបង្ហាញទៅអតិថិជន',
            textScaleFactor: textScaleFactor,
            style: currentStep == 3
                ? Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor)
                : Theme.of(context).textTheme.bodyText1,
          ),
          content: Container(),
        ),
      ];
}

class StepperNavigationButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  const StepperNavigationButton({
    Key? key,
    required this.backgroundColor,
    required this.label,
    required this.textStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor:
            MaterialStateProperty.all(textStyle!.color!.withOpacity(0.1)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle,
      ),
    );
  }
}
