// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:projectloner/blocs/profile/profile_bloc.dart';
import 'package:projectloner/config/app_router.dart';
import 'package:projectloner/login/screens/login_screen.dart';
import 'package:projectloner/blocs/auth/auth_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';
import 'package:projectloner/theme/theme_provider.dart';
import 'package:projectloner/views/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'repositories/database/database_repo.dart';
import 'repositories/storage/storage_repo.dart';

int? isviewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepo(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepo: context.read<StorageRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: ((context) => ProfileBloc(
                  authBloc: context.read<AuthBloc>(),
                  databaseRepository: context.read<DatabaseRepository>(),
                )),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Project: Loner',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    /*  BUG REPORTING SAM */
    super.initState();

    Instabug.setPrimaryColor(Colors.deepPurple);
    Instabug.setValueForStringWithKey("Report a User", CustomTextPlaceHolderKey.reportQuestion);
    Instabug.setValueForStringWithKey("Add screenshot, user name and provide context", CustomTextPlaceHolderKey.commentFieldHintForQuestion);
    Instabug.setValueForStringWithKey("Inappropriate or offensive context receive goes against"
        " Loner code of conducts ", CustomTextPlaceHolderKey.reportQuestionDescription);
    Instabug.start('204ec6dbacf517d824009b10798d3abd', [InvocationEvent.none]);
    Replies.setEnabled(false);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LonerThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<LonerThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: isviewed != 0 ? OnboardingScreen() : LoginScreen(),
          //Theme colour
          themeMode: LonerThemeProvider.themeMode,
          theme: LonerTheme.lightMode,
          darkTheme: LonerTheme.darkMode,
          //theme: ThemeData(primarySwatch: Colors.deepPurple),
        );
      });
}
