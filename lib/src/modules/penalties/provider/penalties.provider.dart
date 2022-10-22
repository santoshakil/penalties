import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../setting/provider/config/app_config_db.dart';
import '../../users/model/user.model.dart';
import '../model/penalties.model.dart';

final penaltyNameFilterProvider = StateProvider((_) => '');
final penaltyPaidFilterProvider = StateProvider((_) => false);
final penaltyUserFilterProvider = StateProvider<User?>((_) => null);
final penaltyEndDateFilterProvider = StateProvider((_) => DateTime.now());
final penaltyStartDateFilterProvider = StateProvider<DateTime?>((_) => null);

final penaltiesStreamProvider =
    StreamProvider((_) => db.penaltyTrxs.watchLazy());

final penaltyTrxsProvider = FutureProvider((ref) async {
  ref.watch(penaltiesStreamProvider);
  final user = ref.watch(penaltyUserFilterProvider);
  final name = ref.watch(penaltyNameFilterProvider);
  final paid = ref.watch(penaltyPaidFilterProvider);
  final endDate = ref.watch(penaltyEndDateFilterProvider);
  final startDate = ref.watch(penaltyStartDateFilterProvider);
  return db.penaltyTrxs
      .where()
      .penaltyNameStartsWith(name)
      .filter()
      .optional(startDate != null, (q) => q.dateGreaterThan(startDate!))
      .optional(user != null, (q) => q.user((u) => u.idEqualTo(user!.id)))
      .userNameContains(name, caseSensitive: false)
      .dateLessThan(endDate)
      .paidEqualTo(paid)
      .findAll();
});

final addPenaltyTrxFormKeyProvider =
    Provider.autoDispose((_) => GlobalKey<FormState>());

final addPenaltyTrxProvider = StateNotifierProvider.autoDispose
    .family<AddPenaltyTrxProvider, PenaltyTrx, PenaltyTrx?>(
        (_, PenaltyTrx? penaltyTrx) => AddPenaltyTrxProvider(penaltyTrx));

class AddPenaltyTrxProvider extends StateNotifier<PenaltyTrx> {
  AddPenaltyTrxProvider(this.penaltyTrx) : super(penaltyTrx ?? PenaltyTrx());

  final PenaltyTrx? penaltyTrx;

  PenaltyTrx get value => state;

  Future<bool> save() async {
    if (state.penalty.value == null) return false;
    if (state.user.value == null) return false;
    await state.save();
    return true;
  }

  Future<void> delete() async => await state.delete();

  void changeUser(User user) => state = state.copyWith(user: user);

  void changePenalty(Penalty penalty) =>
      state = state.copyWith(penalty: penalty);

  void changeDate(DateTime date) => state = state.copyWith(date: date);

  String? validateUser(String? value) {
    if (value == null || value.isEmpty) return 'User is required';
    return null;
  }

  String? validatePenalty(String? value) {
    if (value == null || value.isEmpty) return 'Penalty is required';
    return null;
  }
}
