import 'package:isar/isar.dart';

import '../../penalties/model/penalties.model.dart';
import '../../setting/provider/config/app_config_db.dart';

part '../extension/user.extension.dart';
part 'user.model.g.dart';

@Collection()
class User {
  Id? id;

  String name;
  String email;
  String phone;
  String designation;

  @Backlink(to: 'user')
  final penalties = IsarLinks<PenaltyTrx>();

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
  });

  factory User.empty() => User(name: '', email: '', phone: '', designation: '');

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}
