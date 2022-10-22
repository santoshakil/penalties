part of '../model/penalties.model.dart';

extension PenaltyExtension on Penalty {
  Future<void> save() async => db.writeTxn(() => db.penaltys.put(this));

  Future<void> delete() async =>
      await db.writeTxn(() => db.penaltys.delete(id!));
}

extension PenaltyTrxExtension on PenaltyTrx {
  Future<int> save() async => await db.writeTxn(() async {
        final saved = await db.penaltyTrxs.put(this);
        await penalty.save();
        await user.save();
        return saved;
      });

  Future<void> delete() async =>
      await db.writeTxn(() => db.penaltyTrxs.delete(id!));
}
