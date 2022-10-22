import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../penalties/model/penalties.model.dart';
import '../provider/penalty.provider.dart';

class AddPenaltyPopup extends ConsumerWidget {
  const AddPenaltyPopup({super.key, this.penalty});
  final Penalty? penalty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addPenaltyProvider(penalty).notifier);
    final formKey = ref.watch(addPenaltyFormKeyProvider);
    return AlertDialog(
      scrollable: true,
      title: Text(penalty == null ? 'Add Penalty' : 'Edit Penalty'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: penalty?.name),
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (v) => notifier.value.name = v,
              validator: notifier.validateName,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller:
                  TextEditingController(text: penalty?.amount.toString()),
              decoration: const InputDecoration(labelText: 'Amount'),
              onChanged: (v) => notifier.value.amount = double.tryParse(v) ?? 0,
              keyboardType: TextInputType.number,
              validator: notifier.validateAmount,
            ),
          ],
        ),
      ),
      actions: [
        if (penalty != null)
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
          onPressed: () {
            final navigator = Navigator.of(context);
            navigator.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final navigator = Navigator.of(context);
            if (formKey.currentState?.validate() ?? false) {
              notifier.save();
              navigator.pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
