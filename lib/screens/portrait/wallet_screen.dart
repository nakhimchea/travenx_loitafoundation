import 'package:flutter/material.dart';
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
    if (widget.isLoggedIn == true && widget.displayName != '')
      return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              // Image.asset(
              //   'assets/images/profile_screen/scaffold_background.png',
              //   height: constraints.maxHeight,
              //   width: constraints.maxWidth,
              //   fit: BoxFit.cover,
              // ),
              CustomScrollView(
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
                              style: TextStyle(fontSize: 16),
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
                                  SizedBox(width: 5),
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
                    padding: EdgeInsets.symmetric(horizontal: kHPadding),
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
    else
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile_screen/scaffold_background.png',
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
                  TextButton(
                    onPressed: () {
                      selectedIndex = 3;
                      if (widget.isLoggedIn != false) widget.loggedInCallback();
                    },
                    child: Center(
                      child: Text('Login Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
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
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
