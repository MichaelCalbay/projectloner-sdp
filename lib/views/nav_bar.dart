// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/login/screens/login_screen.dart';
import 'package:projectloner/matching/profile_screen.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';
import 'package:projectloner/profile/profile.dart';
import 'package:projectloner/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'home_view.dart';
//import 'HomeView.dart';
// import 'Page1.dart';
// import 'Page2.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class ChangeThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LonerThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider =
            Provider.of<LonerThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}

class _NavBarState extends State<NavBar> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return Drawer(
            width: 200,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        //Can be implemented to get current user's image[0]
                        state.user.imageUrls.isNotEmpty
                            ? state.user.imageUrls[0]
                            : 'https://thumbs.dreamstime.com/b/no-user-profile-picture-hand-drawn-illustration-53840792.jpg',
                      ),
                      backgroundColor: Colors.black87,
                    ),
                    accountName:
                        Text("${state.user.firstName} ${state.user.lastName}"),
                    accountEmail:
                        Text('${FirebaseAuth.instance.currentUser!.email}'),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Dark Mode"),
                    ChangeThemeWidget(),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text("Home Page"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                ListTile(
                  /*  BUG ICON  */
                  leading: Icon(Icons.bug_report_rounded),
                  title: Text('Reports'),
                  onTap: () => Instabug.show(),
                ),
                ListTile(
                  leading: Icon(Icons.logout_sharp),
                  title: const Text("Logout"),
                  onTap: () {
                    RepositoryProvider.of<AuthRepository>(context).signOut();
                    FirebaseAuth.instance.signOut();

                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => LoginScreen()),
                      ),
                    );
                  },
                  tileColor: Colors.deepPurple,
                  textColor: Colors.white,
                ),
              ],
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
  }
}
