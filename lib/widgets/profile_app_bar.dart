import 'package:flutter/material.dart';

class buildAppBar extends StatelessWidget with PreferredSizeWidget {
  const buildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
