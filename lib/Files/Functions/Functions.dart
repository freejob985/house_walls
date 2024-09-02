import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_walls/Screens/registration/Cubit/AuthCubit.dart';

void submitForm({
  required GlobalKey<FormState> formKey,
  required DateTime? birthDate,
  required String name,
  required String mobile,
  required String password,
  required BuildContext context,
}) {
  // التحقق من صحة النموذج والتحقق من أن تاريخ الميلاد قد تم تحديده
  if (formKey.currentState!.validate() && birthDate != null) {
    // حفظ البيانات المدخلة في النموذج
    formKey.currentState!.save();
    
    // استدعاء وظيفة registerUser في AuthCubit لإجراء عملية التسجيل
    context.read<AuthCubit>().registerUser(
      name: name,
      mobile: mobile,
      password: password,
      birthDate: birthDate,
    );
  } else {
    // إذا لم يتم التحقق من صحة النموذج أو لم يتم إدخال تاريخ الميلاد
    // إظهار رسالة خطأ للمستخدم عبر Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('الرجاء إكمال جميع الحقول')),
    );
  }
}



Widget buildTextField({
  required String label,
  required Function(String) onSaved,
  bool isPassword = false,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.alexandria(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
    style: GoogleFonts.alexandria(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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


Widget buildDatePicker({
  required BuildContext context,
  required DateTime? birthDate,
  required Function(DateTime) onDateSelected,
}) {
  return InkWell(
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != birthDate) {
        onDateSelected(picked);
      }
    },
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: 'تاريخ الميلاد',
        labelStyle: GoogleFonts.alexandria(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
            birthDate == null
                ? 'اختر التاريخ'
                : '${birthDate.day}/${birthDate.month}/${birthDate.year}',
            style: GoogleFonts.alexandria(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Icon(Icons.calendar_today, color: Colors.white),
        ],
      ),
    ),
  );
}


  int _getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1200) {
      return 5;
    } else if (constraints.maxWidth > 800) {
      return 4;
    } else if (constraints.maxWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }
