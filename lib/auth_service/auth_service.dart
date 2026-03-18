import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  // hàm quên mật khẩu
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Lỗi không xác định khi gửi email đặt lại mật khẩu";
    }
  }

  Future<void> sendOTPEmail(String toEmail, String otpCode) async {
    // 1. Điền email của BẠN vào đây
    String username = 'damtutai147@gmail.com';

    // 2. Điền MÃ 16 CHỮ CÁI bạn vừa tạo (viết liền không dấu cách)
    String password = dotenv.env['GMAIL_PASS'] ?? "";

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'DO IT App')
      ..recipients.add(toEmail)
      ..subject = 'Mã xác nhận tài khoản DO IT'
      ..html =
          """
        <h3>Xin chào!</h3>
        <p>Cảm ơn bạn đã đăng ký ứng dụng DO IT.</p>
        <p>Mã xác nhận (OTP) của bạn là: <b style="font-size: 20px; color: #0EA5E9;">$otpCode</b></p>
        <p>Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>
      """;

    try {
      await send(message, smtpServer);
      print('Đã gửi OTP thành công đến $toEmail');
    } catch (e) {
      print('Lỗi khi gửi mail: $e');
      // Tùy chọn: ném lỗi ra ngoài nếu muốn báo cho người dùng
      // throw Exception("Không thể gửi email xác thực.");
    }
  }
}
