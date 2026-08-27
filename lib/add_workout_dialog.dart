//filename:add_workout_dialog.dart
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker_2026/logic/my_workout_provider.dart';
import 'package:workout_tracker_2026/show_snackbar.dart';

import '../services/firebase_storage_service.dart';
import 'models/my_workout.dart';

class AddWorkoutDialog extends StatefulWidget {
  AddWorkoutDialog({super.key});

  @override
  State<AddWorkoutDialog> createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {

  Future<void> _pickImage() async {
    //이미지 선택 코드
    try{
      _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(_pickedFile != null){
        _previewImage = FileImage(File(_pickedFile!.path));
        setState((){

        });
      }
    }
    catch(e){
      showSnackbar(context, '${e.toString()}');
    }
  }
  Future<String?> uploadWorkout(XFile? pickedFile) async {
    //이미지 upload 코드
    if(pickedFile == null) return null;
    return await _storage.uploadWorkoutImage(
        bytes: await pickedFile.readAsBytes(),
        path: pickedFile.path,
        pickedFileHash: pickedFile.hashCode
    );
  }
  String? newWorkoutTitle;
  int? newWorkoutMinutes;
  String? newWorkoutImageUrl; //Storage 취득한 이미지

  final _storage = FirebaseStorageService();
  final ImagePicker _picker=ImagePicker();
  ImageProvider? _previewImage;
  XFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme=Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorScheme.onPrimary
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 18,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                  '나만의 운동 추가하기',
                  style:textTheme.titleLarge?.copyWith(
                      color: colorScheme.shadow,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value){
                newWorkoutTitle=value;
              },
              decoration: InputDecoration(
                labelText: '운동명',
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                border: UnderlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              autofocus: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이미지',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.shadow,
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: _previewImage  !=null?DecorationImage(
                    image: _previewImage!,
                    fit: BoxFit.cover,
                  ):null,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '이미지 변경',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value){
                newWorkoutMinutes=int.parse(value);
              },
              decoration: InputDecoration(
                labelText: '운동 시간',
                labelStyle: textTheme.headlineSmall,
                border: UnderlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),

            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              color: colorScheme.primary,
            ),
            height: 50,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                uploadWorkout(_pickedFile);
                print(newWorkoutImageUrl);
                print(newWorkoutTitle);
                print(newWorkoutMinutes);
                Provider.of<MyWorkoutProvider>(context, listen: false).addMyWorkout(
                 MyWorkout(
                   name: newWorkoutTitle!,
                   minutes: newWorkoutMinutes!,
                   imageURL: newWorkoutImageUrl!,
                 )
                );
                //위와 같은 코드
                // context.read<MyWorkoutProvider>;
              },
              child: Text(
                '운동 추가',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}