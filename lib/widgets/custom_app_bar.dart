import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/match/match_bloc.dart';
import 'package:projectloner/matching/matches_screen.dart';
import 'package:projectloner/repositories/database/database_repo.dart';

import '../blocs/auth/auth_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool actionButtons;
  final IconData icon;

  const CustomAppBar({
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
                  //Added match bloc here instead of main.
                  //So that it's not accessible anywhere.
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<MatchBloc>(
                        create: (context) => MatchBloc(
                          databaseRepository:
                              context.read<DatabaseRepository>(),
                        )..add(LoadMatches(
                            user: context.read<AuthBloc>().state.user!)),
                        child: const MatchesScreen(),
                      ),
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
