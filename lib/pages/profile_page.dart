//filename:profile_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebase_auth_service.dart';
import '../show_snackbar.dart';
import '../services/firebase_storage_service.dart';
import '../widgets/reauthentication_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuthService();
  final _storage = FirebaseStorageService();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? profileImageURL;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async{
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      String? downloadUrl;
      try {
        downloadUrl = await _storage.uploadProfileImage(
          bytes: await pickedFile.readAsBytes(),
          path: pickedFile.path,
          uid: _auth.user?.uid,
        );

        await _auth.updatePhotoUrl(downloadUrl);

        setState(() {
          profileImageURL=downloadUrl;
        });
      } catch (e){
        //error 처리
        showSnackbar(context, '$e');
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = _auth.user?.displayName;
    email = _auth.user?.email;
    profileImageURL = _auth.user?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary, // 원하는 border 색상
                          width: 1.0,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                          profileImageURL != null
                              ? NetworkImage(profileImageURL!)
                              : const AssetImage('assets/me.png'),
                          onBackgroundImageError: (_, __) {
                            setState(() {
                              profileImageURL = null;
                            });
                          },
                          backgroundColor: Colors.transparent,
                          child:Icon(
                            Icons.camera_alt,
                            size: textTheme.headlineMedium?.fontSize,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceDim,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.close, color: colorScheme.onPrimary),
                            onPressed: () {
                              _auth.deletePhotoUrl().catchError((error){
                                showSnackbar(context, '$error');
                              });
                              _storage.deleteProfileImage(_auth.user?.uid).catchError((error){
                                showSnackbar(context, '$error');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: textTheme.titleLarge,
                  hintText: 'Enter your name',
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: textTheme.titleLarge,
                  border: UnderlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have you verified your email yet?',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Send Email',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              // 수정 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '수정',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              // 로그아웃/회원탈퇴
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '로그아웃',
                      style: TextStyle(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Text('|'),
                  TextButton(
                    onPressed: () async {
                      try {
                        // await _auth.deleteAccount();
                        showReauthenticationDialog(context, _auth);
                        showSnackbar(context, '탈퇴처리가 완료되었습니다.');
                        context.go('/settings/login');
                      }
                      catch(e) {
                        showSnackbar(context, e.toString());
                      }
                    },
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
