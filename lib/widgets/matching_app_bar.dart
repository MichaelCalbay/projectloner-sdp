import 'package:flutter/material.dart';
import 'package:projectloner/matching/matches_screen.dart';

class MatchingAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool actionButtons;
  final IconData icon;

  const MatchingAppBar({
    Key? key,
    required this.title,
    this.actionButtons = true,
    this.icon = Icons.gamepad_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Icon(icon),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: actionButtons
          ? [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MatchesScreen(),
                    ),
                  );
                  debugPrint('Message Icon Pressed!');
                },
                icon: const Icon(Icons.message),
              ),
              IconButton(
                onPressed: () {
                  debugPrint('Profile Icon Pressed!');
                },
                icon: const Icon(Icons.person),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
