import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitFadingCircle(color: Theme.of(context).cardColor, size: 50.0),
        SizedBox(height: 15.0),
        AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'Loading...',
              textStyle: TextStyle(color: Theme.of(context).cardColor),
            ),
          ],
          pause: Duration(milliseconds: 200),
          totalRepeatCount: 50,
        ),
      ],
    );
  }
}