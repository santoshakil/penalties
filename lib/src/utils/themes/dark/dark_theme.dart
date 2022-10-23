import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes.dart';

const primaryColorDark = Color(0xFF0A0E21);
const backgroundColorDark = Color(0xFF0A0E21);
const appBarColorDark = Color.fromARGB(255, 12, 17, 39);
const fabColorDark = Color.fromARGB(255, 19, 48, 75);
const iconColorDark = Color.fromARGB(255, 0, 126, 165);
const cardColorDark = Color.fromARGB(255, 17, 22, 37);
const dialogBackgroundColorDark = Color.fromARGB(255, 22, 26, 43);

const uiConfigdark = SystemUiOverlayStyle(
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: primaryColorDark,
  statusBarBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.compact,
  primaryColor: primaryColorDark,
  scaffoldBackgroundColor: backgroundColorDark,
  appBarTheme: _appBarTheme,
  floatingActionButtonTheme: _floatingActionButtonTheme,
  iconTheme: _iconTheme,
  listTileTheme: _listTileTheme,
  dialogBackgroundColor: dialogBackgroundColorDark,
  dialogTheme: _dialogTheme,
  outlinedButtonTheme: _outlinedButtonTheme,
  buttonTheme: _buttonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  inputDecorationTheme: _inputDecorationTheme,
  chipTheme: _chipTheme,
  cardTheme: _cardTheme,
);

const _appBarTheme = AppBarTheme(
  shape: roundedRectangleBorder30,
  iconTheme: _iconTheme,
  color: appBarColorDark,
);

const _floatingActionButtonTheme = FloatingActionButtonThemeData(
  foregroundColor: iconColorDark,
  backgroundColor: fabColorDark,
);

const _iconTheme = IconThemeData(color: iconColorDark);

const _listTileTheme = ListTileThemeData(
  shape: roundedRectangleBorder15,
  tileColor: cardColorDark,
);

const _dialogTheme = DialogTheme(shape: roundedRectangleBorder30);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(shape: roundedRectangleBorder30),
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(shape: roundedRectangleBorder30),
);

const _buttonTheme = ButtonThemeData(shape: roundedRectangleBorder30);

const _inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: borderRadius30,
    borderSide: BorderSide.none,
  ),
  alignLabelWithHint: true,
  fillColor: cardColorDark,
  filled: true,
);

const _chipTheme = ChipThemeData(
  backgroundColor: cardColorDark,
  selectedColor: fabColorDark,
  elevation: 3.0,
);

const _cardTheme =
    CardTheme(shape: roundedRectangleBorder30, color: cardColorDark);
