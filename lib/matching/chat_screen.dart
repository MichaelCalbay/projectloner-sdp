import 'package:flutter/material.dart';

import '../models/models.dart';

class ChatScreen extends StatelessWidget {
  final UserMatch userMatch;
  const ChatScreen({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  userMatch.matchedUser.imageUrls[0],
                ),
              ),
              const SizedBox(width: 5),
              Text(
                userMatch.matchedUser.firstName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMatch.chat![0].messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: userMatch
                                          .chat![0].messages[index].senderId ==
                                      1
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            color: Color.fromARGB(
                                                255, 98, 57, 193)),
                                        child: Text(
                                          userMatch
                                              .chat![0].messages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              userMatch
                                                  .matchedUser.imageUrls[0],
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              color: Color.fromARGB(
                                                  255, 89, 122, 220),
                                            ),
                                            child: Text(
                                              userMatch.chat![0].messages[index]
                                                  .message,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            height: 100,
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type a message...',
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        bottom: 5,
                        top: 5,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
