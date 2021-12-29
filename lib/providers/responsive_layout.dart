import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget portraitBody;
  final Widget mediumBody;
  final Widget landscapeBody;

  const ResponsiveLayout({
    Key? key,
    required this.portraitBody,
    required this.mediumBody,
    required this.landscapeBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth < constraints.maxHeight * 0.61
          ? portraitBody
          : constraints.maxWidth < constraints.maxHeight * 1.2
              ? mediumBody
              : landscapeBody;
    });
  }
}
