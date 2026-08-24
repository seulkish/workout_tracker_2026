import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_tracker_2026/show_snackbar.dart';
import 'reauthentication_dialog.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  FirebaseAuthService() : _auth = FirebaseAuth.instance {
    _auth.setLanguageCode('kr');
  }

  Future<void> deletePhotoUrl() async {
    try{
      await _auth.currentUser?.updatePhotoURL(null);
    }
    catch(e){
      throw Exception('$e');
    }
  }

  User? get user=> _auth.currentUser;
  Future<void> updatePhotoUrl(String? url) async {
    try{
      await _auth.currentUser?.updatePhotoURL(url);
    }
    catch(e){
      throw Exception('수정 실패: $e');
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    //회원가입 코드 작성
    String? errorMessage;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(name);
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (error){
      switch (error.code){
        case 'weak-password':
          errorMessage='취약 패스워드';
        case 'email-already-in-use':
          errorMessage='사용중인 이메일';
        default:
          errorMessage = error.message;
      }
    } catch(e){
      throw Exception('회원가입 에러: $e');
    }

    if(errorMessage != null){
      throw Exception(errorMessage);
    }
  }

  Future<void> signInWithEmail({required String email, required String password}) async {
    //로그인 코드 작성
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      throw Exception('로그인 에러"$e');
    }
  }

  Future<void> signOut() async {
    //로그아웃 코드 작성
    try{
      _auth.signOut();
    }catch(e){
      throw Exception('로그아웃 에러:$e');
    }
  }
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
  Future<void> resetPassword({
    required String email,
  }) async {
    // 비밀번호 재설정 코드 작성
    String? errorMessage;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    }
    on FirebaseAuthException catch(e){
      switch (e.code) {
        case 'auth/user-not-found':
          errorMessage = '해당 이메일로 가입된 사용자가 없습니다.';
          break;
        case 'auth/invalid-email':
          errorMessage = '유효하지 않은 이메일입니다.';
          break;
        default:
          errorMessage = e.message ?? '알 수 없는 오류가 발생했습니다.';
      }
    }
    catch (e) {
      errorMessage = '알 수 없는 오류가 발생했습니다';
    }
    if(errorMessage != null){
      throw Exception(errorMessage);
    }
  }

  Future<void> deleteAccount() async {
    //계정삭제 코드 작성
    try {
      await _auth.currentUser?.delete();
    }
    catch (e) {
      print('Error: $e');
      throw Exception('탈퇴 중 에러 발생: $e');
    // } on FirebaseAuthException catch(e) {
    //   if (e.code == 'requires-recent-login') {
    //     rethrow;
    //   } else {
    //     throw Exception('탈퇴과정 중 문제 발생: ${e.toString()}');
    //   }
    }
  }

  Future<void> reauthenticateAndDeleteAccount(String password) async {
    String? errorMessage;
    try{
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception('로그인된 사용자가 없습니다.');
      }

      final email = user.email;

      if (email == null || email.isEmpty) {
        throw Exception('이메일 정보가 없습니다.');
      }

      // 현재 사용자의 이메일과 비밀번호 인증 정보 생성
      AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
      );

      // 사용자 재인증
      await user.reauthenticateWithCredential(credential);
      // 계정 삭제
      await user.delete();
    } on FirebaseAuthException catch (e) {
      errorMessage = switch (e.code) {
        'wrong-password' || 'invalid-credential' => '잘못된 비밀번호입니다.',
        'too-many-requests' =>
        '요청이 너무 많습니다. 잠시 후 다시 시도해 주세요.',
        _ =>
        e.message ?? '회원 탈퇴에 실패했습니다.',
      };
      throw Exception(errorMessage);
    }
  }

  Future<void> updateProfile() async {
    //
  }
}
