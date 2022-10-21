import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectloner/blocs/auth/auth_bloc.dart';
import 'package:projectloner/blocs/onboarding/onboarding_bloc.dart';
import 'package:projectloner/blocs/swipe/swipe_bloc.dart';
import 'package:projectloner/cubit/signup/signup_cubit.dart';
import 'package:projectloner/login/screens/login_screen.dart';
import 'package:projectloner/main.dart';
import 'package:projectloner/registration/registration_page.dart';
import 'package:projectloner/repositories/database/database_repo.dart';
import 'package:projectloner/repositories/registration/auth_repo.dart';
import 'package:projectloner/repositories/storage/storage_repo.dart';
import 'package:projectloner/theme/theme_provider.dart';
import 'package:projectloner/views/home_view.dart';
import 'package:projectloner/views/onboarding_screen.dart';
import 'package:projectloner/theme/icon_button.dart';
import 'package:provider/provider.dart';

/// 
/// Dark Mode Testing
/// 
/// - Ben Rodenas 20121725
/// 

void main() {
  group('Unit Tests?', (){
    test('Testing dark mode enabled', () {
      final themeProvider = LonerThemeProvider();

      themeProvider.toggleTheme(true);

      expect(LonerThemeProvider.isDarkMode, true);
      expect(LonerThemeProvider.themeMode, ThemeMode.dark);
    });
    test('Testing dark mode disabled', () {
      final themeProvider = LonerThemeProvider(); 

      themeProvider.toggleTheme(false);

      expect(LonerThemeProvider.isDarkMode, false);
      expect(LonerThemeProvider.themeMode, ThemeMode.light);
    });
  });

  group('Widget Tests', (){
    testWidgets('Login Page Toggle Dark/Light Mode', (WidgetTester tester) async {
      
      final toggleButtonTheme = find.byKey(ValueKey("toggleButtonTheme"));
      final themeProvider = LonerThemeProvider(); 

      await tester.pumpWidget(
        ChangeNotifierProvider(
        create: (context) => LonerThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<LonerThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) => RegistrationPage.route(),
            home: const LoginScreen(),
            themeMode: LonerThemeProvider.themeMode,
            theme: LonerTheme.lightMode,
            darkTheme: LonerTheme.darkMode,
          );
        })
      );
      
      expect(toggleButtonTheme, findsOneWidget);
      expect(LonerThemeProvider.themeMode, ThemeMode.light);

      await tester.tap(toggleButtonTheme);

      expect(LonerThemeProvider.themeMode, ThemeMode.dark);

      await tester.tap(toggleButtonTheme);

      expect(LonerThemeProvider.themeMode, ThemeMode.light);
    });

    // INCOMPLETE (Or probably leave out)
    /*
    testWidgets('Register Page Toggle Dark/Light Mode', (WidgetTester tester) async {
      
      final toggleButtonTheme = find.byKey(ValueKey("toggleButtonTheme"));
      final toggleIconTheme = find.byKey(ValueKey("toggleIconTheme"));
      final themeProvider = LonerThemeProvider(); 
      //final help = find.byKey(ValueKey("HELP"));
      RegistrationPage registrationPage = const RegistrationPage();

      await tester.pumpWidget(
        MultiRepositoryProvider(
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
        )
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
        create: (context) => LonerThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<LonerThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) => RegistrationPage.route(),
            home: const LoginScreen(),
            themeMode: LonerThemeProvider.themeMode,
            theme: LonerTheme.lightMode,
            darkTheme: LonerTheme.darkMode,
          );
        })
      );


      //expect(find.byKey(ValueKey("registerNow")), findsOneWidget);

      //await tester.tap(find.byKey(ValueKey("registerNow")));
      
      //expect(find.byKey(ValueKey("scaffold")), findsOneWidget);
    });
    */
  });
}
