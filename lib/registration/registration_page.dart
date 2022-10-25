import 'package:flutter/material.dart';
import 'package:projectloner/registration/screens/screens.dart';
import 'package:projectloner/theme/icon_button.dart';

class RegistrationPage extends StatelessWidget {
  static const String routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const RegistrationPage(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Welcome'),
    Tab(text: 'Email'),
    Tab(text: 'GenderAge'),
    Tab(text: 'Pictures'),
    Tab(text: 'ServerRole'),
    Tab(text: 'Interests'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        return Scaffold(
          key: Key("scaffold"),
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            actions: [
              ThemeIconButton(
                key: Key("toggleIconTheme"),
              ),
            ],
            title: const Text(
              'REGISTRATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Start(tabController: tabController),
              EmailScreen(tabController: tabController),
              GenderAgeScreen(tabController: tabController),
              Pictures(tabController: tabController),
              ServerRole(tabController: tabController),
              InterestScreen(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
