import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String logoUrl;
  final String hintText;
  final BoxConstraints constraints;
  final TextEditingController controller;

  const LoginTextField({
    Key? key,
    required this.logoUrl,
    required this.hintText,
    required this.constraints,
    required this.controller,
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
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Image.asset(
                    logoUrl,
                    width: 23.0,
                    height: 23.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: constraints.maxWidth - 207.0,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
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
    );
  }
}
