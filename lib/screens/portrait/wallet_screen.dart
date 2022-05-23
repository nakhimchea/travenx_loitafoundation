import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    if (widget.isLoggedIn == true)
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: SvgPicture.asset(
            'assets/images/home_screen/sub/boating.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.cover,
          ),
        ),
      );
    else if (widget.isLoggedIn == true && widget.displayName != '') {
      SystemChrome.setSystemUIOverlayStyle(
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark);
      return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              CustomScrollView(
                primary: false,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: constraints.maxWidth,
                      padding: EdgeInsets.all(constraints.maxWidth / 8),
                      child: Container(
                        padding: EdgeInsets.all(constraints.maxWidth / 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(3, 3),
                              blurRadius: 15.0,
                            ),
                          ],
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Total balance',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$ 0.10',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                    fontSize: 44.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green.shade100,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.volunteer_activism_outlined,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: kHPadding),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _HistoryCard(),
                          _HistoryCard(),
                          _HistoryCard(),
                          _HistoryCard(),
                          _HistoryCard(),
                          _HistoryCard(),
                          const SizedBox(height: 15.0),
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
  const _HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).bottomAppBarColor,
        ),
        child: Center(
          child: Text(
            'ថ្ងៃទី ២១ ខែ ៧ ឆ្នាំ ២០២២ បានចំណាយប្រាក់            ចំនួន \$0.05',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
