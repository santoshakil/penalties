import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'add.user.dart';
import 'user.list.view.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async =>
            showModal(context: context, builder: (_) => const AddUserPopup()),
        child: const Icon(Icons.add_rounded),
      ),
      body: const UserListView(),
    );
  }
}
