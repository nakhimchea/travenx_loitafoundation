import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double dashWidth;
  final double dashHeight;
  const CustomDivider({
    Key? key,
    this.color = Colors.black,
    this.dashWidth = 10.0,
    this.dashHeight = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double boxWidth = constraints.constrainWidth();
        final int dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(
            dashCount,
            (index) => SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
