import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/registration/screens/screens.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';

class RegistrationPage extends StatelessWidget {
  static const String routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: const RegistrationPage(),
      ),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Welcome'),
    Tab(text: 'Email'),
    Tab(text: 'GenderAge'),
    Tab(text: 'Pictures'),
    Tab(text: 'ServerRole'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'REGISTRATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              EmailScreen(tabController: tabController),
              GenderAgeScreen(tabController: tabController),
              Pictures(tabController: tabController),
              ServerRole(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
