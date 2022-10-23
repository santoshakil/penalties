import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add.penalty.trx.popup.dart';
import '../../../utils/extensions/extension.dart';

import '../model/penalties.model.dart';
import '../provider/penalties.provider.dart';

class PenaltyTrxListView extends ConsumerWidget {
  const PenaltyTrxListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final penaltyTrxs = ref.watch(penaltyTrxsProvider).value ?? [];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, i) => PenaltyTrxTile(penaltyTrxs[i]),
        childCount: penaltyTrxs.length,
      ),
    );
  }
}

class PenaltyTrxTile extends StatelessWidget {
  const PenaltyTrxTile(this.trx, {super.key});
  final PenaltyTrx trx;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (_, double opacity, __) => Opacity(
        opacity: opacity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(trx.penaltyName!),
                subtitle: Text(trx.userName!),
                trailing: Text(trx.date.formatted),
                onLongPress: () async => await showModal(
                  builder: (_) => AddPenaltyTrxPopup(trx: trx),
                  context: context,
                ),
              ),
            ),
            trx.paid
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 14.0,
                  )
                : const Icon(
                    Icons.circle_rounded,
                    color: Colors.red,
                    size: 14.0,
                  ),
          ],
        ),
      ),
    );
  }
}
