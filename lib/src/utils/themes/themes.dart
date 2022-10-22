import 'package:flutter/material.dart';

import 'dark/dark_theme.dart' show darkTheme;
import 'light/light_theme.dart' show lightTheme;

enum SelectedTheme { dark, light }

extension SelectedThemeExtension on SelectedTheme {
  ThemeData get theme {
    switch (this) {
      case SelectedTheme.light:
        return lightTheme;
      case SelectedTheme.dark:
        return darkTheme;
    }
  }
}

final roundedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
);

const inputDecorationTheme =
    InputDecorationTheme(border: outlineInputBorder, isDense: true);

const inputDecoration = InputDecoration(filled: true);

const outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 0, style: BorderStyle.none),
  borderRadius: borderRadius30,
);

const borderRadius10 = BorderRadius.all(Radius.circular(10));
const borderRadius15 = BorderRadius.all(Radius.circular(15));
const borderRadius20 = BorderRadius.all(Radius.circular(20));
const borderRadius30 = BorderRadius.all(Radius.circular(30));

const tabDecoration = BoxDecoration(borderRadius: borderRadius30);
const roundedBoxDecoration30 = BoxDecoration(borderRadius: borderRadius30);
const roundedBoxDecoration15 = BoxDecoration(borderRadius: borderRadius15);
const roundedBoxDecoration20 = BoxDecoration(borderRadius: borderRadius20);
const roundedRectangleBorder30 =
    RoundedRectangleBorder(borderRadius: borderRadius30);
const roundedRectangleBorder15 =
    RoundedRectangleBorder(borderRadius: borderRadius15);
