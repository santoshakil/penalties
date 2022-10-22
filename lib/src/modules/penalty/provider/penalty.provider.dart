import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../penalties/model/penalties.model.dart';
import '../../setting/provider/config/app_config_db.dart';

final penaltyStream = StreamProvider((_) => db.penaltys.watchLazy());

final penaltiesProvider = FutureProvider((ref) {
  ref.watch(penaltyStream);
  return db.penaltys.where().findAll();
});

final addPenaltyFormKeyProvider =
    Provider.autoDispose((_) => GlobalKey<FormState>());

final addPenaltyProvider = StateNotifierProvider.autoDispose
    .family<AddPenaltyProvider, Penalty, Penalty?>(
        (_, Penalty? penalty) => AddPenaltyProvider(penalty));

class AddPenaltyProvider extends StateNotifier<Penalty> {
  AddPenaltyProvider(this.penalty) : super(penalty ?? Penalty.empty());

  final Penalty? penalty;

  Penalty get value => state;

  Future<void> save() async => await state.save();

  Future<void> delete() async => await state.delete();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'Amount is required';
    return null;
  }
}
