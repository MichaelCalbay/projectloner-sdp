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
                  imageUrl: (activeMatches[index].matchedUser.imageUrls.isEmpty)
                      ? ((activeMatches[index].matchedUser.gender == 'Male')
                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                          : ((activeMatches[index].matchedUser.gender ==
                                  'Female')
                              ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                              : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                      : activeMatches[index].matchedUser.imageUrls[0],
                ),
                Expanded(
                  child: Column(
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        activeMatches[index].chat.messages[0].timeToString,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
