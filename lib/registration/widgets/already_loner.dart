import 'package:flutter/material.dart';
import 'package:projectloner/auth/login_page.dart';

class AlreadyLoner extends StatelessWidget {
  const AlreadyLoner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already a Loner? '),
        GestureDetector(
          child: const Text(
            'Login.',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
