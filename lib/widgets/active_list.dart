import 'package:flutter/material.dart';
import 'package:projectloner/matching/chat_screen.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../models/models.dart';

class ActiveList extends StatelessWidget {
  const ActiveList({
    Key? key,
    required this.activeMatches,
  }) : super(key: key);

  final List<UserMatch> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: activeMatches.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ChatScreen.routeName,
                arguments: activeMatches[index],
              );
            },
            child: Row(
              children: [
                SmallUserImage(
                    height: 70,
                    width: 70,
                    imageUrl: activeMatches[index].matchedUser.imageUrls.isNotEmpty ? 
                    activeMatches[index].matchedUser.imageUrls[0] :
                    'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeMatches[index].matchedUser.firstName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat.messages[0].message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      activeMatches[index].chat.messages[0].timeToString,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
