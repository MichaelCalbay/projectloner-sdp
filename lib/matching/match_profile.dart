import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/widgets/widgets.dart';

class MatchProfile extends StatelessWidget {
  final LonerUser user;

  const MatchProfile({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0, top: 24.0),
                        child: Hero(
                          tag: 'user_image',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: NetworkImage((user.imageUrls.isEmpty)
                                    ? ((user.gender == 'Male')
                                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                                        : ((user.gender == 'Female')
                                            ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                                            : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                                    : user.imageUrls[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SwipeBloc>()
                                      .add(SwipeLeft(user: state.users[0]));
                                  debugPrint('Swiped Left');
                                  Navigator.pop(context);
                                },
                                child: const ChoiceButton(
                                  colour: Colors.red,
                                  icon: Icons.clear_outlined,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SwipeBloc>()
                                      .add(SwipeRight(user: state.users[0]));
                                  debugPrint('Swiped Right');
                                  Navigator.pop(context);
                                },
                                child: ChoiceButton(
                                    width: 80,
                                    height: 80,
                                    size: 30,
                                    colour:
                                        Theme.of(context).colorScheme.secondary,
                                    icon: Icons.favorite),
                              ),
                              const ChoiceButton(
                                colour: Colors.black54,
                                icon: Icons.watch_later,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName}, ${user.age}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '${user.server} - ${user.mainRole}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'INSERT USER STATS HERE WHEN READY. For now, I am just writing a really long sentence to make it look like an autobiography for the user.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              height: 2,
                            ),
                      ),

                      //Interest no longer implemented as decided by the team
                      //As our main focus is gaming, it would be too similar to
                      //Tinder if we included interest filter.
                      // Wrap(
                      //   children: user.interests!
                      //       .map(
                      //         (interest) => Container(
                      //           padding: const EdgeInsets.all(5.0),
                      //           margin: const EdgeInsets.only(
                      //             top: 5.0,
                      //             right: 5.0,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             color: Colors.deepPurple,
                      //             borderRadius: BorderRadius.circular(5.0),
                      //           ),
                      //           child: Text(
                      //             interest,
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .headline6!
                      //                 .copyWith(
                      //                   color: Colors.white,
                      //                   fontStyle: FontStyle.italic,
                      //                 ),
                      //           ),
                      //         ),
                      //       )
                      //       .toList(),
                      // ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Text('Oops.. Something Went Wrong!');
          }
        },
      ),
    );
  }
}
