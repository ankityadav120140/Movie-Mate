// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../main.dart';

Widget DrawerWidget(BuildContext context) {
  return Drawer(
    child: Transform.scale(
      scale: 2,
      child: Switch(
        value: themeManager.themeMode == ThemeMode.dark,
        onChanged: (newValue) {
          themeManager.toggleTheme(newValue);
        },
      ),
    ),
  );
}
