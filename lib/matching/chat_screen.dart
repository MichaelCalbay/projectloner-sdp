import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/repositories/database/database_repo.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/chat/chat_bloc.dart';
import '../models/models.dart';
import '../theme/theme_provider.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch match}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(
            LoadChat(match.chat.id),
          ),
        child: ChatScreen(userMatch: match),
      ),
    );
  }

  final UserMatch userMatch;
  const ChatScreen({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MessageAppBar(userMatch: userMatch),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatLoaded) {
            return Column(
              children: [
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: state.chat.messages.length,
                  itemBuilder: (context, index) {
                    List<Message> messages = state.chat.messages;
                    return ListTile(
                      title: _Message(
                        message: messages[index].message,
                        isFromCurrentUser: messages[index].senderId ==
                            context.read<AuthBloc>().state.authUser!.uid,
                      ),
                    );
                  },
                ),
                const Spacer(),
                _MessageInput(userMatch: userMatch),
              ],
            );
          } else {
            return const Text('Oops, something went wrong...');
          }
        },
      ),
    );
  }
}

class _MessageAppBar extends StatelessWidget with PreferredSizeWidget {
  const _MessageAppBar({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  final UserMatch userMatch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                (userMatch.matchedUser.imageUrls.isEmpty)
                    ? ((userMatch.matchedUser.gender == 'Male')
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                        : ((userMatch.matchedUser.gender == 'Female')
                            ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                            : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                    : userMatch.matchedUser.imageUrls[0],
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _MessageInput extends StatelessWidget {
  _MessageInput({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  final themeProvider = LonerThemeProvider();
  final UserMatch userMatch;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
            child: IconButton(
              onPressed: () {
                (controller.text.isEmpty ? null : context.read<ChatBloc>())
                    ?.add(
                  AddMessage(
                    userId: userMatch.userId,
                    matchedUserId: userMatch.matchedUser.id!,
                    message: controller.text,
                  ),
                );
                controller.clear();
              },
              icon: const Icon(
                Icons.send_outlined,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    themeProvider.isDarkMode ? Colors.black : Colors.white,
                hintText: 'Type a message...',
                contentPadding: const EdgeInsets.only(
                  left: 20,
                  bottom: 5,
                  top: 5,
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.message,
    required this.isFromCurrentUser,
  }) : super(key: key);

  final String message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry alignment =
        isFromCurrentUser ? Alignment.topRight : Alignment.topLeft;

    Color colour = isFromCurrentUser
        ? Colors.deepPurpleAccent.shade700
        : Colors.blueAccent.shade700;

    TextStyle? textStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white);
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colour,
        ),
        child: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
