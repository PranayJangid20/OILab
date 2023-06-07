import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oilab_task/features/auth/cubit/auth_cubit.dart';
import 'package:oilab_task/features/auth/presentation/login_page.dart';
import 'package:oilab_task/features/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oilab_task/features/home/presentation/home_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (BuildContext context) => HomeCubit(),
    ),
    BlocProvider(
      create: (BuildContext context) => AuthCubit(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OILab',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          displayMedium: TextStyle(color: Colors.white, fontSize: 14),
          displaySmall: TextStyle(color: Colors.white, fontSize: 12),
        ),
        primarySwatch: Colors.lightGreen,
      ),
      home: Material(
          child: context.read<AuthCubit>().auth.currentUser != null
              ? const HomePage()
              : const LoginPage()),
    );
  }
}
