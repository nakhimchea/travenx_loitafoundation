import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            alignment: const Alignment(0, -1.1),
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
                ? _CustomAppBar(skippedCallback: widget.loggedInCallback)
                : _LoginAppBar(
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
                  margin: const EdgeInsets.only(bottom: 25.0),
                  child: !_isPhoneLogin
                      ? _LoginMethods(
                          isPhoneLogin: _isPhoneLogin,
                          isPhoneLoginCallback: hasPhoneLogin,
                          successfulLoggedInCallback: widget.loggedInCallback,
                          fbGgAuthCredentialCallback: setAuthCredential,
                          setProfileCallback: widget.getProfileCallback,
                        )
                      : _PhoneLogin(
                          fbGgAuthCredential: _fbGgAuthCredential,
                          successfulLoggedInCallback: widget.loggedInCallback,
                          setProfileCallback: widget.getProfileCallback,
                        ),
                ),
                _PolicyAgreement(),
                const SizedBox(height: 85.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final void Function() skippedCallback;
  const _CustomAppBar({
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
                  .displayLarge!
                  .copyWith(color: Theme.of(context).canvasColor)),
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
            child: Text(
              AppLocalizations.of(context)!.skipLabel,
              textScaleFactor: textScaleFactor,
              style: AppLocalizations.of(context)!.localeName == 'km'
                  ? Theme.of(context).primaryTextTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).canvasColor.withOpacity(0.6))
                  : Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).canvasColor.withOpacity(0.6)),
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginAppBar extends StatelessWidget {
  final void Function() skippedCallback;
  final void Function() loggedInMethodsCallback;
  const _LoginAppBar({
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
            child: CustomFloatingActionButton(onTap: loggedInMethodsCallback),
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
              child: Text(
                AppLocalizations.of(context)!.skipLabel,
                textScaleFactor: textScaleFactor,
                style: AppLocalizations.of(context)!.localeName == 'km'
                    ? Theme.of(context)
                        .primaryTextTheme
                        .headlineLarge!
                        .copyWith(
                            color: Theme.of(context).colorScheme.brightness ==
                                    Brightness.light
                                ? Theme.of(context).canvasColor
                                : Theme.of(context)
                                    .canvasColor
                                    .withOpacity(0.6))
                    : Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.light
                            ? Theme.of(context).canvasColor
                            : Theme.of(context).canvasColor.withOpacity(0.6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginMethods extends StatefulWidget {
  final bool isPhoneLogin;
  final void Function() isPhoneLoginCallback;
  final void Function() successfulLoggedInCallback;
  final void Function(AuthCredential) fbGgAuthCredentialCallback;
  final void Function() setProfileCallback;

  const _LoginMethods({
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

class _LoginMethodsState extends State<_LoginMethods> {
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
                  'assets/images/travenx.png',
                  height: 110 * textScaleFactor,
                  width: 110 * textScaleFactor,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 80 * textScaleFactor),
              LoginCardButton(
                leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
                title: AppLocalizations.of(context)!.lgConnectPhone,
                titleColor: Theme.of(context).primaryColor,
                onTap: widget.isPhoneLoginCallback,
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 26.0 * textScaleFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 2.0,
                      width: (MediaQuery.of(context).size.width - (30 * 4)) / 2,
                      color: Theme.of(context).canvasColor.withOpacity(0.6),
                    ),
                    Text(
                      AppLocalizations.of(context)!.lgOr,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).canvasColor.withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 2.0,
                      width: (MediaQuery.of(context).size.width - (30 * 4)) / 2,
                      color: Theme.of(context).canvasColor.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              LoginCardButton(
                  leadingUrl: 'assets/icons/profile_screen/facebook_logo.png',
                  title: AppLocalizations.of(context)!.lgConnectFacebook,
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
                title: AppLocalizations.of(context)!.lgConnect,
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

class _LoginButton extends StatelessWidget {
  final String title;
  final bool isCodeSent;
  final void Function() onPressed;
  const _LoginButton({
    Key? key,
    required this.title,
    required this.isCodeSent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0 * textScaleFactor),
      child: Container(
        margin: const EdgeInsets.all(3.0),
        width: double.infinity,
        height: (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
        decoration: BoxDecoration(
          color: isCodeSent
              ? Theme.of(context).primaryColor
              : Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(isCodeSent
                  ? Theme.of(context).canvasColor.withOpacity(0.2)
                  : Colors.transparent)),
          child: Text(
            title,
            textScaleFactor: MediaQuery.of(context).size.width / 428,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                    color: isCodeSent
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).disabledColor)
                : Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: isCodeSent
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).disabledColor),
          ),
        ),
      ),
    );
  }
}

class _PhoneLogin extends StatefulWidget {
  final AuthCredential? fbGgAuthCredential;
  final void Function() successfulLoggedInCallback;
  final void Function() setProfileCallback;
  const _PhoneLogin({
    Key? key,
    this.fbGgAuthCredential,
    required this.successfulLoggedInCallback,
    required this.setProfileCallback,
  }) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<_PhoneLogin> {
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
        Text(
          AppLocalizations.of(context)!.lgConnectPhone,
          textScaleFactor: textScaleFactor,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context)
                  .primaryTextTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).canvasColor)
              : Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).canvasColor),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 22),
        Column(
          children: [
            LoginTextField(
              logoUrl: 'assets/icons/profile_screen/phone_logo_login.png',
              hintText: '012345678',
              onChangedCallback: _getPhoneNumber,
              isCodeSent: _isCodeSent,
              isCodeSentCallback: _toggleCodeSent,
              showLoginCallback: _toggleShowLogin,
            ),
            const SizedBox(height: 15),
            LoginTextField(
              logoUrl: 'assets/icons/profile_screen/one_time_password_logo.png',
              hintText: AppLocalizations.of(context)!.lgEnterCode,
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
                    ? _LoginButton(
                        title: AppLocalizations.of(context)!.lgLogIn,
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

class _PolicyAgreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Policy Button click...'),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.lgAccept,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).canvasColor.withOpacity(0.6))
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).canvasColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 3),
          Text(
            AppLocalizations.of(context)!.lgTermsPolicies,
            textScaleFactor: textScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).canvasColor.withOpacity(0.6),
                    fontWeight: FontWeight.w700)
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Theme.of(context).canvasColor
                        : Theme.of(context).canvasColor.withOpacity(0.6),
                    fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
