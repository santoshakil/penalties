import 'package:flutter/material.dart' show runApp;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

import 'src/app.dart' show MyApp;
import 'src/modules/setting/provider/config/app_config_db.dart' show openDB;
import 'src/utils/paths/paths.dart' show initDir;

void main() async {
  await initDir();
  await openDB();
  runApp(const ProviderScope(child: MyApp()));
}
