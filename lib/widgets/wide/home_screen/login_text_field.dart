import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/services/authentication_service.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';

class LoginTextField extends StatefulWidget {
  final String logoUrl;
  final String hintText;
  final BoxConstraints constraints;
  final void Function(String) onChangedCallback;
  final bool isCodeSent;
  final void Function() isCodeSentCallback;
  final void Function(String)? smsCodeIdSentCallback;
  final String phoneNumber;
  final void Function() showLoginCallback;

  const LoginTextField({
    Key? key,
    required this.logoUrl,
    required this.hintText,
    required this.constraints,
    required this.onChangedCallback,
    required this.isCodeSent,
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
            padding: EdgeInsets.symmetric(
                horizontal: widget.constraints.maxWidth / 10 - 12),
            child: Stack(
              children: [
                Container(
                  height: 54.0,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/profile_screen/card_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.0),
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: widget.constraints.maxWidth / 6 - 20),
                        child: Image.asset(
                          widget.logoUrl,
                          width: 5 + widget.constraints.maxWidth / 20,
                          height: 5 + widget.constraints.maxWidth / 20,
                        ),
                      ),
                      SizedBox(width: widget.constraints.maxWidth / 10 - 10),
                      Container(
                        width: 19 * widget.constraints.maxWidth / 60 + 57,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize:
                                      widget.constraints.maxWidth / 200 > 1.6
                                          ? 16
                                          : widget.constraints.maxWidth / 20,
                                  fontFamily: 'Nokora',
                                ),
                                cursorHeight:
                                    widget.constraints.maxWidth / 200 > 1.6
                                        ? 16
                                        : widget.constraints.maxWidth / 20,
                                enabled: !widget.isCodeSent,
                                autofocus: !widget.isCodeSent,
                                onChanged: widget.onChangedCallback,
                                decoration: InputDecoration(
                                  hintText: widget.hintText,
                                  hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize:
                                        widget.constraints.maxWidth / 200 > 1.6
                                            ? 16
                                            : widget.constraints.maxWidth / 20,
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
                                          },
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                              Colors.transparent,
                                            ),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                          ),
                                          child: Text(
                                            'ផ្ញើលេខកូដ',
                                            textScaleFactor: widget.constraints
                                                            .maxWidth /
                                                        200 >
                                                    1.6
                                                ? 1.6
                                                : widget.constraints.maxWidth /
                                                    200,
                                            style: const TextStyle(
                                              color: Color(0xAAF7B731),
                                              fontSize: 12.0,
                                              fontFamily: 'Nokora',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !widget.isCodeSent,
                                        child: Text(
                                          '$_countSeconds វិនាទី',
                                          textScaleFactor: widget.constraints
                                                          .maxWidth /
                                                      200 >
                                                  1.6
                                              ? 1.6
                                              : widget.constraints.maxWidth /
                                                  200,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).disabledColor,
                                            fontSize: 12.0,
                                            fontFamily: 'Nokora',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
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