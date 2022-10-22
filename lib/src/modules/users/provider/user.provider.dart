import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../penalties/model/penalties.model.dart';

import '../../setting/provider/config/app_config_db.dart';
import '../model/user.model.dart';

final usersStreamProvider = StreamProvider((_) => db.users.watchLazy());
final userStreamProvider = StreamProvider.family(
  (_, User? user) => db.users.watchObject(user?.id ?? -1),
);

final usersProvider = FutureProvider((ref) {
  ref.watch(usersStreamProvider);
  return db.users.where().findAll();
});

final userTotalPenaltyProvider = FutureProvider.family((ref, User? user) {
  ref.watch(userStreamProvider(user));
  return db.penaltyTrxs
      .where()
      .userIdEqualTo(user?.id ?? -1)
      .amountProperty()
      .sum();
});

final addUserFormKeyProvider =
    Provider.autoDispose((_) => GlobalKey<FormState>());

final addUserProvider = StateNotifierProvider.autoDispose
    .family<AddUserProvider, User, User?>(
        (_, User? user) => AddUserProvider(user));

class AddUserProvider extends StateNotifier<User> {
  AddUserProvider(this.user) : super(user ?? User.empty());

  final User? user;

  User get value => state;

  Future<void> save() async => await state.save();

  Future<void> delete() async => await state.delete();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    return null;
  }

  String? validateDesignation(String? value) {
    if (value == null || value.isEmpty) return 'Designation is required';
    return null;
  }
}
