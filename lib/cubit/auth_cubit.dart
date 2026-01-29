import 'package:app_todo_application/AuthService/auth_service.dart';
import 'package:app_todo_application/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

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

  //hàm đăng nhập
  void register(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      await _authService.signUp(email, password, name);
      await _authService.sendEmailVerification();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
