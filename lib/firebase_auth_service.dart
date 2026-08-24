import 'package:firebase_auth/firebase_auth.dart';

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
  Future<void> resetPassword(String email) async {
    // 비밀번호 재설정 코드 작성
  }

  Future<void> deleteAccount() async {
    //계정삭제 코드 작성
  }
  Future<void> updateProfile() async {
    //
  }
}
