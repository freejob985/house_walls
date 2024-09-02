import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_walls/Screens/Login/Cubit/LoginCubit.dart';
import 'package:house_walls/Screens/Login/Cubit/LoginState.dart';
import 'package:house_walls/Screens/Login/design/LoginBackground.dart';
import 'package:house_walls/Screens/Login/design/LoginForm.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Fluttertoast.showToast(
              msg: "تم تسجيل الدخول بنجاح",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.pushReplacementNamed(context, 'Home');
          } else if (state is LoginError) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                const LoginBackground(),
                LoginForm(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}