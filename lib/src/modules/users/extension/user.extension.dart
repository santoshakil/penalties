part of '../model/user.model.dart';

extension UserExtension on User {
  Future<void> save() async => db.writeTxn(() => db.users.put(this));

  Future<void> delete() async => db.writeTxn(() => db.users.delete(id!));
}
