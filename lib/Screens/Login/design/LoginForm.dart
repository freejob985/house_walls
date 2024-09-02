import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_walls/Screens/Login/Cubit/LoginCubit.dart';
import 'package:house_walls/Screens/Login/Cubit/LoginState.dart';
import 'package:house_walls/Screens/registration/design/registration.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginForm extends StatefulWidget {
  final LoginState state;

  const LoginForm({Key? key, required this.state}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/login_icon.svg',
                    height: 80,
                    width: 80,
                  ).animate().fade(duration: 500.ms).scale(delay: 300.ms),
                  const SizedBox(height: 24),
                  Text(
                    'تسجيل دخول',
                    style: GoogleFonts.alexandria(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOut),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade200, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade200, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade400, width: 2),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.purple.shade400),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ).animate().slideX(begin: -0.2, duration: 500.ms, curve: Curves.easeOut),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade200, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade200, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purple.shade400, width: 2),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.purple.shade400),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ).animate().slideX(begin: 0.2, duration: 500.ms, curve: Curves.easeOut),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: Colors.purple.shade400,
                      ),
                      Text(
                        'تذكرني',
                        style: GoogleFonts.alexandria(),
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.state is! LoginLoading) {
                        BlocProvider.of<LoginCubit>(context).login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: widget.state is LoginLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ).animate().scale(delay: 500.ms, duration: 300.ms),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                      );
                    },
                    child: Text(
                      'ليس لديك حساب؟ سجل الآن',
                      style: GoogleFonts.alexandria(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}