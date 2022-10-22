import '../../model/setting_model.dart' show GetAppConfigCollection;
import '../config/app_config_db.dart' show appConfig, db;

void changeTheme(int index) => db.writeTxnSync(
      () => db.appConfigs.putSync(
        appConfig.copyWith(themeIndex: index),
      ),
    );
