import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../theme/theme_provider.dart';

class MatchMaking extends StatelessWidget {
  const MatchMaking({super.key});

  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return const Scaffold(
              appBar: CustomAppBar(title: 'Co-Loners'),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
        if (state is SwipeLoaded) {
          return SwipingStateScreen(
            state: state,
            themeProvider: themeProvider,
          );
        }
        if (state is SwipeMatched) {
          return MatchedNotifScreen(
            state: state,
            themeProvider: themeProvider,
          );
        }
        if (state is SwipeError) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Co-Loners'),
            body: Center(
              child: Text(
                'There are no more users!',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        } else {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Co-Loners'),
            body: Text('Oops.. Something went wrong!'),
          );
        }
      },
    );
  }
}
