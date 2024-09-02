import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_walls/Screens/Login/Cubit/LoginState.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError('لم يتم العثور على مستخدم بهذا البريد الإلكتروني'));
      } else if (e.code == 'wrong-password') {
        emit(LoginError('كلمة المرور غير صحيحة'));
      } else {
        emit(LoginError('حدث خطأ أثناء تسجيل الدخول'));
      }
    } catch (e) {
      emit(LoginError('حدث خطأ غير متوقع'));
    }
  }
}