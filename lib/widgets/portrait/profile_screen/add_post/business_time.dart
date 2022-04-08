import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;

class BusinessTime extends StatelessWidget {
  final bool openEnabled;
  final void Function() openEnabledCallback;
  final bool closeEnabled;
  final void Function() closeEnabledCallback;
  const BusinessTime({
    Key? key,
    required this.openEnabled,
    required this.openEnabledCallback,
    required this.closeEnabled,
    required this.closeEnabledCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ព័ត៌មានបន្ថែម',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: kHPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  openEnabledCallback();
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: kVPadding),
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: !openEnabled
                            ? Theme.of(context)
                                .primaryIconTheme
                                .color!
                                .withOpacity(0.5)
                            : Theme.of(context).primaryColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: kHPadding),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 -
                            kHPadding -
                            5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '5:00 AM',
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: openEnabled
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                              fontSize: 14 * textScaleFactor),
                        ),
                      ),
                    ),
                    Positioned(
                      left: kHPadding,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        color: Theme.of(context).bottomAppBarColor,
                        child: Text(
                          'ម៉ោងបើក',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: openEnabled
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8)
                                  : null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  closeEnabledCallback();
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: kVPadding),
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        color: !closeEnabled
                            ? Theme.of(context)
                                .primaryIconTheme
                                .color!
                                .withOpacity(0.5)
                            : Theme.of(context).errorColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: kHPadding),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 -
                            kHPadding -
                            5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '9:00 PM',
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: closeEnabled
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                              fontSize: 14 * textScaleFactor),
                        ),
                      ),
                    ),
                    Positioned(
                      left: kHPadding,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        color: Theme.of(context).bottomAppBarColor,
                        child: Text(
                          'ម៉ោងបិទ',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: closeEnabled
                                  ? Theme.of(context)
                                      .errorColor
                                      .withOpacity(0.8)
                                  : null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
