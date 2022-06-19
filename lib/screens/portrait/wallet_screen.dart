import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:travenx_loitafoundation/config/configs.dart';

class WalletScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String profileUrl;
  final void Function() loggedInCallback;
  const WalletScreen({
    Key? key,
    required this.isLoggedIn,
    required this.displayName,
    required this.profileUrl,
    required this.loggedInCallback,
  }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoggedIn == true && widget.displayName != '') {
      SystemChrome.setSystemUIOverlayStyle(
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark);
      return Scaffold(
        backgroundColor: Theme.of(context).bottomAppBarColor == Colors.white
            ? Theme.of(context).primaryColor
            : Theme.of(context).bottomAppBarColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              CustomScrollView(
                primary: false,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      padding: EdgeInsets.all(kHPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset(
                                'assets/animations/random_dot.json',
                                height: MediaQuery.of(context).size.height / 3 -
                                    60 -
                                    2 * kHPadding,
                              ),
                              Lottie.asset(
                                'assets/animations/circle_dot.json',
                                height:
                                    MediaQuery.of(context).size.height / 2.5 -
                                        40 -
                                        2 * kHPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$ 0.10',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 38.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kHPadding),
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Send',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kHPadding),
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Receive',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kHPadding),
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.money,
                                      size: 15,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Deposit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kHPadding),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: kHPadding),
                          Text(
                            '    Tuesday, 17, May, 2022',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '2'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '1'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '5'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '4'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '8'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '6'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '5'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '4'),
                          Divider(color: Theme.of(context).iconTheme.color),
                          _HistoryCard(cent: '8'),
                          const SizedBox(height: 100.0),
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
    } else {
      SystemChrome.setSystemUIOverlayStyle(
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light);
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/travenx.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Screen is logged.'),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedIndex = 3;
                      if (widget.isLoggedIn != false) widget.loggedInCallback();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login Now',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _HistoryCard extends StatelessWidget {
  final String cent;
  const _HistoryCard({Key? key, required this.cent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            text:
                'បង់សេវាកម្ម                                                                         ',
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).iconTheme.color),
            children: [
              TextSpan(
                text: '-\$0.0$cent',
                style: TextStyle(
                    fontSize: 14.0, color: Theme.of(context).errorColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
