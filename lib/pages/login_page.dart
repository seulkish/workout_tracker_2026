//filename:login_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_2026/show_snackbar.dart';
import '../services/firebase_auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  FirebaseAuthService _auth=FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'My perfect workout mate',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Workout\nTracker',
                          style: textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assets/runner_icon.png',
                            width: 32,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'example@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return '이메일을 입력하세요';
                    }
                    //@가 들어있는지 체크하는 로직 추가 필요
                    return null;
                  },
                  onSaved: (value){
                    email=value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go('/settings/login/reset_password');
                      },
                      child: Text('Forgot your password?'),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState?.validate() ?? false){
                        _formKey.currentState?.save();
                        //backend 전송 : email, password
                        //fb.auth.login(email, password);
                        _auth.signInWithEmail(email: email!, password: password!)
                            .then((value){
                              showSnackbar(context, '로그인 성공');
                              context.go('/workout_home');
                        })
                            .catchError((error){showSnackbar(context, '$error');
                        });
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
                      '로그인',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        context.go('/settings/login/registration');
                      },
                      child: Text('Sign up'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}