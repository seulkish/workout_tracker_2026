//firestore_service.dart
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_tracker_2026/models/my_workout.dart';

class FirestoreService {
  FirebaseFirestore _fs = FirebaseFirestore.instance;

  //CRUD
  Future<void> createMyWorkout(MyWorkout myWorkout) async {
    try{
      final myWorkoutCollection = _fs.collection('myworkouts');
      final docRef = await myWorkoutCollection.add(myWorkout.toMap());
      await docRef.update({'id':docRef.id});
      // Map<String, dynamic> createData={
      //   'name':myWorkout.name,
      //   'minutes':myWorkout.minutes,
      //   'imageURL':myWorkout.imageURL,
      //   'workoutDays':myWorkout.workoutDays,
      // }; //firestore가 지원하는 5가지 타입으로 변환해서 넣기! - int, double, String, boolean,
      // await myWorkoutCollection.add(createData);
    }
    catch(e){
      throw Exception('db error: $e');
    }
  }
  Future<MyWorkout?> readMyWorkout(String workoutId) async {
    try{
      final myWorkoutCollection = _fs.collection('myworkouts');
      final documentRef = myWorkoutCollection.doc(workoutId);
      final documentSnapshot = await documentRef.get();
      if(!documentSnapshot.exists) throw Exception('no data');
      final mapData = documentSnapshot.data()!;

      return MyWorkout.fromMap(mapData);
    }
    catch(e){
      throw Exception('db error: $e');
    }
    return null;
  }

  Future<List<MyWorkout>> fetchAllMyWorkouts(
      {required String uid, int limit = 5, MyWorkout? lastWorkout}) async{
    try{
      final myWorkoutsCollection = _fs.collection('myworkouts');
      var query = myWorkoutsCollection
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt')
          .orderBy('id')
          .limit(limit);
      if(lastWorkout != null){
        query = query.startAfter([Timestamp.fromDate(lastWorkout.createdAt),lastWorkout.id]);
      }

      final querySnapshot = await query.get();
      final queryDocumentSnapshotList = querySnapshot.docs;
      List<MyWorkout> returnData = [];
      for(final doc in queryDocumentSnapshotList){
        final mapData = doc.data();
        returnData.add(MyWorkout.fromMap(mapData));
      }
      return returnData;
    }
    catch(e){throw Exception('db error: $e');}
  }
  Future<void> updateMyWorkout(MyWorkout myWorkout) async {
    try{
      final myWorkoutCollection = _fs.collection('myworkouts');
      final documentRef = myWorkoutCollection.doc(myWorkout.id);
      documentRef.update(myWorkout.toMap());
    }
    catch(e){
      throw Exception('db error: $e');
    }
  }
  Future<void> deleteMyWorkout(String workoutId) async {
    try{
      final myWorkoutCollection = _fs.collection('myworkouts');
      final documentRef = myWorkoutCollection.doc(workoutId);
      documentRef.delete();
    }
    catch(e){
      throw Exception('db error: $e');
    }
  }
}