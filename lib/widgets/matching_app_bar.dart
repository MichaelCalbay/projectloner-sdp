import 'package:flutter/material.dart';

class MatchingAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const MatchingAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      title: Row(
        children: [
          const Expanded(
            child: Icon(Icons.auto_awesome),
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
      actions: [
        IconButton(
          onPressed: () {
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
