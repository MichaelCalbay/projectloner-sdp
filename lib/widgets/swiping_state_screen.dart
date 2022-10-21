import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../blocs/swipe/swipe_bloc.dart';
import '../theme/theme_provider.dart';

class SwipingStateScreen extends StatelessWidget {
  const SwipingStateScreen({
    Key? key,
    required this.state,
    required this.themeProvider,
  }) : super(key: key);

  final SwipeLoaded state;
  final LonerThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    var userCount = state.users.length;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Co-Loners'),
      body: Column(
        children: [
          Draggable(
            data: (userCount <= 0) ? Container() : state.users[0],
            feedback:
                (userCount <= 0) ? Container() : UserCard(user: state.users[0]),
            childWhenDragging:
                (userCount > 1) ? UserCard(user: state.users[1]) : Container(),
            child:
                (userCount <= 0) ? Container() : UserCard(user: state.users[0]),
            onDragEnd: (drag) {
              if (drag.velocity.pixelsPerSecond.dx < 0) {
                context.read<SwipeBloc>().add(SwipeLeft(user: state.users[0]));
                debugPrint('Swiped Left');
              } else {
                context.read<SwipeBloc>().add(SwipeRight(user: state.users[0]));
                debugPrint('Swiped Right');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeLeft(user: state.users[0]));
                    debugPrint('Swiped Left');
                  },
                  child: const ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    colour: Colors.red,
                    icon: Icons.clear_rounded,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<SwipeBloc>()
                        .add(SwipeRight(user: state.users[0]));
                    debugPrint('Swiped Right');
                  },
                  child: ChoiceButton(
                    width: 80,
                    height: 80,
                    size: 30,
                    colour: Theme.of(context).colorScheme.primary,
                    icon: Icons.favorite,
                  ),
                ),
                ChoiceButton(
                  width: 60,
                  height: 60,
                  size: 25,
                  colour: (themeProvider.isDarkMode)
                      ? Colors.white
                      : Colors.black54,
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
