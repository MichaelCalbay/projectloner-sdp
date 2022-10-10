import 'package:flutter/material.dart';
import 'package:projectloner/matching/chat_screen.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../models/models.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: const MatchingAppBar(
        title: 'Matches',
        actionButtons: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Faves',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SmallUserImage(
                            height: 70,
                            width: 70,
                            imageUrl:
                                inactiveMatches[index].matchedUser.imageUrls[0],
                          ),
                          Text(
                            inactiveMatches[index].matchedUser.firstName,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 10),
              Text(
                'Chats',
                style: Theme.of(context).textTheme.headline6,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeMatches.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userMatch: activeMatches[index],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SmallUserImage(
                              height: 70,
                              width: 70,
                              imageUrl: activeMatches[index]
                                  .matchedUser
                                  .imageUrls[0]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeMatches[index].matchedUser.firstName,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[activeMatches[index]
                                            .chat![0]
                                            .messages
                                            .length -
                                        1]
                                    .message,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .timeToString,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
