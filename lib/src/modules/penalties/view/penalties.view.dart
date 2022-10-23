import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/helpers/routing/routing.dart';
import '../../penalty/view/penalty.view.dart';
import '../../users/view/users.view.dart';
import '../provider/penalties.provider.dart';
import 'add.penalty.trx.popup.dart';
import 'penaltiestrx.list.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penalties'),
        actions: [
          IconButton(
            onPressed: () async => await fadePush(context, const UsersView()),
            icon: const Icon(Icons.people_rounded),
            splashRadius: 18.0,
          ),
          IconButton(
            onPressed: () async => await fadePush(context, const PenaltyView()),
            icon: const Icon(Icons.warning_rounded),
            splashRadius: 18.0,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => await showModal(
          builder: (_) => const AddPenaltyTrxPopup(),
          context: context,
        ),
        child: const Icon(Icons.add_rounded),
      ),
      body: Consumer(
        builder: (_, ref, __) {
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(penaltyTrxsProvider),
            child: const CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 20),
                  sliver: PenaltyTrxListView(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
