import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user.provider.dart';

class UserSelector extends ConsumerWidget {
  const UserSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider).value ?? [];
    return AlertDialog(
      scrollable: true,
      title: const Text('Users'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final user in users)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListTile(
                title: Text(user.name),
                onTap: () => Navigator.of(context).pop(user),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
