import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/penalty.provider.dart';

class PenaltySelector extends ConsumerWidget {
  const PenaltySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penalties = ref.watch(penaltiesProvider).value ?? [];
    return AlertDialog(
      scrollable: true,
      title: const Text('Penalties'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final penalty in penalties)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(penalty.name),
                onTap: () => Navigator.of(context).pop(penalty),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
