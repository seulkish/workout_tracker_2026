// filename: registration_page.dart
import 'package:flutter/material.dart';

import 'firebase_auth_service.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuthService _auth=FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/runner_icon.png',
                      width: 42,
                      color: colorScheme.primary,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '회원 가입',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '정보기입',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '이름',
                    labelStyle: textTheme.headlineSmall,
                    border: UnderlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return '이름을 입력하세요';
                    }
                    return null;
                  },
                  onSaved: (value){
                    name=value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle:  textTheme.headlineSmall,
                    hintText: 'example@example.com',
                    border: UnderlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return '이름을 입력하세요';
                    }
                    return null;
                  },
                  onSaved: (value){
                    name=value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle:  textTheme.headlineSmall,
                    hintText: '비밀번호를 입력하세요',
                    helperText: '*비밀번호는 6자 이상 입력해주세요.',
                    helperStyle: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                    border: UnderlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  obscureText: true,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return '패스워드를 입력하세요';
                    }
                    if(value.length < 6){
                      return '6자리 이상 입력하세요';
                    } // firebase가 6자리 이하는 지원하지 않음
                    return null;
                  },
                  onSaved: (value){
                    password=value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호확인',
                    labelStyle: textTheme.headlineSmall,
                    hintText: '비밀번호를 한번더 입력하세요',
                    border: UnderlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return '비밀번호를 한번더 입력하세요';
                    }
                    else if (value != [password]){
                      return '비밀번호가 일치하지 않습니다';
                    }
                    return null;
                  },
                  onSaved: (value){
                    password=value;
                  },

                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        _auth.signUpWithEmail(email: email!, password: password!, name: name);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      '가입하기',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}