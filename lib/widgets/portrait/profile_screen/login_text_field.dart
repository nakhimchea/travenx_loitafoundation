import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String logoUrl;
  final String hintText;
  final BoxConstraints constraints;
  //final TextEditingController controller;
  final void Function(String) onChangedCallback;
  final bool isCodeSent;
  final void Function() isCodeSentCallback;
  final String phoneNumber;

  const LoginTextField({
    Key? key,
    required this.logoUrl,
    required this.hintText,
    required this.constraints,
    //required this.controller,
    required this.onChangedCallback,
    required this.isCodeSent,
    required this.isCodeSentCallback,
    this.phoneNumber = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height / 16).ceil().toDouble(),
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
            margin: EdgeInsets.all(2.0),
            height: ((MediaQuery.of(context).size.height / 16).ceil() - 4)
                .toDouble(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    logoUrl,
                    width: 23.0,
                    height: 23.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: constraints.maxWidth - 167.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          enabled: !isCodeSent,
                          autofocus: !isCodeSent,
                          onChanged: onChangedCallback,
                          decoration: InputDecoration(
                            hintText: hintText,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      phoneNumber != ''
                          ? Row(
                              children: [
                                Visibility(
                                  visible: isCodeSent,
                                  child: TextButton(
                                    onPressed: isCodeSentCallback,
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                        Colors.transparent,
                                      ),
                                    ),
                                    child: Text(
                                      'ផ្ញើលេខកូដ',
                                      style: const TextStyle(
                                        color: Color(0xAAF7B731),
                                        fontSize: 18.0,
                                        fontFamily: 'Nokora',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !isCodeSent,
                                  //ToDo: Counting down the seconds
                                  child: TextButton(
                                    onPressed: isCodeSentCallback,
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                        Colors.transparent,
                                      ),
                                    ),
                                    child: Text(
                                      '60 វិនាទី',
                                      style: TextStyle(
                                        color: Theme.of(context).disabledColor,
                                        fontSize: 16.0,
                                        fontFamily: 'Nokora',
                                        fontWeight: FontWeight.w600,
                                      ),
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
