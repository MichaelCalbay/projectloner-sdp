import 'package:flutter/material.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/widgets/widgets.dart';

class MatchProfile extends StatelessWidget {
  final User user;

  const MatchProfile({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, top: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(user.imageUrls[0]),
                        fit: BoxFit.cover,
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
                        const ChoiceButton(
                          colour: Colors.red,
                          icon: Icons.clear_outlined,
                        ),
                        ChoiceButton(
                            width: 80,
                            height: 80,
                            size: 30,
                            colour: Theme.of(context).colorScheme.secondary,
                            icon: Icons.favorite),
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
                  '${user.server} - ${user.role}',
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
                const SizedBox(height: 15.0),
                Text(
                  'Interests ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Wrap(
                  children: user.interests!
                      .map(
                        (interest) => Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(
                            top: 5.0,
                            right: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            interest,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}