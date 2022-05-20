import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart';
import 'package:travenx_loitafoundation/services/authentication_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';
import 'package:travenx_loitafoundation/widgets/loading_dialog.dart';

class LoginTextField extends StatefulWidget {
  final String logoUrl;
  final String hintText;
  final void Function(String) onChangedCallback;
  final bool isCodeSent;
  final bool? pinCodeEnabled;
  final void Function() isCodeSentCallback;
  final void Function(String)? smsCodeIdSentCallback;
  final String phoneNumber;
  final void Function() showLoginCallback;

  const LoginTextField({
    Key? key,
    required this.logoUrl,
    required this.hintText,
    required this.onChangedCallback,
    required this.isCodeSent,
    this.pinCodeEnabled,
    required this.isCodeSentCallback,
    this.smsCodeIdSentCallback,
    this.phoneNumber = '',
    required this.showLoginCallback,
  }) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  int _countSeconds = 60;
  bool _isLoading = false;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) // If user logged in, there is no Countdown widget, Destroyed
        setState(() {
          if (_countSeconds <= 1) {
            timer.cancel();
            widget.isCodeSentCallback();
            _countSeconds = 120;
          } else
            _countSeconds--;
        });
    });
  }

  void setData(String verificationId) {
    widget.smsCodeIdSentCallback!(verificationId);
    widget.isCodeSentCallback();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Stack(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height / 16)
                      .ceil()
                      .toDouble(),
                  decoration: BoxDecoration(
                    color: widget.isCodeSent
                        ? Theme.of(context).bottomAppBarColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  height: ((MediaQuery.of(context).size.height / 16).ceil() - 2)
                      .toDouble(),
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 62.0,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Image.asset(
                          widget.logoUrl,
                          width: widget.hintText ==
                                  AppLocalizations.of(context)!.lgEnterCode
                              ? 36.0
                              : 22.0,
                          height: widget.hintText ==
                                  AppLocalizations.of(context)!.lgEnterCode
                              ? 36.0
                              : 22.0,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Container(
                        width: MediaQuery.of(context).size.width - 167.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontFamily: 'Nokora',
                                ),
                                cursorHeight: 16.0,
                                enabled: widget.pinCodeEnabled != null
                                    ? !widget.isCodeSent &&
                                        widget.pinCodeEnabled!
                                    : !widget.isCodeSent,
                                autofocus: widget.pinCodeEnabled != null
                                    ? !widget.isCodeSent &&
                                        widget.pinCodeEnabled!
                                    : !widget.isCodeSent,
                                onChanged: widget.onChangedCallback,
                                decoration: InputDecoration(
                                  hintText: widget.hintText,
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color,
                                    fontFamily: 'Nokora',
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            widget.phoneNumber != ''
                                ? Row(
                                    children: [
                                      Visibility(
                                        visible: widget.isCodeSent,
                                        child: TextButton(
                                          onPressed: () async {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    LoadingDialog());
                                            widget.showLoginCallback();
                                            setState(() => _isLoading = true);
                                            await AuthService()
                                                .verifyPhoneNumber(
                                                    context,
                                                    widget.phoneNumber,
                                                    _countSeconds,
                                                    setData)
                                                .whenComplete(() {
                                              setState(
                                                  () => _isLoading = false);
                                              widget.showLoginCallback();
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateProperty
                                                .all<Color>(
                                              Colors.transparent,
                                            ),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .lgSendCode,
                                            textScaleFactor: textScaleFactor,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontSize: 14.0,
                                                    fontFamily: 'Nokora'),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !widget.isCodeSent,
                                        child: Text(
                                            '$_countSeconds ${AppLocalizations.of(context)!.lgSecond + ((AppLocalizations.of(context)!.localeName == 'en' && _countSeconds > 1) ? 's' : '')}',
                                            textScaleFactor: textScaleFactor,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 14.0,
                                                    fontFamily: 'Nokora')),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
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
}
