import 'package:flutter/material.dart';

class CommentComposer extends StatelessWidget {
  final TextEditingController _msgController = TextEditingController();
  CommentComposer({super.key});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _msgController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Write a comment...'),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                child: IconButton(
                  onPressed: (() {
                    _handleSubmitted(_msgController.text);
                  }),
                  icon: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ));
  }
}

Future<void> _handleSubmitted(String text) async {}
