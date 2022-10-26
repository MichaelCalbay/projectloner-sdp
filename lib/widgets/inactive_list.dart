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
                      imageUrl: inactiveMatches[index].matchedUser.imageUrls[0],
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
