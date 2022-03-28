import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/services/authentication_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/custom_floating_action_button.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).colorScheme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light);
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            alignment: Alignment(0, -1.1),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_screen/login_background.png',
                ),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Colors.black26
                      : Colors.black45,
                  BlendMode.srcOver,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: !_isPhoneLogin
                ? CustomAppBar(skippedCallback: widget.loggedInCallback)
                : LoginAppBar(
                    skippedCallback: widget.loggedInCallback,
                    loggedInMethodsCallback: hasLoginMethods),
          ),
          Positioned(
            width: constraints.maxWidth,
            bottom: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 15),
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
                const SizedBox(height: 50),
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
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 11,
            left: 16.0,
          ),
          child: Text('',

              ///Can be used with App Name
              textScaleFactor: textScaleFactor,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).bottomAppBarColor)),
        ),
        Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 10,
              right: MediaQuery.of(context).size.width / 20),
          child: TextButton(
            onPressed: () async {
              await FlutterSecureStorage().write(key: 'userId', value: '');
              await FlutterSecureStorage()
                  .write(key: 'isAnonymous', value: 'true');
              skippedCallback();
            },
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
            child: Text('រំលង',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Colors.white
                        : Colors.white60)),
          ),
        )
      ],
    );
  }
}

class LoginAppBar extends StatelessWidget {
  final void Function() skippedCallback;
  final void Function() loggedInMethodsCallback;
  const LoginAppBar({
    Key? key,
    required this.skippedCallback,
    required this.loggedInMethodsCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6.5,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 10 - 5,
                  left: MediaQuery.of(context).size.width / 20),
              child: CustomFloatingActionButton(
                iconColor: Colors.black,
                onTap: loggedInMethodsCallback,
              )),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 10,
                right: MediaQuery.of(context).size.width / 20),
            child: TextButton(
              onPressed: () async {
                await FlutterSecureStorage().write(key: 'userId', value: '');
                await FlutterSecureStorage()
                    .write(key: 'isAnonymous', value: 'true');
                skippedCallback();
              },
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              child: Text('រំលង',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Colors.white
                          : Colors.white60)),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/home_screen/kep.jpg',
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 80),
              Text('ចូលតាមគណនី',
                  textScaleFactor: textScaleFactor,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white)),
              const SizedBox(height: 30.0),
              LoginCardButton(
                leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
                title: 'ភ្ជាប់តាមគណនី លេខទូរសព្ទ',
                titleColor: Theme.of(context).primaryColor,
                onTap: widget.isPhoneLoginCallback,
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 2.0,
                      width: (MediaQuery.of(context).size.width - (30 * 4)) / 2,
                      color: Colors.white60,
                    ),
                    Text(
                      'ឬ',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white60, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 2.0,
                      width: (MediaQuery.of(context).size.width - (30 * 4)) / 2,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              LoginCardButton(
                  leadingUrl: 'assets/icons/profile_screen/facebook_logo.png',
                  title: 'ភ្ជាប់តាមគណនី ហ្វេសប៊ុក',
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
              const SizedBox(height: 15.0),
              LoginCardButton(
                leadingUrl: 'assets/icons/profile_screen/google_logo.png',
                title: 'ភ្ជាប់តាមគណនី ',
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

class LoginButton extends StatelessWidget {
  final String title;
  final bool isCodeSent;
  final void Function() onPressed;
  const LoginButton({
    Key? key,
    required this.title,
    required this.isCodeSent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        margin: EdgeInsets.all(3.0),
        width: double.infinity,
        height: (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
        decoration: BoxDecoration(
          color: isCodeSent
              ? Theme.of(context).primaryColor
              : Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(isCodeSent
                  ? Theme.of(context).bottomAppBarColor.withOpacity(0.2)
                  : Colors.transparent)),
          child: Text(
            title,
            textScaleFactor: MediaQuery.of(context).size.width / 428,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: isCodeSent
                    ? Theme.of(context).bottomAppBarColor
                    : Theme.of(context).disabledColor),
          ),
        ),
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
  bool _pinCodeEnabled = true;

  void _toggleShowLogin() => setState(() => _showLogin = !_showLogin);

  void _toggleCodeSent() {
    if (mounted) setState(() => _isCodeSent = !_isCodeSent);
  }

  void _getSmsCodeId(String text) {
    if (mounted) setState(() => _smsCodeId = text);
  }

  void _isLoggingIn() async {
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
        .whenComplete(() => setState(() {
              _isLoading = false;
              _pinCodeEnabled = true;
            }));
  }

  void _getOtpNumber(String text) {
    if (mounted) setState(() => _otpNumber = text.trim());
    if (_otpNumber.length >= 6) {
      setState(() => _pinCodeEnabled = false);
      _isLoggingIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ភ្ជាប់តាមលេខទូរសព្ទ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Theme.of(context).bottomAppBarColor)),
        SizedBox(height: MediaQuery.of(context).size.height / 22),
        Column(
          children: [
            LoginTextField(
              logoUrl: 'assets/icons/profile_screen/phone_logo.png',
              hintText: '012345678',
              onChangedCallback: _getPhoneNumber,
              isCodeSent: _isCodeSent,
              isCodeSentCallback: _toggleCodeSent,
              showLoginCallback: _toggleShowLogin,
            ),
            const SizedBox(height: 15),
            LoginTextField(
              logoUrl: 'assets/icons/profile_screen/one_time_password_logo.png',
              hintText: 'បញ្ចូលលេខកូដ',
              onChangedCallback: _getOtpNumber,
              isCodeSent: !_isCodeSent,
              pinCodeEnabled: _pinCodeEnabled,
              isCodeSentCallback: _toggleCodeSent,
              smsCodeIdSentCallback: _getSmsCodeId,
              phoneNumber: _phoneNumber,
              showLoginCallback: _toggleShowLogin,
            ),
            const SizedBox(height: 30),
            _isLoading
                ? Loading()
                : _showLogin
                    ? LoginButton(
                        title: 'ចូល',
                        isCodeSent: _isCodeSent,
                        onPressed: _isLoggingIn,
                      )
                    : SizedBox(height: MediaQuery.of(context).size.height / 16),
          ],
        ),
      ],
    );
  }
}

class PolicyAgreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Policy Button click...'),
      child: Column(
        children: [
          Text('តាមរយ:ការប្រើកម្មវិធីនេះ អ្នកយល់ព្រមទទួលយក',
              style: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Colors.white
                      : Colors.white60)),
          SizedBox(height: 3),
          Text('លក្ខខណ្ឌ និងគោលនយោបាយឯកជនភាព',
              style: Theme.of(context).textTheme.button!.copyWith(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.light
                      ? Colors.white
                      : Colors.white60,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
