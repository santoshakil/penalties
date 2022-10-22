import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.model.dart';
import '../provider/user.provider.dart';

class AddUserPopup extends ConsumerWidget {
  const AddUserPopup({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(addUserProvider(user).notifier);
    final formKey = ref.watch(addUserFormKeyProvider);
    return AlertDialog(
      scrollable: true,
      title: Text(user == null ? 'Add User' : 'Edit User'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: TextEditingController(text: user?.name),
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (v) => notifier.value.name = v,
              validator: notifier.validateName,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: TextEditingController(text: user?.email),
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (v) => notifier.value.email = v,
              validator: notifier.validateEmail,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: TextEditingController(text: user?.phone),
              decoration: const InputDecoration(labelText: 'Phone'),
              onChanged: (v) => notifier.value.phone = v,
              validator: notifier.validatePhone,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: TextEditingController(text: user?.designation),
              decoration: const InputDecoration(labelText: 'Designation'),
              onChanged: (v) => notifier.value.designation = v,
              validator: notifier.validateDesignation,
            ),
          ],
        ),
      ),
      actions: [
        if (user != null)
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
            if (!formKey.currentState!.validate()) return;
            final navigator = Navigator.of(context);
            await notifier.save();
            navigator.pop();
          },
          child: Text(user == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
