import 'package:flutter/material.dart';

class ModelIconMenu {
  final Widget icon;
  final String label;
  final Function()? onTap;

  const ModelIconMenu({
    required this.icon,
    required this.label,
    this.onTap,
  });
}
