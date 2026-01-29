import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // hàm đăng nhập
  Future<UserCredential?> signin(String mail, String password) async {
    // gửi yêu cầu đăng nhập lên firebase
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Lỗi Đăng nhập không xác định ";
    }
  }

  // hàm đăng ký
  Future<UserCredential?> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Lỗi đăng ký không xác định";
    }
  }

  //hàm gửi email xác thực
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // hàm đăng xuất
  Future<void> signOut(String email, String password, String name) async {
    await _auth.signOut();
  }
}
