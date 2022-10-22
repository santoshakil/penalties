import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/extensions/src/date.dart';

import '../../penalty/view/penalty.selector.dart';
import '../../users/model/user.model.dart';
import '../../users/view/user.selector.dart';
import '../model/penalties.model.dart';
import '../provider/penalties.provider.dart';

class AddPenaltyTrxPopup extends ConsumerWidget {
  const AddPenaltyTrxPopup({super.key, this.trx});
  final PenaltyTrx? trx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addPenaltyTrxProvider(trx).notifier);
    ref.watch(addPenaltyTrxProvider(trx));
    return AlertDialog(
      scrollable: true,
      title: Text(trx == null ? 'Add Penalty' : 'Edit Penalty'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(notifier.value.user.value?.name ?? 'User'),
            onTap: () async {
              final user = await showDialog<User?>(
                builder: (_) => const UserSelector(),
                context: context,
              );
              if (user == null) return;
              notifier.changeUser(user);
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            title: Text(notifier.value.penalty.value?.name ?? 'Penalty'),
            onTap: () async {
              final penalty = await showDialog<Penalty?>(
                builder: (_) => const PenaltySelector(),
                context: context,
              );
              if (penalty == null) return;
              notifier.changePenalty(penalty);
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            title: Text(notifier.value.date.formatted),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: notifier.value.date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date == null) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(notifier.value.date),
              );
              if (time == null) return;
              notifier.changeDate(date.withTime(time));
            },
          ),
        ],
      ),
      actions: [
        if (trx != null)
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await notifier.delete();
              navigator.pop();
            },
            child: const Text('Delete'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            final saved = await notifier.save();
            if (!saved) return;
            navigator.pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
