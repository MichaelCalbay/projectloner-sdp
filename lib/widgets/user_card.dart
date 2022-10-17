import 'package:flutter/material.dart';
import 'package:projectloner/matching/match_profile.dart';
import 'package:projectloner/models/models.dart';
import 'package:projectloner/widgets/widgets.dart';

class UserCard extends StatelessWidget {
  final LonerUser user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user_image',
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CustomUserImage.large(url: user.imageUrls[0]),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName}, ${user.age}',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '${user.mainRole} - ${user.server}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    SizedBox(
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user.imageUrls.length + 1,
                          itemBuilder: (builder, index) {
                            return (index < user.imageUrls.length)
                                ? CustomUserImage.small(
                                    url: user.imageUrls[index],
                                    margin: const EdgeInsets.only(
                                        top: 8.0, right: 8.0),
                                  )
                                : Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MatchProfile(user: user),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.info_outline,
                                          size: 25,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        )
                        // Row(
                        //   children: [
                        //     SmallUserImage(imageUrl: user.imageUrls[1]),
                        //     SmallUserImage(imageUrl: user.imageUrls[2]),
                        //     SmallUserImage(imageUrl: user.imageUrls[3]),
                        //     const SizedBox(width: 10),
                        //     Material(
                        //       color: Colors.transparent,
                        //       child: Container(
                        //         width: 35,
                        //         height: 35,
                        //         decoration: const BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.white,
                        //         ),
                        //         child: InkWell(
                        //           onTap: () => Navigator.of(context).push(
                        //             MaterialPageRoute(
                        //               builder: (context) =>
                        //                   MatchProfile(user: user),
                        //             ),
                        //           ),
                        //           child: Icon(
                        //             Icons.info_outline,
                        //             size: 25,
                        //             color: Theme.of(context).primaryColor,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
