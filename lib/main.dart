import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_walls/Screens/Home/design/Home.dart';
import 'package:house_walls/Screens/Login/design/Login.dart';
import 'package:house_walls/Screens/registration/Cubit/AuthCubit.dart';
import 'package:house_walls/Screens/registration/design/registration.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        routes: {
          'Login': (context) => const Login(),
          'Registration': (context) => const Registration(),
          'Home': (context) => const Home(),
        },
        initialRoute: 'Home',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}