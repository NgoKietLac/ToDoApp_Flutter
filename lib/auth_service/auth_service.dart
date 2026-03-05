import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _otpCollection = FirebaseFirestore.instance
      .collection('otp_codes');
  final CollectionReference _pendingUsers = FirebaseFirestore.instance
      .collection('pending_users');

  // hàm đăng nhập
  Future<UserCredential?> signin(String mail, String password) async {
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

  // hàm đăng xuất
  Future<void> signOut(String email, String password, String name) async {
    await _auth.signOut();
  }

  // hàm Lưu thông tin tạm thời (Tên, Email, Pass, OTP)
  Future<void> savePendingRegistration({
    required String email,
    required String password,
    required String name,
    required String otpCode,
  }) async {
    await _pendingUsers.doc(email).set({
      'email': email,
      'password': password,
      'name': name,
      'code': otpCode,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // hàm Lấy dữ liệu tạm để xác thực
  Future<DocumentSnapshot> getPendingData(String email) async {
    return await _pendingUsers.doc(email).get();
  }

  // hàm Xóa dữ liệu tạm sau khi hoàn tất
  Future<void> deletePendingData(String email) async {
    await _pendingUsers.doc(email).delete();
  }
}
