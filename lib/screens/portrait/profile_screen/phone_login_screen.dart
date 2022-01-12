import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/profile.dart';

class PhoneLoginScreen extends StatefulWidget {
  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_screen/scaffold_background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: CustomAppBar(textScaleFactor: textScaleFactor),
          ),
          PhoneLogin(textScaleFactor: textScaleFactor),
          Footer(textScaleFactor: textScaleFactor),
        ],
      ),
    );
  }
}

class PhoneLogin extends StatefulWidget {
  final double textScaleFactor;

  const PhoneLogin({Key? key, required this.textScaleFactor}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'សូមបំពេញលេខទូរសព្ទ',
            textScaleFactor: widget.textScaleFactor,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 26.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height / 16)
                            .ceil()
                            .toDouble(),
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
                        height:
                            ((MediaQuery.of(context).size.height / 16).ceil() -
                                    4)
                                .toDouble(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Image.asset(
                                'assets/icons/profile_screen/phone_logo.png',
                                width: 23.0,
                                height: 23.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Container(
                              width: MediaQuery.of(context).size.width - 207.0,
                              child: TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: '012345678',
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 26.0),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height / 16)
                              .ceil()
                              .toDouble(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/images/profile_screen/card_background.png',
                              width: 224,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2.0),
                          height: ((MediaQuery.of(context).size.height / 16)
                                      .ceil() -
                                  4)
                              .toDouble(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 48.0),
                                child: Image.asset(
                                  'assets/icons/profile_screen/one_time_password_logo.png',
                                  width: 27.0,
                                  height: 27.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 18.0),
                              Container(
                                width: 127.0,
                                child: TextField(
                                  controller: otpCodeController,
                                  decoration: InputDecoration(
                                    hintText: '******',
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 32.0),
                    Stack(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height / 16)
                              .ceil()
                              .toDouble(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/images/profile_screen/card_background.png',
                              width: MediaQuery.of(context).size.width - 316.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2.0),
                          width: MediaQuery.of(context).size.width - 320.0,
                          height: ((MediaQuery.of(context).size.height / 16)
                                      .ceil() -
                                  4)
                              .toDouble(),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              verifyNumber();
                            },
                            child: Text(
                              'ផ្ញើលេខកូដ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                                fontFamily: 'Nokora',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height / 16)
                            .ceil()
                            .toDouble(),
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
                        width: MediaQuery.of(context).size.width - 64,
                        height:
                            ((MediaQuery.of(context).size.height / 16).ceil() -
                                    4)
                                .toDouble(),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Profile())),
                          child: Text(
                            'ចូលទៅកាន់គណនី',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20.0,
                              fontFamily: 'Nokora',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void verifyNumber() {}
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required double textScaleFactor,
  })  : _textScaleFactor = textScaleFactor,
        super(key: key);

  final double _textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => print('Policy Button click...'),
            child: Column(
              children: [
                Text(
                  'តាមរយ:ការប្រើកម្មវិធីនេះ អ្នកយល់ព្រមទទួលយក',
                  textScaleFactor: _textScaleFactor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    height: 1.67,
                    fontFamily: 'Nokora',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'លក្ខខណ្ឌ និងគោលនយោបាយឯកជនភាព',
                  textScaleFactor: _textScaleFactor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    height: 1.67,
                    fontFamily: 'Nokora',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'មានគណនីរួច? ',
                textScaleFactor: _textScaleFactor,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  height: 3,
                  fontFamily: 'Nokora',
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () => print('Sign in button click...'),
                child: Text(
                  'ចូលទៅកាន់គណនីអ្នក',
                  textScaleFactor: _textScaleFactor,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    height: 3,
                    fontFamily: 'Nokora',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required double textScaleFactor,
  })  : _textScaleFactor = textScaleFactor,
        super(key: key);

  final double _textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          Text(
            'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
            textScaleFactor: _textScaleFactor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, right: 20.0),
            child: Text(
              'រំលង',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Nokora',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
