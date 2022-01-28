import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget portraitBody;
  final Widget mediumBody;
  final Widget landscapeBody;
  final Widget wideBody;

  const ResponsiveLayout({
    Key? key,
    required this.portraitBody,
    required this.mediumBody,
    required this.landscapeBody,
    required this.wideBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) =>
            constraints.maxWidth < constraints.maxHeight * 0.61
                ? portraitBody
                : constraints.maxWidth < constraints.maxHeight * 1.2
                    ? mediumBody
                    : constraints.maxWidth < constraints.maxHeight * 2.5
                        ? landscapeBody
                        : wideBody);
  }
}
