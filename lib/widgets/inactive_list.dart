import 'package:flutter/material.dart';
import 'package:projectloner/widgets/widgets.dart';

import '../matching/chat_screen.dart';
import '../models/models.dart';

class InactiveList extends StatelessWidget {
  const InactiveList({
    Key? key,
    required this.inactiveMatches,
  }) : super(key: key);

  final List<UserMatch> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: inactiveMatches.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ChatScreen.routeName,
                  arguments: inactiveMatches[index],
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                child: Column(
                  children: [
                    SmallUserImage(
                      height: 70,
                      width: 70,
                      imageUrl: (inactiveMatches[index]
                              .matchedUser
                              .imageUrls
                              .isEmpty)
                          ? ((inactiveMatches[index].matchedUser.gender ==
                                  'Male')
                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                              : ((inactiveMatches[index].matchedUser.gender ==
                                      'Female')
                                  ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                                  : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                          : inactiveMatches[index].matchedUser.imageUrls[0],
                    ),
                    Text(
                      inactiveMatches[index].matchedUser.firstName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
