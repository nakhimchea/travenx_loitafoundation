import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';

class LoginCardButton extends StatelessWidget {
  final String leadingUrl;
  final String title;
  final String trailing;
  final void Function()? onTap;

  const LoginCardButton({
    Key? key,
    required this.leadingUrl,
    required this.title,
    this.trailing = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height:
                  (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/profile_screen/card_background.png',
                  width: MediaQuery.of(context).size.width - 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(2.0),
              height: ((MediaQuery.of(context).size.height / 16).ceil() - 4)
                  .toDouble(),
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 4 - 50,
                ),
                child: Row(
                  children: [
                    Image.asset(leadingUrl, width: 25.0, height: 25.0),
                    SizedBox(width: 30.0),
                    Flexible(
                      child: Text(
                        title,
                        textScaleFactor: textScaleFactor,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                        overflow:
                            kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      trailing,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 15.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
