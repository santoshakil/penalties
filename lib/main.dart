import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart' show SystemChrome;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

import 'src/app.dart' show MyApp;
import 'src/modules/setting/provider/config/app_config_db.dart' show openDB;
import 'src/utils/paths/paths.dart' show initDir;
import 'src/utils/themes/dark/dark_theme.dart' show uiConfigdark;

void main() async {
  await initDir();
  await openDB();
  SystemChrome.setSystemUIOverlayStyle(uiConfigdark);
  runApp(const ProviderScope(child: MyApp()));
}
