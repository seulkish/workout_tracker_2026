//my_workout_provider.dart
import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/my_workout.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';

class MyWorkoutProvider extends ChangeNotifier{
  final _firestoreService=FirestoreService();
  final _auth = FirebaseAuthService();
  final List<MyWorkout> _workouts = [
    // MyWorkout(
    //   name: '어깨 스트레칭',
    //   imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
    //   minutes: 10,
    //   workoutDays: [true, false, false, false, false, false, false,]
    // ),
    // MyWorkout(
    //   name: '전사 자세',
    //   imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fwarrior_pose.png?alt=media&token=c4ab3994-c66d-458c-a53d-fa3e02ee5671',
    //   minutes: 15,
    //   workoutDays: [false, true, false, false, false, false, false,]
    // ),
  ];
  List<MyWorkout> get workouts {
    return UnmodifiableListView(_workouts);
  }

  Future<void> fetchAllMyWorkouts() async{
    if(_auth.user == null) return ;
    final fetchedMyworkouts = await _firestoreService.fetchAllMyWorkouts(
        uid: _auth.user!.uid,
        limit:6,
        lastWorkout: _workouts.lastOrNull);
    _workouts.addAll(fetchedMyworkouts);
    notifyListeners();
  }

  Future<void> addMyWorkout(MyWorkout myWorkout) async {
    myWorkout.uid = _auth.user?.uid;
    await _firestoreService.createMyWorkout(myWorkout);
    _workouts.add(myWorkout);
    //db에 추가 기능
    notifyListeners();
  }

  Future<void> deleteMyWorkout(int deleteIndex) async {
    _firestoreService.deleteMyWorkout(_workouts[deleteIndex].id!);
    _workouts.removeAt(deleteIndex);
    //db에 추가 기능
    notifyListeners();
  }

  Future<void> updateMyWorkout({required List<bool> isSelected, required int workoutIndex,}) async{
    _firestoreService.updateMyWorkout(_workouts[workoutIndex]);
    _workouts[workoutIndex].workoutDays=isSelected;
    notifyListeners();
  }

}