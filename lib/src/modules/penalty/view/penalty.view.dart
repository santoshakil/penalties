import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'add.penalty.popup.dart';
import 'penalty.list.view.dart';

class PenaltyView extends StatelessWidget {
  const PenaltyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Penalty')),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => await showModal(
          builder: (_) => const AddPenaltyPopup(),
          context: context,
        ),
        child: const Icon(Icons.add),
      ),
      body: const PenaltyListView(),
    );
  }
}
