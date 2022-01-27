import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/palette.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/services/authentication_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/login_card_button.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/login_text_field.dart';

class Login extends StatefulWidget {
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  const Login({
    Key? key,
    required this.loggedInCallback,
    required this.getProfileCallback,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPhoneLogin = false;
  AuthCredential? _fbGgAuthCredential;

  void hasPhoneLogin() => setState(() => _isPhoneLogin = true);
  void hasLoginMethods() => setState(() => _isPhoneLogin = false);

  void setAuthCredential(AuthCredential authCredential) {
    setState(() => _fbGgAuthCredential = authCredential);
    FirebaseAuth.instance.signOut();
    hasPhoneLogin();
  }

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
            child: !_isPhoneLogin
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
                  child: !_isPhoneLogin
                      ? LoginMethods(
                          isPhoneLogin: _isPhoneLogin,
                          isPhoneLoginCallback: hasPhoneLogin,
                          successfulLoggedInCallback: widget.loggedInCallback,
                          fbGgAuthCredentialCallback: setAuthCredential,
                          setProfileCallback: widget.getProfileCallback,
                        )
                      : PhoneLogin(
                          fbGgAuthCredential: _fbGgAuthCredential,
                          successfulLoggedInCallback: widget.loggedInCallback,
                          setProfileCallback: widget.getProfileCallback,
                        ),
                ),
                PolicyAgreement(),
                !_isPhoneLogin
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
            onPressed: () async {
              await FlutterSecureStorage().write(key: 'userId', value: '');
              await FlutterSecureStorage()
                  .write(key: 'isAnonymous', value: 'true');
              skippedCallback();
            },
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
              onPressed: () async {
                await FlutterSecureStorage().write(key: 'userId', value: '');
                await FlutterSecureStorage()
                    .write(key: 'isAnonymous', value: 'true');
                skippedCallback();
              },
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

class LoginMethods extends StatefulWidget {
  final bool isPhoneLogin;
  final void Function() isPhoneLoginCallback;
  final void Function() successfulLoggedInCallback;
  final void Function(AuthCredential) fbGgAuthCredentialCallback;
  final void Function() setProfileCallback;

  const LoginMethods({
    Key? key,
    required this.isPhoneLogin,
    required this.isPhoneLoginCallback,
    required this.successfulLoggedInCallback,
    required this.fbGgAuthCredentialCallback,
    required this.setProfileCallback,
  }) : super(key: key);

  @override
  _LoginMethodsState createState() => _LoginMethodsState();
}

class _LoginMethodsState extends State<LoginMethods> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Column(
            children: [
              LoginCardButton(
                leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
                title: 'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
                onTap: widget.isPhoneLoginCallback,
              ),
              SizedBox(height: 18.0),
              LoginCardButton(
                  leadingUrl: 'assets/icons/profile_screen/facebook_logo.png',
                  title: 'ចូលតាមគណនី ហ្វេសប៊ុក',
                  onTap: () async {
                    setState(() => _isLoading = true);
                    await AuthService()
                        .signInWithFacebook(
                          context,
                          widget.successfulLoggedInCallback,
                          widget.fbGgAuthCredentialCallback,
                          widget.setProfileCallback,
                        )
                        .whenComplete(() => setState(() => _isLoading = false));
                  }),
              SizedBox(height: 18.0),
              LoginCardButton(
                leadingUrl: 'assets/icons/profile_screen/google_logo.png',
                title: 'ចូលតាមគណនី ',
                trailing: 'Google',
                onTap: () async {
                  setState(() => _isLoading = true);
                  await AuthService()
                      .signInWithGoogle(
                        context,
                        widget.successfulLoggedInCallback,
                        widget.fbGgAuthCredentialCallback,
                        widget.setProfileCallback,
                      )
                      .whenComplete(() => setState(() => _isLoading = false));
                },
              ),
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
  final AuthCredential? fbGgAuthCredential;
  final void Function() successfulLoggedInCallback;
  final void Function() setProfileCallback;
  const PhoneLogin({
    Key? key,
    this.fbGgAuthCredential,
    required this.successfulLoggedInCallback,
    required this.setProfileCallback,
  }) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  String _phoneNumber = '';
  String _otpNumber = '';
  String _smsCodeId = '';
  bool _isLoading = false;
  bool _showLogin = true;

  // Callback input phoneNumber and clean number with country code
  void _getPhoneNumber(String text) {
    if (mounted && text != '')
      setState(() =>
          _phoneNumber = '+855${text[0] == '0' ? text.substring(1) : text}');
  }

  bool _isCodeSent = false;

  void _toggleShowLogin() => setState(() => _showLogin = !_showLogin);

  void _toggleCodeSent() {
    if (mounted) setState(() => _isCodeSent = !_isCodeSent);
  }

  void _getSmsCodeId(String text) {
    if (mounted) setState(() => _smsCodeId = text);
  }

  void _getOtpNumber(String text) {
    if (mounted) setState(() => _otpNumber = text.trim());
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
                showLoginCallback: _toggleShowLogin,
              ),
              SizedBox(height: 26.0),
              LoginTextField(
                logoUrl:
                    'assets/icons/profile_screen/one_time_password_logo.png',
                hintText: '******',
                constraints: constraints,
                onChangedCallback: _getOtpNumber,
                isCodeSent: !_isCodeSent,
                isCodeSentCallback: _toggleCodeSent,
                smsCodeIdSentCallback: _getSmsCodeId,
                phoneNumber: _phoneNumber,
                showLoginCallback: _toggleShowLogin,
              ),
              SizedBox(height: 50.0),
              _isLoading
                  ? Loading()
                  : _showLogin
                      ? GradientButton(
                          title: 'ចូល',
                          isCodeSent: _isCodeSent,
                          constraints: constraints,
                          onPressed: () async {
                            if (_isCodeSent) setState(() => _isLoading = true);
                            await AuthService()
                                .signInWithPhoneNumber(
                                  context,
                                  _smsCodeId,
                                  _otpNumber,
                                  widget.successfulLoggedInCallback,
                                  widget.setProfileCallback,
                                  widget.fbGgAuthCredential,
                                )
                                .whenComplete(
                                    () => setState(() => _isLoading = false));
                          },
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 16),
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
              color: Colors.white60,
              fontSize: 12.0,
              height: 1.67,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'លក្ខខណ្ឌ និងគោលនយោបាយឯកជនភាព',
            style: const TextStyle(
              color: Colors.white60,
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
