import 'package:cloud_firestore/cloud_firestore.dart';

class MyWorkout {
  String? id;
  String name;
  String imageURL;
  int minutes;
  List<bool> workoutDays;
  String? uid;
  DateTime createdAt;

  MyWorkout({
    this.id,
    required this.name,
    required this.imageURL,
    required this.minutes,
    this.uid,
    List<bool>? workoutDays,
    DateTime? createdAt,
  }):workoutDays=_normalizeDays(workoutDays), createdAt=createdAt??DateTime.now();
  static List<bool> _normalizeDays(List<bool>? days){
    assert(days == null || days.length == 7, 'length가 7이어야 함');
    if(days == null){
      return List<bool>.filled(7,false,growable: false);
    }
    return List<bool>.of(days,growable: false);
  }

  factory MyWorkout.fromMap(Map<String, dynamic> mapData){
    print('type error: ${mapData['workoutDays']}');
    return MyWorkout(
      id: mapData['id'],
      uid: mapData['uid'],
      name: mapData['name'],
      imageURL: mapData['imageURL'],
      minutes: mapData['minutes'],
      workoutDays: List<bool>.from(mapData['workoutDays'] ?? []),
      createdAt: (mapData['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'minutes': minutes,
      'imageURL': imageURL,
      'workoutDays': workoutDays,
      'uid':uid,
      'createdAt': createdAt,
    };
  }

}



void sample() {
  MyWorkout(
    name: 'adf',
    imageURL: 'asdfas',
    minutes: 22,
    workoutDays: null,
  );
  MyWorkout(
    name: 'adf',
    imageURL: 'asdfas',
    minutes: 22,
    workoutDays: [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
    ],
  );
}