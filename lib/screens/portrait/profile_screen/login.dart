import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
            alignment: Alignment(0, -1.1),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_screen/scaffold_background.png',
                ),
                fit: BoxFit.cover,
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
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 11,
            left: 16.0,
          ),
          child: Text('Travenx',
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
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white)),
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
      height: MediaQuery.of(context).size.height / 6.9,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 50.0),
          Text('ចុះឈ្មោះគណនី លេខទូរសព្ទ',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).bottomAppBarColor)),
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
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              child: Text('រំលង',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white)),
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
  final void Function() onPressed;
  const GradientButton({
    Key? key,
    required this.title,
    required this.isCodeSent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: (MediaQuery.of(context).size.height / 12).ceil().toDouble(),
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
            margin: EdgeInsets.all(3.0),
            width: MediaQuery.of(context).size.width / 3 - 6,
            height: ((MediaQuery.of(context).size.height / 12).ceil() - 6)
                .toDouble(),
            decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: TextButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(isCodeSent
                      ? Theme.of(context).highlightColor.withOpacity(0.2)
                      : Colors.transparent)),
              child: Text(
                title,
                textScaleFactor: MediaQuery.of(context).size.width / 428,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: isCodeSent
                        ? Theme.of(context).highlightColor
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('សូមបំពេញលេខទូរសព្ទ',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 18.0)),
        SizedBox(height: MediaQuery.of(context).size.height / 17),
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
            SizedBox(height: MediaQuery.of(context).size.height / 34),
            LoginTextField(
              logoUrl: 'assets/icons/profile_screen/one_time_password_logo.png',
              hintText: '******',
              onChangedCallback: _getOtpNumber,
              isCodeSent: !_isCodeSent,
              isCodeSentCallback: _toggleCodeSent,
              smsCodeIdSentCallback: _getSmsCodeId,
              phoneNumber: _phoneNumber,
              showLoginCallback: _toggleShowLogin,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 17),
            _isLoading
                ? Loading()
                : _showLogin
                    ? GradientButton(
                        title: 'ចូល',
                        isCodeSent: _isCodeSent,
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
              style: Theme.of(context).textTheme.button),
          SizedBox(height: 3),
          Text('លក្ខខណ្ឌ និងគោលនយោបាយឯកជនភាព',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(fontWeight: FontWeight.w700)),
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
        Text('មានគណនីរួច? ',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).bottomAppBarColor,
                height: 3.0,
                fontWeight: FontWeight.w400)),
        GestureDetector(
          onTap: isPhoneLoginCallback,
          child: Text('ចូលតាមគណនីផ្សេងទៀត',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).bottomAppBarColor, height: 3.0)),
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
        Text('ត្រូវការគណនី? ',
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).bottomAppBarColor,
                height: 3.0,
                fontWeight: FontWeight.w400)),
        GestureDetector(
          onTap: isPhoneLoginCallback,
          child: Text('ចុះឈ្មោះឥឡូវនេះ',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context).bottomAppBarColor, height: 3.0)),
        ),
      ],
    );
  }
}
