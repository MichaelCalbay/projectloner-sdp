import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../blocs/match/match_bloc.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Matches',
        actionButtons: true,
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MatchLoaded) {
            final inactiveMatches = state.matchedUsers
                .where((match) => match.chat == null)
                .toList();
            final activeMatches = state.matchedUsers
                .where((match) => match.chat != null)
                .toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Faves',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    InactiveList(inactiveMatches: inactiveMatches),
                    const SizedBox(height: 10),
                    Text(
                      'Chats',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ActiveList(activeMatches: activeMatches),
                  ],
                ),
              ),
            );
          }
          if (state is NoMatches) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Matches Yet :(',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'MATCHMAKING',
                    primaryGradient: Theme.of(context).primaryColor,
                    secondaryGradient: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          } else {
            return const Text('Oops, something went wrong...');
          }
        },
      ),
    );
  }
}
