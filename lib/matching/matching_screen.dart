import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/widgets/widgets.dart';

class MatchMaking extends StatelessWidget {
  const MatchMaking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MatchingAppBar(),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return Column(
              children: [
                Draggable(
                  feedback: UserCard(user: state.users[0]),
                  childWhenDragging: UserCard(user: state.users[1]),
                  child: UserCard(user: state.users[0]),
                  onDragEnd: (drag) {
                    if (drag.velocity.pixelsPerSecond.dx < 0) {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeLeft(user: state.users[0]));
                      debugPrint('Swiped Left');
                    } else {
                      context
                          .read<SwipeBloc>()
                          .add(SwipeRight(user: state.users[0]));
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
                          colour: Theme.of(context).colorScheme.secondary,
                          icon: Icons.favorite,
                        ),
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
            );
          } else {
            return const Text('Oops.. Something went wrong!');
          }
        },
      ),
    );
  }
}
