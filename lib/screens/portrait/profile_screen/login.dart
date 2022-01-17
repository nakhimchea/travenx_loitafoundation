import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/palette.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/profile_widget.dart';

class Login extends StatefulWidget {
  final void Function() loggedInCallback;
  const Login({
    Key? key,
    required this.loggedInCallback,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPhoneLogin = false;

  void hasPhoneLogin() => setState(() => isPhoneLogin = true);
  void hasLoginMethods() => setState(() => isPhoneLogin = false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_screen/scaffold_background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: !isPhoneLogin
                ? CustomAppBar(skippedCallback: widget.loggedInCallback)
                : LoginAppBar(skippedCallback: widget.loggedInCallback),
          ),
          Positioned(
            width: constraints.maxWidth,
            bottom: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 67.0),
                  child: !isPhoneLogin
                      ? LoginMethods(
                          isPhoneLogin: isPhoneLogin,
                          isPhoneLoginCallback: hasPhoneLogin,
                        )
                      : PhoneLogin(
                          successfulLoggedInCallback: widget.loggedInCallback),
                ),
                PolicyAgreement(),
                !isPhoneLogin
                    ? SignUpRequest(isPhoneLoginCallback: hasPhoneLogin)
                    : SignInRequest(isPhoneLoginCallback: hasLoginMethods),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final void Function() skippedCallback;
  const CustomAppBar({
    Key? key,
    required this.skippedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 44.0, left: 16.0),
          child: Text(
            'Travenx',
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 56.0, right: 30.0),
          child: TextButton(
            onPressed: skippedCallback,
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent)),
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
        )
      ],
    );
  }
}

class LoginAppBar extends StatelessWidget {
  final void Function() skippedCallback;
  const LoginAppBar({
    Key? key,
    required this.skippedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 50.0),
          Text(
            'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20.0),
            child: TextButton(
              onPressed: skippedCallback,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
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
          ),
        ],
      ),
    );
  }
}

class LoginMethods extends StatelessWidget {
  final bool isPhoneLogin;
  final void Function() isPhoneLoginCallback;

  const LoginMethods({
    Key? key,
    required this.isPhoneLogin,
    required this.isPhoneLoginCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginCardButton(
          leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
          title: 'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
          onTap: isPhoneLoginCallback,
        ),
        SizedBox(height: 18.0),
        LoginCardButton(
          leadingUrl: 'assets/icons/profile_screen/facebook_logo.png',
          title: 'ចូលតាមគណនី ហ្វេសប៊ុក',
        ),
        SizedBox(height: 18.0),
        LoginCardButton(
            leadingUrl: 'assets/icons/profile_screen/google_logo.png',
            title: 'ចូលតាមគណនី ',
            trailing: 'Google'),
      ],
    );
  }
}

class GradientButton extends StatelessWidget {
  final String title;
  final bool isCodeSent;
  final BoxConstraints constraints;
  final void Function() onPressed;
  const GradientButton({
    Key? key,
    required this.title,
    required this.isCodeSent,
    required this.constraints,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Stack(
        children: [
          Container(
            width: constraints.maxWidth / 3,
            height: (MediaQuery.of(context).size.height / 12).ceil().toDouble(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/images/profile_screen/card_background.png',
                width: constraints.maxWidth - 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3.0),
            width: constraints.maxWidth / 3 - 6,
            height: ((MediaQuery.of(context).size.height / 12).ceil() - 6)
                .toDouble(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: TextButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(isCodeSent
                      ? Palette.priceColor.withOpacity(0.2)
                      : Colors.transparent)),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: isCodeSent
                        ? Palette.priceColor
                        : Theme.of(context).disabledColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneLogin extends StatefulWidget {
  final void Function() successfulLoggedInCallback;
  const PhoneLogin({
    Key? key,
    required this.successfulLoggedInCallback,
  }) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  String _phoneNumber = '';
  String _otpNumber = '';

  void _getPhoneNumber(String text) => setState(() => _phoneNumber = text);

  void _getOtpNumber(String text) => setState(() => _otpNumber = text);

  bool _isCodeSent = false;

  void _toggleCodeSent() => setState(() => _isCodeSent = !_isCodeSent);

  void _verifyOtpNumber() {
    print(_otpNumber);
    print(_otpNumber == '123456' ? 'OTP ត្រឹមត្រូវ' : 'OTP មិនត្រឹមត្រូវ');
    if (_otpNumber == '123456') widget.successfulLoggedInCallback();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'សូមបំពេញលេខទូរសព្ទ',
            textScaleFactor: textScaleFactor,
            style: TextStyle(
              color: Colors.black38,
              fontSize: 18.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 50.0),
          Column(
            children: [
              LoginTextField(
                logoUrl: 'assets/icons/profile_screen/phone_logo.png',
                hintText: '012345678',
                constraints: constraints,
                onChangedCallback: _getPhoneNumber,
                isCodeSent: _isCodeSent,
                isCodeSentCallback: _toggleCodeSent,
              ),
              SizedBox(height: 26.0),
              LoginTextField(
                logoUrl:
                    'assets/icons/profile_screen/one_time_password_logo.png',
                hintText: '******',
                constraints: constraints,
                onChangedCallback: _getOtpNumber,
                phoneNumber: _phoneNumber,
                isCodeSent: !_isCodeSent,
                isCodeSentCallback: _toggleCodeSent,
              ),
              SizedBox(height: 50.0),
              GradientButton(
                title: 'ចូល',
                isCodeSent: _isCodeSent,
                constraints: constraints,
                onPressed: _verifyOtpNumber,
              ),
            ],
          ),
        ],
      );
    });
  }
}

class PolicyAgreement extends StatelessWidget {
  const PolicyAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Policy Button click...'),
      child: Column(
        children: [
          Text(
            'តាមរយ:ការប្រើកម្មវិធីនេះ អ្នកយល់ព្រមទទួលយក',
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
    );
  }
}

class SignInRequest extends StatelessWidget {
  final void Function() isPhoneLoginCallback;
  const SignInRequest({
    Key? key,
    required this.isPhoneLoginCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'មានគណនីរួច? ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 3,
            fontFamily: 'Nokora',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: isPhoneLoginCallback,
          child: Text(
            'ចូលតាមគណនីផ្សេងទៀត',
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
    );
  }
}

class SignUpRequest extends StatelessWidget {
  final void Function() isPhoneLoginCallback;
  const SignUpRequest({
    Key? key,
    required this.isPhoneLoginCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ត្រូវការគណនី? ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 3,
            fontFamily: 'Nokora',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: isPhoneLoginCallback,
          child: Text(
            'ចុះឈ្មោះឥឡូវនេះ',
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
    );
  }
}
