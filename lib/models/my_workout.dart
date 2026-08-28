class MyWorkout {
  String name;
  String imageURL;
  int minutes;
  List<bool> workoutDays;

  MyWorkout({
    required this.name,
    required this.imageURL,
    required this.minutes,
    List<bool>? workoutDays,
  }):workoutDays=_normalizeDays(workoutDays);
  static List<bool> _normalizeDays(List<bool>? days){
    assert(days == null || days.length == 7, 'length가 7이어야 함');
    if(days == null){
      return List<bool>.filled(7,false,growable: false);
    }
    return List<bool>.of(days,growable: false);
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