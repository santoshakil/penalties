import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.model.dart';
import '../provider/user.provider.dart';
import 'add.user.dart';

class UserListView extends ConsumerWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider).value ?? [];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) => UserTile(users[i]),
            childCount: users.length,
          ),
        ),
      ],
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile(this.user, {Key? key}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Consumer(
          builder: (_, ref, __) {
            final total = ref.watch(userTotalPenaltyProvider(user)).value;
            return Text(total?.toString() ?? '');
          },
        ),
        onLongPress: () async => await showModal(
          builder: (_) => AddUserPopup(user: user),
          context: context,
        ),
      ),
    );
  }
}
