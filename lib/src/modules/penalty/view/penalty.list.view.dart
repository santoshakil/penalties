import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../penalties/model/penalties.model.dart';
import '../provider/penalty.provider.dart';
import 'add.penalty.popup.dart';

class PenaltyListView extends ConsumerWidget {
  const PenaltyListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penalties = ref.watch(penaltiesProvider).value ?? [];
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) => PenaltyTile(penalties[i]),
            childCount: penalties.length,
          ),
        ),
      ],
    );
  }
}

class PenaltyTile extends StatelessWidget {
  const PenaltyTile(this.penalty, {Key? key}) : super(key: key);
  final Penalty penalty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: ListTile(
        title: Text(penalty.name),
        subtitle: Text(penalty.amount.toString()),
        onLongPress: () async => await showModal(
          builder: (_) => AddPenaltyPopup(penalty: penalty),
          context: context,
        ),
      ),
    );
  }
}
