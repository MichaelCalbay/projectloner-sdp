import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/auth/auth_bloc.dart';
import 'package:projectloner/matching/chat_screen.dart';
import 'package:projectloner/widgets/custom_elevated_button.dart';

import '../blocs/match/match_bloc.dart';
import '../blocs/swipe/swipe_bloc.dart';
import '../matching/matches_screen.dart';
import '../repositories/database/database_repo.dart';
import '../theme/theme_provider.dart';

class MatchedNotifScreen extends StatelessWidget {
  const MatchedNotifScreen({
    Key? key,
    required this.state,
    required this.themeProvider,
  }) : super(key: key);

  final SwipeMatched state;
  final LonerThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats, you found a duo!',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 15),
            Text(
              'You and ${state.user.firstName} are compatible.',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          context.read<AuthBloc>().state.user!.imageUrls.isNotEmpty ? 
                          context.read<AuthBloc>().state.user!.imageUrls[0] : 
                          'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls.isNotEmpty ? 
                        context.read<AuthBloc>().state.user!.imageUrls[0]! : 
                        'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomElevatedButton(
              text: 'SEND MESSAGE',
              primaryGradient: Theme.of(context).primaryColor,
              secondaryGradient: Theme.of(context).colorScheme.secondary,
              textColor:
                  (themeProvider.isDarkMode) ? Colors.white : Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<MatchBloc>(
                      create: (context) => MatchBloc(
                        databaseRepository: context.read<DatabaseRepository>(),
                      )..add(LoadMatches(
                          user: context.read<AuthBloc>().state.user!)),
                      child: const MatchesScreen(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'MATCHMAKING',
              primaryGradient: Theme.of(context).primaryColor,
              secondaryGradient: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              onPressed: () {
                context.read<SwipeBloc>().add(
                      LoadUsers(user: context.read<AuthBloc>().state.user!),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
