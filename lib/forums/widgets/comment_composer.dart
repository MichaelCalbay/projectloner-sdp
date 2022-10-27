import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/forums/Database/forums_firestore.dart';

class CommentComposer extends StatelessWidget {
  final TextEditingController _msgController = TextEditingController();
  final DocumentSnapshot data;
  final String userName;
  CommentComposer({
    super.key,
    required this.data,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.secondary),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _msgController,
                        onSubmitted: (_) => _handleSubmitted,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Write a comment...'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconButton(
                        onPressed: (() {
                          _handleSubmitted(
                            _msgController.text,
                            (state.user.imageUrls.isEmpty)
                                ? ((state.user.gender == 'Male')
                                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxub6hsCPpJFn6jmQvDl5CDJLroGdg-yLXJV1KcCHMjKpuwd8E6zJ7X6U3TUEjlS59ig&usqp=CAU'
                                    : ((state.user.gender == 'Female')
                                        ? 'https://us.123rf.com/450wm/apoev/apoev1902/apoev190200082/125259956-person-gray-photo-placeholder-woman-in-shirt-on-white-background.jpg?ver=6'
                                        : 'https://dthezntil550i.cloudfront.net/3w/latest/3w1802281317020600001818004/1280_960/45b9e268-7f83-4d2a-98cb-8843e805359b.png'))
                                : state.user.imageUrls[0],
                          );
                        }),
                        icon: const Icon(
                          Icons.send,
                          color: Colors.deepPurple,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            const Center(
              child: Text('Something went wrong...'),
            );
          }

          return Container();
        },
      );

  Future _handleSubmitted(String text, String image) async {
    if (text != '') {
      try {
        await ForumsStore.commentToPost(
          data['postID'],
          _msgController.text,
          userName,
          image,
        );
        await ForumsStore.updatePostCommentCount(data);
      } catch (e) {}
    }
  }
}
