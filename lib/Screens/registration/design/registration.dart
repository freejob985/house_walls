import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_walls/Files/Functions/Functions.dart';
import 'package:house_walls/Screens/Login/design/Login.dart';
import 'package:house_walls/Screens/registration/Cubit/AuthCubit.dart';
import 'package:house_walls/Screens/registration/Cubit/AuthState.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _mobile = '';
  String _password = '';
  DateTime? _birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.string(
            '''
            <svg xmlns='http://www.w3.org/2000/svg'  width='120' height='120' viewBox='0 0 120 120'>
              <rect fill='#00bb77' width='120' height='120'/>
              <polygon  fill='#000' fill-opacity='.1' points='120 0 120 60 90 30 60 0 0 0 0 0 60 60 0 120 60 120 90 90 120 60 120 0'/>
            </svg>
            ''',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ).animate().fadeIn(duration: 1200.ms), // Adding fade in effect to background
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField('الاسم', (value) => _name = value)
                          .animate()
                          .slide(duration: 800.ms, begin: Offset(-1, 0))
                          .fadeIn(duration: 800.ms), // Adding slide and fade in effect to the text field
                      SizedBox(height: 10),
                      _buildTextField('رقم الموبايل', (value) => _mobile = value)
                          .animate()
                          .slide(duration: 800.ms, begin: Offset(-1, 0))
                          .fadeIn(duration: 800.ms), // Adding slide and fade in effect to the text field
                      SizedBox(height: 10),
                      _buildTextField('كلمة المرور', (value) => _password = value, isPassword: true)
                          .animate()
                          .slide(duration: 800.ms, begin: Offset(-1, 0))
                          .fadeIn(duration: 800.ms), // Adding slide and fade in effect to the text field
                      SizedBox(height: 10),
                      _buildDatePicker(context)
                          .animate()
                          .slide(duration: 800.ms, begin: Offset(-1, 0))
                          .fadeIn(duration: 800.ms), // Adding slide and fade in effect to the date picker
                      SizedBox(height: 20),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم التسجيل بنجاح')),
                            );
                            Navigator.pushReplacementNamed(context, 'Home');
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            child: state is AuthLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'تسجيل',
                                    style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold),
                                  ).animate().scale(duration: 500.ms), // Adding scale effect to the button
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    submitForm(
                                      formKey: _formKey,
                                      birthDate: _birthDate,
                                      name: _name,
                                      mobile: _mobile,
                                      password: _password,
                                      context: context,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'هل لديك حساب بالفعل؟ سجل الدخول',
                          style: GoogleFonts.alexandria(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().slide(duration: 800.ms, begin: Offset(0, 1))
                        .fadeIn(duration: 800.ms), // Adding slide and fade in effect to the button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved, {bool isPassword = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.alexandria(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال $label';
        }
        return null;
      },
      onSaved: (value) => onSaved(value!),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != _birthDate) {
          setState(() {
            _birthDate = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'تاريخ الميلاد',
          labelStyle: GoogleFonts.alexandria(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _birthDate == null ? 'اختر التاريخ' : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
              style: GoogleFonts.alexandria(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
