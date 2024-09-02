import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_walls/Screens/registration/Cubit/AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String mobile,
    required String password,
    required DateTime birthDate,
  }) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: '$mobile@example.com', // استخدام رقم الهاتف كالبريد الإلكتروني
        password: password,
      );

      await userCredential.user?.updateProfile(displayName: name);
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'mobile': mobile,
        'birthDate': birthDate,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
