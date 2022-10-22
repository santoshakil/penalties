import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:isar/isar.dart' show Isar;

import '../../../../utils/paths/paths.dart' show appDBDir;
import '../../../penalties/model/penalties.model.dart'
    show PenaltySchema, PenaltyTrxSchema;
import '../../../users/model/user.model.dart' show UserSchema;
import '../../model/setting_model.dart'
    show AppConfig, AppConfigSchema, GetAppConfigCollection;

late final Isar db;

AppConfig get appConfig => db.appConfigs.getSync(0) ?? AppConfig();

Future<void> openDB() async => db = await Isar.open(
      [AppConfigSchema, UserSchema, PenaltySchema, PenaltyTrxSchema],
      inspector: !kReleaseMode,
      directory: appDBDir.path,
    );
