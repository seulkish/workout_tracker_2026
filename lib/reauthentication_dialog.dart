import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'firebase_auth_service.dart';
import 'show_snackbar.dart';

Future<String?> showReauthenticationDialog(BuildContext context, FirebaseAuthService auth) {
  final TextEditingController passwordController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Password 확인'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Enter your password'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, null); // Close dialog without result
            },
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async{
              try{
                await auth.reauthenticateAndDeleteAccount(passwordController.text);
                context.go('/settings/login');
              } catch(e){
                showSnackbar(context, e.toString());
              }
              Navigator.pop(context);
            },
            child: Text('탈퇴하기'),
          ),
        ],
      );
    },
  );
}
