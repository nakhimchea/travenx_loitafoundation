import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitFadingCircle(
            color: color != null ? color : Theme.of(context).cardColor,
            size: 38.0),
        const SizedBox(height: 13.0),
        AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'Loading...',
              textStyle: TextStyle(
                  color: color != null ? color : Theme.of(context).cardColor),
            ),
          ],
          pause: const Duration(milliseconds: 200),
          totalRepeatCount: 50,
        ),
      ],
    );
  }
}
