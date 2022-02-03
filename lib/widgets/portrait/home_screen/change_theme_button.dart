import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/providers/theme_provider.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      child: CircleAvatar(
        child: Icon(
          themeProvider.isLightMode ? Icons.light_mode : Icons.dark_mode,
        ),
      ),
      onTap: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(!themeProvider.isLightMode);
      },
    );
  }
}
