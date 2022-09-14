import 'package:flutter/material.dart';

class MatchMaking extends StatelessWidget {
  const MatchMaking({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MatchingAppBar(),
    );
  }
}

class MatchingAppBar extends StatelessWidget with PreferredSizeWidget {
  const MatchingAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      title: Row(
        children: const [
          Expanded(
            child: Icon(Icons.home),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Co-Loners',
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.message),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
