import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'firebase_auth_service.dart';

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

            },
            child: Text('탈퇴하기'),
          ),
        ],
      );
    },
  );
}
