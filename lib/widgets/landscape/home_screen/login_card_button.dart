import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: constraints.maxWidth / 10 - 12),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                height:
                    (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/profile_screen/card_background.png',
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
                    horizontal: constraints.maxWidth / 6 - 20,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        leadingUrl,
                        width: 5 + constraints.maxWidth / 20,
                        height: 5 + constraints.maxWidth / 20,
                      ),
                      SizedBox(width: constraints.maxWidth / 10 - 12),
                      Flexible(
                        child: Text(
                          title,
                          textScaleFactor: constraints.maxWidth / 200 > 1.6
                              ? 1.6
                              : constraints.maxWidth / 200,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 10.0, fontWeight: FontWeight.w400),
                          overflow: kIsWeb
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        trailing,
                        textScaleFactor: constraints.maxWidth / 200 > 1.6
                            ? 1.6
                            : constraints.maxWidth / 200,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 10.0,
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
      ),
    );
  }
}
