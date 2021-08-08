import 'dart:io';

import 'package:flutter/material.dart';
import '../values/colors.dart';

final ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: mainColor,
  accentColor: accentColor,
  brightness: Brightness.dark,
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  dividerColor: Colors.black12,
  popupMenuTheme: PopupMenuThemeData(
      color: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white10,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      )),
  visualDensity: getVd(),
);

VisualDensity getVd() {
  try {
    return Platform.isAndroid || Platform.isIOS
        ? VisualDensity.compact
        : VisualDensity.comfortable;
  } catch (e) {
    return VisualDensity.compact;
  }
}
