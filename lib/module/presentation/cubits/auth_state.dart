import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

// trạng thái khởi tạo
class AuthInitial extends AuthState {}

// trạng thái đang tải
class AuthLoading extends AuthState {}

// trạng thái đăng nhập thành công
class Authenticated extends AuthState {
  final User user;
  Authenticated(this.user);
}

// trạng thái đăng nhập lỗi
class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage);
}

// trạng thái hiển thị thông báo thành công
class AuthMessage extends AuthState {
  final String message;
  AuthMessage(this.message);
}

// 6. trạng thái đã đăng xuất
class Unauthenticated extends AuthState {}
