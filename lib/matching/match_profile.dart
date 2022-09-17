import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/widgets/widgets.dart';

class MatchProfile extends StatelessWidget {
  const MatchProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = User.users[0];
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
                        image: NetworkImage(User.users[0].imageUrls[0]),
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
                  'About User: ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'INSERT USER STATS HERE WHEN READY. For now, I am just writing a really long sentence to make it look like an autobiography for the user.',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        height: 2,
                      ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Interests ',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
