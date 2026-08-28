import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/my_workout.dart';

class MyWorkoutProvider extends ChangeNotifier{
  final List<MyWorkout> _workouts = [
    MyWorkout(
      name: '어깨 스트레칭',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
      minutes: 10,
      workoutDays: [true, false, false, false, false, false, false,]
    ),
    MyWorkout(
      name: '전사 자세',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fwarrior_pose.png?alt=media&token=c4ab3994-c66d-458c-a53d-fa3e02ee5671',
      minutes: 15,
      workoutDays: [false, true, false, false, false, false, false,]
    ),
  ];
  List<MyWorkout> get workouts {
    return UnmodifiableListView(_workouts);
  }
  Future<void> addMyWorkout(MyWorkout myWorkout) async {
    _workouts.add(myWorkout);
    //db에 추가 기능
    notifyListeners();
  }

  Future<void> deleteMyWorkout(int deleteIndex) async {
    _workouts.removeAt(deleteIndex);
    //db에 추가 기능
    notifyListeners();
  }

  Future<void> updateMyWorkout({required List<bool> isSelected, required int workoutIndex,}) async{
    _workouts[workoutIndex].workoutDays=isSelected;
    notifyListeners();
  }

}