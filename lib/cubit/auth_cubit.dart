import 'dart:math';

import 'package:app_todo_application/AuthService/auth_service.dart';
import 'package:app_todo_application/cubit/auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  String? pendingEmail;

  AuthCubit() : super(AuthInitial());

  // hàm đăng nhập
  void login(String mail, String password) async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.signin(mail, password);

      final user = userCredential?.user;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError("Không thể lấy đc thông tin người dùng"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  //hàm đăng ký
  void register(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      pendingEmail = email;
      String otpcode = (Random().nextInt(900000) + 100000).toString();
      await _authService.savePendingRegistration(
        email: email,
        password: password,
        name: name,
        otpCode: otpcode,
      );
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // hàm xác thực
  void verifyOTP(String email, String inputCode) async {
    emit(AuthLoading());
    try {
      DocumentSnapshot otpDoc = await _authService.getPendingData(email);

      if (otpDoc.exists) {
        Map<String, dynamic> data = otpDoc.data() as Map<String, dynamic>;
        if (data['code'] == inputCode) {
          final userCredential = await _authService.signUp(
            data['email'],
            data['password'],
            data['name'],
          );
          if (userCredential?.user != null) {
            await _authService.deletePendingData(email);
            emit(Authenticated(userCredential!.user!));
          }
        } else {
          emit(AuthError("Mã xác thực không chính xác"));
        }
      } else {
        emit(AuthError("Không tìm thấy mã xác thực"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // hàm logout
  void logout() async {
    await _authService.signOut("", "", "");
    pendingEmail = null; // Xóa email tạm
    emit(Unauthenticated());
  }
}
