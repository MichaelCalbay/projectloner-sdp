import 'package:flutter/material.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/widgets/widgets.dart';

class MatchMaking extends StatelessWidget {
  const MatchMaking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MatchingAppBar(),
      body: Column(
        children: [
          UserCard(user: User.users[0]),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  colour: Colors.red,
                  icon: Icons.clear_rounded,
                ),
                ChoiceButton(
                  width: 80,
                  height: 80,
                  size: 30,
                  colour: Theme.of(context).colorScheme.secondary,
                  icon: Icons.favorite,
                ),
                const ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  colour: Colors.black54,
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
