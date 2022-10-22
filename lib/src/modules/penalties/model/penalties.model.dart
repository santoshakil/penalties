import 'package:isar/isar.dart';

import '../../setting/provider/config/app_config_db.dart';
import '../../users/model/user.model.dart';

part '../extension/penalty.extension.dart';
part 'penalties.model.g.dart';

@Collection()
class Penalty {
  Id? id;

  @Index()
  String name;

  @Index()
  double amount;

  @Backlink(to: 'penalty')
  final penalties = IsarLinks<PenaltyTrx>();

  Penalty({
    this.id,
    required this.name,
    required this.amount,
  });

  factory Penalty.empty() => Penalty(name: '', amount: 0.0);

  @override
  bool operator ==(covariant Penalty other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}

@Collection()
class PenaltyTrx {
  Id? id;

  @Index()
  DateTime date = DateTime.now();

  @Index()
  bool paid;

  @Index()
  int? get userId => user.value?.id;

  @Index(type: IndexType.value, caseSensitive: false)
  String? get userName => user.value?.name;

  @Index(type: IndexType.value, caseSensitive: false)
  String? get penaltyName => penalty.value?.name;

  @Index()
  double get amount => penalty.value?.amount ?? 0.0;

  final penalty = IsarLink<Penalty>();
  final user = IsarLink<User>();

  PenaltyTrx({this.id, this.paid = false});

  PenaltyTrx copyWith({
    Id? id,
    bool? paid,
    User? user,
    DateTime? date,
    Penalty? penalty,
  }) {
    final trx = PenaltyTrx(id: id ?? this.id, paid: paid ?? this.paid);
    trx.penalty.value = penalty ?? this.penalty.value;
    trx.user.value = user ?? this.user.value;
    if (date != null) trx.date = date;
    return trx;
  }

  @override
  bool operator ==(covariant PenaltyTrx other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}
