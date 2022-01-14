import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final BoxConstraints constraints;
  final void Function() onPressed;
  const GradientButton({
    Key? key,
    required this.title,
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
              child: Text(
                title,
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
    );
  }
}
